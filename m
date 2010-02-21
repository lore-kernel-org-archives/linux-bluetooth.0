Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100221134631.GA25639@jh-x301>
References: <eb7933e21002190820x7b2b0ea3v3f48ce96a5d11a1e@mail.gmail.com>
	 <20100219173257.GA12855@jh-x301>
	 <eb7933e21002210454r4b3805e1pec3f4f58440191bf@mail.gmail.com>
	 <20100221134631.GA25639@jh-x301>
Date: Sun, 21 Feb 2010 19:53:10 +0200
Message-ID: <2d5a2c101002210953l4ef26078j25f4cc31758b80a7@mail.gmail.com>
Subject: Re: [PATCH] Fix double free on AVDTP Abort response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, Feb 21, 2010 at 3:46 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Daniel,
>
> On Sun, Feb 21, 2010, Daniel Örstadius wrote:
>> > Please try to at least do a compile check before you submit patches.
>> > This one gives the following error:
>> > audio/avdtp.c: In function ‘handle_unanswered_req’:
>> > audio/avdtp.c:908: error: comparison between pointer and integer
>> >
>> > What you probably want is session->req->signal_id == AVDTP_ABORT.
>> >
>>
>> Sorry. The attached patch compiles without warnings on "./configure && make".
>> (new dependency to a capabilities lib prevents ./bootstrap-configure atm)
>
> You can avoid that with "./bootstrap-configure --disable-capng"
>
>> The pending request might be freed twice when receiving an Abort
>> response, in handle_unanswered_req and session_cb. Avoid freeing
>> it in handle_unanswered_req.
>> ---
>>  audio/avdtp.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> Thanks, the patch is now upstream.

While discussing this problem we find out that our timeout doesn't
really work as we imagine due to the possibility of abort being
rejected, so either we don't call any callback on timeout and do it on
abort response while changing to aborting state (which probably means
4-8 sec before we are really able to abort/cancel) or we disconnect as
the other end seems to not cooperate on aborting.

Btw, we probably should have a smaller timeout for avdtp_abort anyway
and make sure we call it upon RequestDisconnect not avdtp_close which
has no priority over the others commands.

Regards,

-- 
Luiz Augusto von Dentz
Computer Engineer
