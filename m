Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 May 2011 10:50:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ilia Kolomisnky <ilia.kolominsky@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Ilia Kolomisnky <iliak@ti.com>
Subject: Re: [PATCH v4] Fix response for vendor dependent AVRCP commands
Message-ID: <20110531075011.GA18717@dell.ger.corp.intel.com>
References: <1306809169-5050-1-git-send-email-iliak@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306809169-5050-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilia,

On Tue, May 31, 2011, Ilia Kolomisnky wrote:
> AVRCP TG now returns a REJECTED response with the "Invalid command"
> error code for VENDOR DEPENDENT commands. This fixes test case
> AVRCP/TG/INV/TC_TG_INV_BI_01_C with recent PTS version.
> ---
>  audio/control.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 37 insertions(+), 0 deletions(-)

Thanks for the quick update. I did a few more cosmetic changes myself
and pushed the patch upstream.

Johan
