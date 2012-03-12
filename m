Return-Path: <cyrus@holtmann.org>
Message-ID: <1331574355.14217.89.camel@aeonflux>
Subject: Re: [PATCHv2 3/6] Bluetooth: Correct CID endian notation
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 12 Mar 2012 10:45:55 -0700
In-Reply-To: <1331547191-15307-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331547191-15307-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1331547191-15307-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> L2CAP channel id is used in host format in internal L2CAP code.
> Fix sparse warnings about wrong endian conversion.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 85c3404..c778585 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -834,7 +834,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
>  /* Find socket with cid and source bdaddr.
>   * Returns closest match, locked.
>   */
> -static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid, bdaddr_t *src)
> +static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid, bdaddr_t *src)

I get the feeling we are turning in circles here. Can you please have a
second look that all the conversions are now correct.

And yes, we wanna store the CID in host endian, while it is provided in
little endian by userspace.

Regards

Marcel


