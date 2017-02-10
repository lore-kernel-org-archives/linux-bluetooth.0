Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] rtlbt: Add Realtek Bluetooth profiling support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170209182341.4977-1-Larry.Finger@lwfinger.net>
Date: Fri, 10 Feb 2017 12:09:12 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Alex Lu <alex_lu@realsil.com.cn>, linux-kernel@vger.kernel.org
Message-Id: <485E2AC8-A0F6-4D02-9CB0-D73A231E6FB5@holtmann.org>
References: <20170209182341.4977-1-Larry.Finger@lwfinger.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Larry,

> Add the Realtek Bluetooth profile profiling support to create
> profile information, which helps the firmware optimize transfer
> priority and balance the transmissions for multiple profiles.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
> drivers/bluetooth/Kconfig    |   16 +
> drivers/bluetooth/Makefile   |    1 +
> drivers/bluetooth/btusb.c    |   12 +
> drivers/bluetooth/rtl_btpf.c | 1249 ++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/rtl_btpf.h |  184 +++++++
> 5 files changed, 1462 insertions(+)
> create mode 100644 drivers/bluetooth/rtl_btpf.c
> create mode 100644 drivers/bluetooth/rtl_btpf.h
> 

<snip>

> +static int btpf_open_socket(struct rtl_btpf *btpf)
> +{
> +	int ret;
> +	struct sockaddr_hci addr;
> +	struct sock *sk;
> +	struct hci_filter flt;
> +
> +	ret = sock_create_kern(&init_net, PF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI,
> +			       &btpf->hci_sock);
> +	if (ret < 0) {
> +		rtlbt_err("Create hci sock error %d", ret);
> +		goto err_1;
> +	}
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.hci_family = AF_BLUETOOTH;
> +	/* Assume Realtek BT controller index is 0. */
> +	addr.hci_dev = 0;
> +	addr.hci_channel = HCI_CHANNEL_RAW;
> +	ret = kernel_bind(btpf->hci_sock, (struct sockaddr *)&addr,
> +			  sizeof(addr));
> +	if (ret < 0) {
> +		rtlbt_err("Bind hci sock error");
> +		goto err_2;
> +	}

let me start with a clear answer here. This is insane and will never be merged upstream.

I have no idea on how describe this any other way, but this is really bad idea, totally bloated and causing side affects left and right. The HCI raw socket is not for doing profiling. Especially not inside the kernel. And just thinking that someone took the old hcidump code and hacked it to run as a kernel module is something I never expected to happen.

<snip>

> +
> +#define HCI_VENDOR_SET_PF_REPORT_CMD	0xfc19
> +#define HCI_VENDOR_SET_BITPOOL_CMD	0xfc51

I think that everything should start with what these two vendor commands are actually doing. So a simple descriptions of these two vendor commands is what is needed first.

And then someone needs to tell me what all this code does that SO_PRIORITY is not already doing and has been doing for a long time.

Regards

Marcel
