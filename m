Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101209144103.GA30557@jh-x301>
References: <3b53a90114d801b0adba526895deed74.squirrel@www.codeaurora.org>
	<20101209144103.GA30557@jh-x301>
Date: Fri, 10 Dec 2010 11:51:16 +0200
Message-ID: <AANLkTik78DiC7TgWtR0q=xPs+ZZq470_md-gJWv8tB8f@mail.gmail.com>
Subject: Re: A2DP reconfigure with BMW Carkit (supporting multi streams) timeouts.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: roystonr@codeaurora.org, linux-bluetooth@vger.kernel.org,
	skrovvid@codeaurora.org, rshaffer@codeaurora.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 9, 2010 at 4:41 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Royston,
>
> On Thu, Dec 09, 2010, roystonr@codeaurora.org wrote:
>> Change expected:
>> avdtp_get_seps should be able to provide the SEP of the one used in the
>> AVDTP_CLOSE previously. But there weren't any previously closed streams
>> then provide the SEP which is not in use (as done currently).
>>
>> Kindly let us know whether our understanding is right and can this be a
>> suspected cause of the issue seen. Correct if mistaken.
>
> Sounds like that might be the cause. Have you experimented with patching
> the bluez code to reuse the same SEP as was used for the Close? If not
> I'd advice you to do that so we can be sure that a change to the ACP SEP
> selection logic makes sense.
>
> Right now the reconfiguration happens in audio/a2dp.c where there's a
> setup->reconfigure flag to track if a new stream should be configured
> after receiving close_ind. The a2dp_reconfigure function in a2dp.c is
> responsible for selecting the remote SEP. Could you try the attached
> (completely untested) patch to see if it helps? It stores the old remote
> SEP in the setup structure when starting the Close procedure in which
> case a2dp_reconfigure() shouldn't try to reselect a new remote SEP but
> use the stored one instead.

I guess it would be better to have the call to
avdtp_stream_get_remote_sep on close_cfm, it is probably safer to do
there and less code too, but the fix is probably right.

-- 
Luiz Augusto von Dentz
Computer Engineer
