Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2 8/8] Bluetooth: Add Slave Page Response Timeout Event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380712218-9269-9-git-send-email-dh79.pyun@samsung.com>
Date: Wed, 2 Oct 2013 13:46:44 +0200
Cc: linux-bluetooth@vger.kernel.org, steve.jun@samsung.com,
	DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Message-Id: <34B4E475-5C0D-45BF-B9F9-1B47016F7636@holtmann.org>
References: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com> <1380712218-9269-9-git-send-email-dh79.pyun@samsung.com>
To: Dohyun Pyun <re20sfree@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dohyun,

> The Slave Page Response Timeout event indicates to the Host that a
> slave page response timeout has occurred in the BR/EDR Controller.
> 
> The Core Spec Addendum 4 adds this command in part B Connectionless
> Slave Broadcast.
> 
> Bluetooth Core Specification Addendum 4 - Page 110
> 
> "7.7.67 Synchronization Train Complete Event [New Section]
> ...
> Note: this event will be generated if the slave BR/EDR Controller
> responds to a page but does not receive the master FHS packet
> (see Baseband, Section 8.3.3) within pagerespTO.
> 
> Event Parameters: NONE"
> 
> Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
> Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
> ---
> include/net/bluetooth/hci.h | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 8ec8ee8..34580f1 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1508,6 +1508,8 @@ struct hci_ev_sync_train_complete {
> 	__u8	status;
> } __packed;
> 
> +#define HCI_EV_SLAVE_PAGE_RESP_TIMEOUT	0x54
> +

I do not know how clearly I can make myself. These structs and defines are done in order of either opcode or event code. So please get this right.

Regards

Marcel

