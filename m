Return-Path: <cyrus@holtmann.org>
Message-ID: <1351700642.1828.13.camel@aeonflux>
Subject: Re: [PATCHv1 12/12] Bluetooth: Process Create Chan Request
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 31 Oct 2012 09:24:02 -0700
In-Reply-To: <1351691197-8394-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
	 <1351691197-8394-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1351691197-8394-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add processing L2CAP Create Chan Request. When channel is created
> save associated high speed link hs_hcon.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   63 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index bdffc4c..783ffae 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4237,7 +4237,9 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
>  				    u16 cmd_len, void *data)
>  {
>  	struct l2cap_create_chan_req *req = data;
> +	struct l2cap_create_chan_rsp rsp;
>  	struct l2cap_chan *chan;
> +	struct hci_dev *hdev = NULL;

why is this one set to NULL. Can we avoid that please.

Regards

Marcel


