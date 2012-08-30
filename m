Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120821185029.GE17005@joana>
References: <1344710830-10301-1-git-send-email-djenkins@mvista.com>
	<1344710830-10301-5-git-send-email-djenkins@mvista.com>
	<20120821185029.GE17005@joana>
Date: Thu, 30 Aug 2012 16:40:48 +0100
Message-ID: <CAJ2qBzYbDUt3M4VHvB4DL=dWfNTXvPxvyvaVoEMKCUJ67Jcqcw@mail.gmail.com>
Subject: Re: [PATCH 4/4] Bluetooth: On socket shutdown check rfcomm session
 and DLC exists
From: Dean Jenkins <djenkins@mvista.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Dean Jenkins <djenkins@mvista.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 21 August 2012 19:50, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Dean,
>
> * Dean Jenkins <djenkins@mvista.com> [2012-08-11 19:47:10 +0100]:
>
>> A race condition exists between near simultaneous asynchronous
>> DLC data channel disconnection requests from the host and remote device.
>> This causes the socket layer to request a socket shutdown at the same time
>> the rfcomm core is processing the disconnect request from the remote
>> device.
>>
>> The socket layer retains a copy of a struct rfcomm_dlc d pointer.
>> The d pointer refers to a copy of a struct rfcomm_session.
>> When the socket layer thread performs a socket shutdown, the thread
>> may wait on a rfcomm lock in rfcomm_dlc_close(). This means that
>> whilst the thread waits, the rfcomm_session and/or rfcomm_dlc structures
>> pointed to by d maybe freed due to rfcomm core handling. Consequently,
>> when the rfcomm lock becomes available and the thread runs, a
>> malfunction could occur as a freed rfcomm_session pointer and/or a
>> freed d pointer will be erroneously reused.
>>
>> Therefore, after the rfcomm lock is acquired, check that the struct
>> rfcomm_session is still valid by searching the rfcomm session list.
>> If the session is valid then validate the d pointer by searching the
>> rfcomm session list of active DLCs for the rfcomm_dlc structure
>> pointed by d.
>>
>> If active DLCs exist when the rfcomm session is terminating,
>> avoid a memory leak of rfcomm_dlc structures by ensuring that
>> rfcomm_session_close() is used instead of rfcomm_session_del().
>>
>> Signed-off-by: Dean Jenkins <djenkins@mvista.com>
>> ---
>>  net/bluetooth/rfcomm/core.c |   29 ++++++++++++++++++++++++++---
>>  1 file changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> index c7921fd..1a7db34 100644
>> --- a/net/bluetooth/rfcomm/core.c
>> +++ b/net/bluetooth/rfcomm/core.c
>> @@ -496,11 +496,34 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
>>
>>  int rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
>>  {
>> -     int r;
>> +     int r = 0;
>> +     struct rfcomm_dlc *d_list;
>> +     struct rfcomm_session *s, *s_list;
>> +     struct list_head *p, *n, *p2, *n2;
>>
>>       rfcomm_lock();
>>
>> -     r = __rfcomm_dlc_close(d, err);
>> +     s = d->session;
>> +     if (s) {
>
> Please invert the check here, and add a goto unlock;. There too many
> indentation levels here.
>
>> +             /* check the session still exists after waiting on the mutex */
>> +             list_for_each_safe(p, n, &session_list) {
>> +                     s_list = list_entry(p, struct rfcomm_session, list);
>
> please use list_for_each_entry(), the _safe version seems to not be needed.
>
>> +                     if (s == s_list) {
>> +                             /* check the dlc still exists */
>> +                             /* after waiting on the mutex */
>> +                             list_for_each_safe(p2, n2, &s->dlcs) {
>> +                                     d_list = list_entry(p2,
>> +                                                     struct rfcomm_dlc,
>> +                                                     list);
>
>
> and here you can use rfcomm_dlc_get()
>
>         Gustavo

Thanks for your feedback. Sorry for the delay getting back to you. I
blame gmail.

OK, I will take a look at redoing the patch as per your suggestion.

Thanks,

Regards,
Dean

-- 
Dean Jenkins
Embedded Software Engineer
Professional Services UK/EMEA
MontaVista Software, LLC
