Return-Path: <cyrus@holtmann.org>
Date: Wed, 14 Jul 2010 14:08:22 -0300
From: "Hedberg Johan (Nokia-D/Helsinki)" <johan.hedberg@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Additional handling incoming call indication for HS
Message-ID: <20100714170822.GA12447@jh-x301>
References: <1279120839-14050-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279120839-14050-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Jul 14, 2010, Radoslaw Jablonski wrote:
> Some headsets expect incoming call indication before they can send ATA
> command. In current implementation of telephony we do not send outband
> notyfication about incoming call when call previously was in WAITING
> state. And without that kind of notyfication BH-108 and BackBeat 903
> headset cannot send ATA command - user is unable to answer to that call
> from headset.
> 
> Added handling for that case in func handle_call_status(). When phone now
> is in CSD_CALL_STATUS_MT_ALERTING and previously was in
> CSD_CALL_STATUS_WAITING that means we need to send incoming call
> notyfication (it was not sent earlier because new call was waiting for end
> of active call). This will send RING commands to headset if it is needed.
> ---
>  audio/telephony-maemo6.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)

Thanks. The patch is now pushed upstream.

Johan
