Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1273676372.3239.21.camel@mosquito>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
	 <1273486527-7855-2-git-send-email-sancane@gmail.com>
	 <1273486527-7855-3-git-send-email-sancane@gmail.com>
	 <1273486527-7855-4-git-send-email-sancane@gmail.com>
	 <1273486527-7855-5-git-send-email-sancane@gmail.com>
	 <1273486527-7855-6-git-send-email-sancane@gmail.com>
	 <1273486527-7855-7-git-send-email-sancane@gmail.com>
	 <1273486527-7855-8-git-send-email-sancane@gmail.com>
	 <AANLkTikhyI_MBRgVAV3CpQ7_bSqUXqKdkarY1VTI_kI-@mail.gmail.com>
	 <1273676372.3239.21.camel@mosquito>
Date: Wed, 12 May 2010 12:11:54 -0300
Message-ID: <AANLkTimJXk92OidVxQRLvUuqh6B1C7tiLzZ347WmWdf7@mail.gmail.com>
Subject: Re: [PATCH 08/25] Profiles using MCAP can close a MCL deciding if it
	should be cached
From: Raul Herbster <raul.herbster@signove.com>
To: Santiago Carot-Nemesio <scarot@libresoft.es>
Cc: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

2010/5/12 Santiago Carot-Nemesio <scarot@libresoft.es>:
> Hello Raul,
>
> El mié, 12-05-2010 a las 11:33 -0300, Raul Herbster escribió:
>> Hi Santiago,
>>
>> 2010/5/10 Santiago Carot-Nemesio <sancane@gmail.com>:
>> > From: Santiago Carot Nemesio <sancane@gmail.com>
>> >
>> > ---
>> >  mcap/mcap.c |   17 +++++++++++++++++
>> >  1 files changed, 17 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/mcap/mcap.c b/mcap/mcap.c
>> > index 0112154..8f6fb78 100644
>> > --- a/mcap/mcap.c
>> > +++ b/mcap/mcap.c
>> > @@ -305,6 +305,23 @@ static void mcap_uncache_mcl(struct mcap_mcl *mcl)
>> >        mcl->ctrl &= ~MCAP_CTRL_FREE;
>> >  }
>> >
>> > +void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache)
>> > +{
>> > +       if (!mcl)
>> > +               return;
>> > +
>> > +       if (mcl->cc) {
>> > +               g_io_channel_shutdown(mcl->cc, TRUE, NULL);
>> > +               g_io_channel_unref(mcl->cc);
>> > +               mcl->cc = NULL;
>> > +       }
>> > +
>> > +       mcl->state = MCL_IDLE;
>> > +
>> > +       if (!cache)
>> > +               mcl->ctrl |= MCAP_CTRL_NOCACHE;
>> > +}
>> > +
>>
>> According to MCAP spec (page 10, section 2.1.2), when the CC is
>> closed, all of its associated DCs are closed as well. In fact, DCs are
>> propely closed on mcap_mcl_free , but not on mcap_close_mcl. So, which
>> one really closes MCL?
>
> That's rigth and if you see the source code, the control channel is
> closed using "shutdown", when above function is called the control
> channel is closed. Then watcher function associated with the control
> channel is executed "mcl_control_cb". Here you will see that MCL is
> closed by calling to "mcap_cache_mcl". At thye end of that function the
> mcl is shutting down (function mcl_shutdown) and control channel and all
> data channels are closed. You can see the code to check that all is
> right.

Ok. I´ve got it and the code is right. The suggestion is just on
function name. mcap_close_mcl does not really closes a MCL,
but "shutdown" does :)

>
> Please, study the code in deep before assert that the code doesn't work,
> of course that it may be errors, but testing and playing with the code
> can help to you to discard false positives.
>
> Regards
>
>> []´s
>> --Raul
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
