Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Nov 2010 17:24:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH] hciattach: send hci commands after hci socket bring up
Message-ID: <20101119152454.GB28815@jh-x301>
References: <1290145903-11452-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290145903-11452-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Nov 19, 2010, Suraj Sumangala wrote:
> This patch makes The Atheros AR300x specific initialization code
> to send power management command over HCI socket after bringing up
> the device.
> 
> ---
>  tools/hciattach_ath3k.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)

Thanks. The patch has been pushed upstream.

Johan
