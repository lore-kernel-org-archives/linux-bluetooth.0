Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Feb 2012 17:16:16 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemant.gupta@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemantgupta.ste@gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix clearing of debug and linkkey flags
Message-ID: <20120202011616.GA12782@x220.globalsuite.net>
References: <1327313171-20544-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327313171-20544-1-git-send-email-hemant.gupta@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Mon, Jan 23, 2012, Hemant Gupta wrote:
> This patch fixes clearing of HCI_LINK_KEYS and HCI_DEBUG_KEYS
> dev_flags while resetting. Without this patch pairing does
> not work over management interface for BR-EDR devices.
> 
> Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
> ---
>  net/bluetooth/hci_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Applied to my bluetooth-next tree. Thanks.

Johan
