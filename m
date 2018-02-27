Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2] shared/mgmt: Make mgmt_new_default return the same
 instance
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180227083430.7700-1-luiz.dentz@gmail.com>
Date: Tue, 27 Feb 2018 12:30:06 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3D9FC6B1-D82A-45BD-A470-C2422DC9F0DF@holtmann.org>
References: <20180227083430.7700-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> If an instance already exists there is no reason to create a second one
> as they both will bind to HCI_CHANNEL_CONTROL.
> ---
> src/shared/mgmt.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
> 
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 277e361a6..716c44289 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -81,6 +81,8 @@ struct mgmt_notify {
> 	void *user_data;
> };
> 
> +static struct mgmt *default_mgmt;
> +
> static void destroy_request(void *data)
> {
> 	struct mgmt_request *request = data;
> @@ -432,6 +434,9 @@ struct mgmt *mgmt_new_default(void)
> 	} addr;
> 	int fd;
> 
> +	if (default_mgmt)
> +		return mgmt_ref(default_mgmt);
> +
> 	fd = socket(PF_BLUETOOTH, SOCK_RAW | SOCK_CLOEXEC | SOCK_NONBLOCK,
> 								BTPROTO_HCI);
> 	if (fd < 0)
> @@ -455,6 +460,8 @@ struct mgmt *mgmt_new_default(void)
> 
> 	mgmt->close_on_unref = true;
> 
> +	default_mgmt = mgmt;
> +
> 	return mgmt;
> }
> 
> @@ -476,6 +483,9 @@ void mgmt_unref(struct mgmt *mgmt)
> 	if (__sync_sub_and_fetch(&mgmt->ref_count, 1))
> 		return;
> 
> +	if (default_mgmt == mgmt)
> +		default_mgmt = NULL;
> +
> 	mgmt_unregister_all(mgmt);
> 	mgmt_cancel_all(mgmt);

this is a poor mans fix for the issue at hand. It is not the job of shared/mgmt.c to fix this. So NAK.

Lets make sure that bluetoothd internally does this correctly.

Regards

Marcel

