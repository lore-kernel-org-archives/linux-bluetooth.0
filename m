Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120821185606.GF17005@joana>
References: <1344710830-10301-1-git-send-email-djenkins@mvista.com>
	<1344710830-10301-4-git-send-email-djenkins@mvista.com>
	<20120821185606.GF17005@joana>
Date: Thu, 30 Aug 2012 16:36:00 +0100
Message-ID: <CAJ2qBzaO=MOaGsiHjHehXE97wt0sG2O6gOQZsFYsmpTj+gchPA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Avoid rfcomm_session_timeout using freed pointer
From: Dean Jenkins <djenkins@mvista.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Dean Jenkins <djenkins@mvista.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 21 August 2012 19:56, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Dean,
>
> * Dean Jenkins <djenkins@mvista.com> [2012-08-11 19:47:09 +0100]:
>
>> rfcomm_session_timeout() protects the scenario of the remote
>> Bluetooth device failing to send a DISC on the rfcomm control
>> channel after the last data DLC channel has been closed.
>>
>> There is a race condition between the timer expiring causing
>> rfcomm_session_timeout() to run and the rfcomm session being
>> deleted. If the rfcomm session is deleted then
>> rfcomm_session_timeout() would use a freed rfcomm session
>> pointer resulting in a potential kernel crash or memory corruption.
>> Note the timer is cleared before the rfcomm session is deleted
>> by del_timer() so the circumstances for a failure to occur are
>> as follows:
>>
>> rfcomm_session_timeout() needs to be executing before the
>> del_timer() is called to clear the timer but
>> rfcomm_session_timeout() needs to be delayed from using the
>> rfcomm session pointer until after the session has been deleted.
>> Therefore, there is a very small window of opportunity for failure.
>>
>> The solution is to use del_timer_sync() instead of del_timer()
>> as this ensures that rfcomm_session_timeout() is not running
>> when del_timer_sync() returns. This means that it is not
>> possible for rfcomm_session_timeout() to run after the rfcomm
>> session has been deleted.
>
>>
>> Signed-off-by: Dean Jenkins <djenkins@mvista.com>
>> ---
>>  net/bluetooth/rfcomm/core.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index 24d4d3c..c7921fd 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -264,8 +264,8 @@ static void rfcomm_session_clear_timer(struct rfcomm_session *s)
>>  {
>>       BT_DBG("session %p state %ld", s, s->state);
>>
>> -     if (timer_pending(&s->timer))
>> -             del_timer(&s->timer);
>> +     /* ensure rfcomm_session_timeout() is not running past this point */
>> +     del_timer_sync(&s->timer);
>
> I'm not happy of the idea of let the stack broken between patches 2 and 3
> (this one). As you said if we use del_timer_sync() we don't need rfcnt here,
> can you add this as a first patch, maybe? and after this continue to remove
> the rest of the refcount code?
>
>         Gustavo

Thanks for your feedback. Sorry for the delay in getting back to you.
My gmail failed to filter out your reply.

OK, I'll start with a patch for del_timer_sync(). This can be a
standalone patch.

For the removal of the refcnt, do you propose 1 patch to remove the
refcnt AND to manage the rfcomm session pointer ? I have doubts now
because you don't wish the stack to be broken between patches. Perhaps
it is possible to add a patch to manage the rfcomm session pointer
with the refcnt in place so we have "belt and braces" then have a
patch to remove the refcnt as the last thing to do.

I am open to suggestions.

Thanks,

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
