Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 16:06:18 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 13/15] Bluetooth: LE scan infra-structure
Message-ID: <20111006190618.GJ5652@joana>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
 <1317856847-28167-14-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317856847-28167-14-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-10-05 20:20:45 -0300]:

> This patch adds to hci_core the infra-structure to carry out the
> LE scan. Functions were created to init the LE scan and cancel
> an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).
> 
> Also, the HCI_LE_SCAN flag was created to inform if the controller
> is performing LE scan. The flag is set/cleared when the controller
> starts/stops scanning.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    2 +
>  include/net/bluetooth/hci_core.h |    5 +++
>  net/bluetooth/hci_core.c         |   69 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |    4 ++
>  4 files changed, 80 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 11537b8..7520544 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -86,6 +86,8 @@ enum {
>  	HCI_DEBUG_KEYS,
>  
>  	HCI_RESET,
> +
> +	HCI_LE_SCAN,

I remember that Marcel commented against this here. Let's hide this
internally.

	Gustavo
