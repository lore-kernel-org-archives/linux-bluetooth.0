Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5925869.iVRXt7vIOW@uw000953>
References: <1350391036-29997-1-git-send-email-szymon.janc@tieto.com>
	<15890511.ludKIz2NbJ@uw000953>
	<CABBYNZKQWy2CmM2FLZyw24UXEo202SsHymK-jzGF+k2dmg6brw@mail.gmail.com>
	<5925869.iVRXt7vIOW@uw000953>
Date: Wed, 17 Oct 2012 12:32:30 +0200
Message-ID: <CABBYNZJqruuAMt=FTvry3Oh6RDrHFifkXohS2ZuJ6yYS5t4CQA@mail.gmail.com>
Subject: Re: [PATCH] avdtp: Fix crash on connection lost
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 17, 2012 at 12:17 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> On Wednesday 17 of October 2012 11:48:36 Luiz Augusto von Dentz wrote:
>> Hi Szymon,
>
> Hi Luiz,
>
>> >> We should probably get rid of the free_lock as well.
>> >
>> > Well, this is what this patch does, doesn't it?:)
>>
>> What about the attached patch, it should fix the references for good
>> by using the dc_timer when the reference drops to 0, I just need to
>> check if 1 second is enough to cover all cases including the ones
>> where the remote device connects but doesn't setup any stream, with
>> the devices I have 1 second seems enough.
>
> Yeap, this fix crash I've observed.
>
> However, avdtp_get_internal() now returns newly created session with ref=0
> and in avdtp_confirm_cb() there is unref called when btd_request_authorization
> failed. Due to ref being signed int (why?) this could lead to not-nice-to-debug
> bug if that session is reclaimed before dc timer fires (ref would go from -1 to
> 0).

Good catch, I should be able to fix this, perhaps we can free
immediately or let the timeout handle this as well.

> Also I'm having trouble with tracking lifetime of session object.. I think
> only avdtp_ref/unref function should really care about ref count. That would
> require other function to only use ref/unref to get/free session object.
> e.g. avdtp_free should be only called from disconnect_timeout() and
> connection_lost() should only trigger other session users to drop their
> references. Same goes to set_disconnect_timer() which should only be called
> from avdtp_unref. There should be no need to call connection_lost from
> disconnect_timeout as this timer should only run when there is no references
> held to that session, right?

Well that involves changing some other logic behind the timeout, such as this:

		if (session->ref == 0 && !session->streams && !session->req)
			set_disconnect_timer(session);

		if (session->streams && session->dc_timer)
			remove_disconnect_timer(session);

IMO those should be removed in favor of the ref/unref handling if the
disconnect timer should be started/removed, if there is a request the
user should be holding a reference and the same for the stream, this
should actually simplify even further the code. Also the reason I did
avdtp_free in the connection_lost was not to much too much code around
as avdtp_free call a lot of other functions, but you are probably
right and this should actually be called from disconnect_timeout.

-- 
Luiz Augusto von Dentz
