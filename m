Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 4/8] Bluetooth: Add Write Synchronization Train Parameters Command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380705078-22154-5-git-send-email-dh79.pyun@samsung.com>
Date: Wed, 2 Oct 2013 11:34:29 +0200
Cc: linux-bluetooth@vger.kernel.org, steve.jun@samsung.com,
	DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Message-Id: <9155C4A6-C612-4A08-92EF-1EB1564FB052@holtmann.org>
References: <1380705078-22154-1-git-send-email-dh79.pyun@samsung.com> <1380705078-22154-5-git-send-email-dh79.pyun@samsung.com>
To: Dohyun Pyun <re20sfree@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun,

> The Write_Synchronization_Train_Parameters command configures
> the Synchronization Train functionality in the BR/EDR Controller.
> 
> The Core Spec Addendum 4 adds this command in part B Connectionless
> Slave Broadcast.
> 
> Bluetooth Core Specification Addendum 4 - Page 97
> 
> "7.3.90 Write Synchronization Train Parameters Command [New Section]
> ...
> Note: The AFH_Channel_Map used in the Synchronization Train packets is
> configured by the Set_AFH_Channel_Classification command and the local
> channel classification in the BR/EDR Controller.
> 
> Interval_Min and Interval_Max specify the allowed range of
> Sync_Train_Interval. Refer to [Vol. 2], Part B, section 2.7.2 for
> a detailed description of Sync_Train_Interval. The BR/EDR Controller shall
> select an interval from this range and return it in Sync_Train_Interval.
> If the Controller is unable to select a value from this range, it shall
> return the Invalid HCI Command Parameters (0x12) error code.
> 
> Once started (via the Start_Synchronization_Train Command) the
> Synchronization Train will continue until synchronization_trainTO slots have
> passed or Connectionless Slave Broadcast has been disabled."
> 
> Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
> Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
> ---
> include/net/bluetooth/hci.h | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index d5a0da0..6579bd3 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -870,6 +870,18 @@ struct hci_rp_set_clb_data {
> 	__u8 lt_addr;
> } __packed;
> 
> +#define HCI_OP_WRITE_SYNC_TRAIN_PARAMS	0x0c78
> +struct hci_cp_write_sync_train_params {
> +	__le16 interval_min;
> +	__le16 interval_max;
> +	__le32 sync_train_tout;
> +	__u8 service_data;
> +} __packed;
> +struct hci_rp_write_sync_train_params {
> +	__u8 status;
> +	__le16 sync_train_int;
> +} __packed;
> +
> #define HCI_OP_READ_SYNC_TRAIN_PARAMS	0x0c77

we sort commands in order and 0c78 comes after 0xc77.

Regards

Marcel

