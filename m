Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 13/18] Add support for making LE connections to GATT
 client
From: Brian Gix <bgix@codeaurora.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1292966800-6264-14-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
	 <1292966800-6264-14-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 21 Dec 2010 14:22:20 -0800
Message-ID: <1292970140.14993.77.camel@sealablnx02.qualcomm.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Vinicius,

On Tue, 2010-12-21 at 19:26 -0200, Vinicius Costa Gomes wrote:
> Now GATT client should be able to make LE connections. The information
> used to determine if we should make a LE connection is the psm stored
> in the gatt_service structure.

Most of your patches listed here are at a higher level than what I am
currently looking at, so I am just very happy that they are getting
done.

So all of my comments of your patch list are here.

> ---
>  attrib/client.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/attrib/client.c b/attrib/client.c
> index 0eadf1e..21ce439 100644
> --- a/attrib/client.c
> +++ b/attrib/client.c
> @@ -409,7 +409,15 @@ static int l2cap_connect(struct gatt_service *gatt, GError **gerr,
>  	 * Configuration it is necessary to poll the server from time
>  	 * to time checking for modifications.
>  	 */
> -	io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
> +	if (gatt->psm < 0)
> +		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
> +			BT_IO_OPT_SOURCE_BDADDR, &gatt->sba,
> +			BT_IO_OPT_DEST_BDADDR, &gatt->dba,
> +			BT_IO_OPT_CID, GATT_CID,
> +			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
> +			BT_IO_OPT_INVALID);

As I have mentioned previously, I am interested in assuring support of
LE Privacy.  This is something we saw for the first time at the
Barcelona UPF, which caused a few teams problems.

While I understand that for now you just want to get Public Addressing
working, I think we may want to include a framework which allows for
Ransom and private addressing in the future, even if for now they are
just place-holders.

Towards that end, any interface like bt_io_connect which is specifying
the Source and Destination address in this manner, should also include
the address type, which at a minimum will need to be stored with the
Destination BDADDR.  Source address type is less of a concern, as the
lower kernel layers can probably derive it.  But I would suggest a
connect parameter of:
BT_IO_OPT_DEST_BDADDR_TYPE
with possible values of
0x00 - Public
0x01 - Random

And a gatt structure member of something like "uint8_t dbat".


> +	else
> +		io = bt_io_connect(BT_IO_L2CAP, connect_cb, gatt, NULL, gerr,
>  			BT_IO_OPT_SOURCE_BDADDR, &gatt->sba,
>  			BT_IO_OPT_DEST_BDADDR, &gatt->dba,
>  			BT_IO_OPT_PSM, gatt->psm,

Regards,

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

