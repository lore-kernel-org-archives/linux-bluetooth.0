Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406713130-3825-4-git-send-email-marcin.kraglak@tieto.com>
References: <1406713130-3825-1-git-send-email-marcin.kraglak@tieto.com>
	<1406713130-3825-4-git-send-email-marcin.kraglak@tieto.com>
Date: Wed, 30 Jul 2014 13:41:09 +0300
Message-ID: <CABBYNZ+c8MEoyUnA540yibdkvgJpi2c+-ZHUjNyALqiTsx2WXw@mail.gmail.com>
Subject: Re: [PATCH 4/5] android/gatt: Always connect with BT_SEC_LOW security
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Jul 30, 2014 at 12:38 PM, Marcin Kraglak
<marcin.kraglak@tieto.com> wrote:
> Set BT_SEC_LOW for all LE connections. Only specific profiles need
> higher security, now it is possible to elevate security with public
> GATT API.
> ---
>  android/gatt.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/android/gatt.c b/android/gatt.c
> index 49ca2b6..11d7a2c 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -1433,7 +1433,6 @@ reply:
>
>  static int connect_le(struct gatt_device *dev)
>  {
> -       BtIOSecLevel sec_level;
>         GIOChannel *io;
>         GError *gerr = NULL;
>         char addr[18];
> @@ -1450,9 +1449,6 @@ static int connect_le(struct gatt_device *dev)
>
>         DBG("Connection attempt to: %s", addr);
>
> -       sec_level = bt_device_is_bonded(&dev->bdaddr) ? BT_IO_SEC_MEDIUM :
> -                                                               BT_IO_SEC_LOW;
> -
>         /*
>          * If address type is random it might be that IRK was received and
>          * random is just for faking Android Framework. ID address should be
> @@ -1478,7 +1474,7 @@ static int connect_le(struct gatt_device *dev)
>                         BT_IO_OPT_DEST_BDADDR, bdaddr,
>                         BT_IO_OPT_DEST_TYPE, bdaddr_type,
>                         BT_IO_OPT_CID, ATT_CID,
> -                       BT_IO_OPT_SEC_LEVEL, sec_level,
> +                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
>                         BT_IO_OPT_INVALID);
>         if (!io) {
>                 error("gatt: Failed bt_io_connect(%s): %s", addr,
> --
> 1.9.3

This does not work for HoG:

"If the HID Host receives the L2CAP Connection Parameter Update
request but has not
yet completed service discovery or has not completed encryption, the
HID Host may
send the L2CAP Connection Parameter Update Response with the Result field
indicating that the request has been rejected."

IMO what we should do instead is pass what security level we want
based on the profiles that has requested the connection, in case of
HoG then we can set medium security and other might set it to low,
note that elevating security later is less secure then having it from
the start so I hope this is not just to fulfill some stupid PTS test
that does bonding but requires not to encrypt.


-- 
Luiz Augusto von Dentz
