Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 15/16] Bluetooth: Support LE-Only discovery procedure
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Aug 2011 06:52:03 -0700
In-Reply-To: <1311623405-31108-16-git-send-email-andre.guedes@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
	 <1311623405-31108-16-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312984325.3373.119.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds support for LE-Only discovery procedure through
> management interface.
> 
> A new flag (HCI_LE_SCAN) was created to inform if the controller is
> performing LE scan. The HCI_LE_SCAN flag is set/cleared when the
> controller starts/stops scanning.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |    2 ++
>  net/bluetooth/hci_event.c   |   39 ++++++++++++++++++++++++++++++++++++---
>  net/bluetooth/mgmt.c        |    5 +++++
>  3 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index fb40388..c4fdeeb 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -86,6 +86,8 @@ enum {
>  	HCI_DEBUG_KEYS,
>  
>  	HCI_RESET,
> +
> +	HCI_LE_SCAN,
>  };

I am really against adding any new flags here. This is a public API and
a horrible one actually.

We need to have these states internal and stop adding more flags to this
public API.

Regards

Marcel


