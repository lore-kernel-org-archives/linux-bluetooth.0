Return-Path: <cyrus@holtmann.org>
Date: Fri, 6 Mar 2015 10:55:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth:btusb:fix incorrect type in initializer
Message-ID: <20150306085517.GA20795@t440s.lan>
References: <E72C4779-837E-45DC-8256-AAA4F01DE182@qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E72C4779-837E-45DC-8256-AAA4F01DE182@qca.qualcomm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Mar 03, 2015, Kim, Ben Young Tae wrote:
> This fixes the following sparse warning:
> 
> drivers/bluetooth/btusb.c:2677:11: warning: incorrect type in initializer (different base types)
> drivers/bluetooth/btusb.c:2677:11:    expected restricted __le32 [usertype] rom_version
> drivers/bluetooth/btusb.c:2677:11:    got int
> drivers/bluetooth/btusb.c:2678:11: warning: incorrect type in initializer (different base types)
> drivers/bluetooth/btusb.c:2678:11:    expected restricted __le32 [usertype] rom_version
> drivers/bluetooth/btusb.c:2678:11:    got int
> drivers/bluetooth/btusb.c:2679:11: warning: incorrect type in initializer (different base types)
> drivers/bluetooth/btusb.c:2679:11:    expected restricted __le32 [usertype] rom_version
> drivers/bluetooth/btusb.c:2679:11:    got int
> drivers/bluetooth/btusb.c:2680:11: warning: incorrect type in initializer (different base types)
> drivers/bluetooth/btusb.c:2680:11:    expected restricted __le32 [usertype] rom_version
> drivers/bluetooth/btusb.c:2680:11:    got int
> drivers/bluetooth/btusb.c:2681:11: warning: incorrect type in initializer (different base types)
> drivers/bluetooth/btusb.c:2681:11:    expected restricted __le32 [usertype] rom_version
> drivers/bluetooth/btusb.c:2681:11:    got int
> drivers/bluetooth/btusb.c:2805:17: warning: restricted __le16 degrades to integer
> drivers/bluetooth/btusb.c:2805:37: warning: restricted __le32 degrades to integer
> drivers/bluetooth/btusb.c:2806:17: warning: restricted __le16 degrades to integer
> drivers/bluetooth/btusb.c:2806:39: warning: restricted __le32 degrades to integer
> 
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
>  drivers/bluetooth/btusb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 0833054..f65cd44 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2674,11 +2674,11 @@ struct qca_device_info {
>  };
>  
>  static const struct qca_device_info qca_devices_table[] = {
> -	{ 0x00000100, 20, 4, 10 }, /* Rome 1.0 */
> -	{ 0x00000101, 20, 4, 10 }, /* Rome 1.1 */
> -	{ 0x00000201, 28, 4, 18 }, /* Rome 2.1 */
> -	{ 0x00000300, 28, 4, 18 }, /* Rome 3.0 */
> -	{ 0x00000302, 28, 4, 18 }, /* Rome 3.2 */
> +	{ cpu_to_le32(0x00000100), 20, 4, 10 }, /* Rome 1.0 */
> +	{ cpu_to_le32(0x00000101), 20, 4, 10 }, /* Rome 1.1 */
> +	{ cpu_to_le32(0x00000201), 28, 4, 18 }, /* Rome 2.1 */
> +	{ cpu_to_le32(0x00000300), 28, 4, 18 }, /* Rome 3.0 */
> +	{ cpu_to_le32(0x00000302), 28, 4, 18 }, /* Rome 3.2 */
>  };

Since "struct qca_device_info" doesn't describe raw protocol data I
don't think it should contain protocol endianness values, i.e. the
rom_version member should be u32 instead of __le32.

Johan
