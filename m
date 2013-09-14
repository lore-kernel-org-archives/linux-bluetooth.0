Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 2/2] Bluetooth: Add event mask page 2 setting support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379061602-8290-3-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Sep 2013 18:35:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <49AE7668-B559-42DC-BF73-59A574C23C96@holtmann.org>
References: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com> <1379061602-8290-3-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> For those controller that support the HCI_Set_Event_Mask_Page_2 command
> we should include it in the init sequence. This patch implements sending
> of the command and enables the events in it based on supported features
> (currently only CSB is checked).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  2 ++
> net/bluetooth/hci_core.c    | 32 ++++++++++++++++++++++++++++++++
> 2 files changed, 34 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 63cce97..57aa408 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -827,6 +827,8 @@ struct hci_rp_read_inq_rsp_tx_power {
> 	__s8     tx_power;
> } __packed;
> 
> +#define HCI_OP_SET_EVENT_MASK_PAGE_2	0x0c63
> +

I am a little bit torn here. We define the struct for event mask, but never use it. Now we only define the opcode. So either we add the struct here for completeness sake or you add a cleanup patch that removes the event mask struct.

Otherwise, the patch is fine.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

