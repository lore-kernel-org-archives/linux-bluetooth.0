Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Nov 2010 12:11:32 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
Subject: Re: [PATCH v2] hciattach: download configuration at user requested
 baud rate
Message-ID: <20101123111132.GB4245@jh-x301>
References: <1290509963-11918-1-git-send-email-suraj@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290509963-11918-1-git-send-email-suraj@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Tue, Nov 23, 2010, Suraj Sumangala wrote:
> This patch support downloading configuration for
> Atheros AR300x HCI UART chip at user requested baud rate
> instead of the initial baud rate.
> ---
>  tools/hciattach.c       |    2 +-
>  tools/hciattach.h       |    3 +-
>  tools/hciattach_ath3k.c |   98 +++++++++++++++++++++++++++++++++-------------
>  3 files changed, 73 insertions(+), 30 deletions(-)

Thanks for the update. Now this patch is also pushed upstream.

Johan
