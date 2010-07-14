Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jul 2010 11:33:24 -0300
From: "Hedberg Johan (Nokia-D/Helsinki)" <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Additional handling incoming call indication for HS
Message-ID: <20100714143324.GA2939@jh-x301>
References: <1279116737-27025-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1279116737-27025-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 14, 2010, Radoslaw Jablonski wrote:
> Some headsets expect incoming call indication before they can send ATA
> command. In current implementation of telephony we do not send outband
> notyfication about incoming call when call previously was in WAITING state.
> And without that kind of notyfication BH-108 and BackBeat 903 headset cannot
> send ATA command - user is unable to answer to that call from headset.
> 
> Added handling for that case in func handle_call_status(). When phone now is
> in CSD_CALL_STATUS_MT_ALERTING and previously was in CSD_CALL_STATUS_WAITING
> that means we need to send incoming call notyfication (it was not sent earlier
> because new call was waiting for end of active call). This will send RING
> commands to headset if it is needed.
> ---
>  audio/telephony-maemo6.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)

Thanks for the patch. There are a few issues that'll need to be fixed
before pushing it upstream. The most serious one is this:

audio/telephony-maemo6.c: In function ‘handle_call_status’:
audio/telephony-maemo6.c:1007: error: comparison between signed and
unsigned integer expressions

Please always check compilation with ./bootstrap-configure since that'll
cause any warnings to show up as errors.

Another issue is the commit message width. Please keep it at a maximum
of 74 characters so that it's nicely viewable using git log on a
80-character wide terminal.

And then the following (minor) whitespace issue:

> +		if(prev_status == CSD_CALL_STATUS_WAITING)

There should be a space between the if and the parenthesis. Otherwise
the patch was fine. So please fix these issues and resubmit. Thanks.

Johan
