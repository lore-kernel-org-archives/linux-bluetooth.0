Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [RFC 3/5] l2cap: Pass hci_dev to l2cap_chan_connect()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457091644-21536-4-git-send-email-patrik.flykt@linux.intel.com>
Date: Fri, 4 Mar 2016 09:29:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EB0AD882-3FEB-4076-9FED-83FC3699A685@holtmann.org>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com> <1457091644-21536-4-git-send-email-patrik.flykt@linux.intel.com>
To: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrik,

> Since the Bluetooth Management Interface already associates
> commands with a hci_dev, pass the hci_dev when calling
> l2cap_chan_connect(). This indicates which specific hci_dev to
> use for the l2cap connection and will be useful when connecting
> or disconnecting Bluetooth IPSP.
> 
> Modify the existing code to do a hci_dev lookup before calling
> connect.
> 
> Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
> ---
> include/net/bluetooth/l2cap.h | 4 ++--
> net/bluetooth/6lowpan.c       | 4 +++-
> net/bluetooth/l2cap_core.c    | 6 ++----
> net/bluetooth/l2cap_sock.c    | 5 ++++-
> 4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 5ee3c68..b65ca60 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -926,8 +926,8 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
> 
> struct l2cap_chan *l2cap_chan_create(void);
> void l2cap_chan_close(struct l2cap_chan *chan, int reason);
> -int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> -		       bdaddr_t *dst, u8 dst_type);
> +int l2cap_chan_connect(struct l2cap_chan *chan, struct hci_dev *hdev,
> +			__le16 psm, u16 cid, bdaddr_t *dst, u8 dst_type);

actually lets not do that. I am pretty much against hacking just more parameters into this function. Do that in the l2cap_chan abstraction. It already knows which hci_dev it needs to pick.

Regards

Marcel

