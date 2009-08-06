Return-Path: <cyrus@holtmann.org>
From: Lamarque Vieira Souza <lamarque@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: bluetooth-fix-for-acer-bluetooth-optical-rechargeable-mouse.patch
Date: Thu, 6 Aug 2009 20:05:16 -0300
Cc: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
References: <20090806154448.119b9e82.akpm@linux-foundation.org>
In-Reply-To: <20090806154448.119b9e82.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200908062005.17141.lamarque@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

	Hi all,

	Well,	I need this patch or my bluetooth mouse is completly useless to me. If 
Marcel could show me how I can solve this problem in right way I can update 
the patch. As I said in another e-mail, I do not see anywhere else I can make 
the driver use input session instead of hid session beside hidp/core.c. I have 
tried to add a HID quirk in HID subsystem, but I have failed to find a place 
to change the input session types. Anyway, as far as I can see this is not a 
HID quirk, it is a quirk to avoid using HID session, so I do not see why I 
must use a HID quirk as Marcel suggested.

Em Quinta-feira 06 Agosto 2009, Andrew Morton escreveu:
> So I'm still sitting on this patch because it fixes a real problem,
> only it fixes it in the wrong way.
>
> I will continue to sit on the patch (potentially for years) as a
> reminder that the underlying issue remains unfixed.
>
>
> Someone please save me from this!
>
>
> From: Lamarque Vieira Souza <lamarque@gmail.com>
>
> Work around one problem with my Acer Bluetooth Optical Rechargeable Mouse
> where the cursor gets stuck at screen's upper-left corner.
>
> Even my notebook's touchpad is not able to move cursor when the bluetooth
> mouse is connected to my Acer Ferrari 4005 notebook.
>
> Using input session instead of hid session solves this problem although
> the cursor still moves a little sluggishly with the bluetooth mouse,
> cursor moves correctly using the touchpad.
>
> My bluetooth mouse used to work well (no sluggish) until kernel 2.6.21,
> since then the problems are getting worse with each kernel release (it got
> sluggish in 2.6.22 and this this upper-left corner problem appeared in
> 2.6.28 or 2.6.27).
>
> The patch adds a general quirk handling framework to the HIDP core and
> then uses this framework to implement a quirk for this device.
>
> [akpm@linux-foundation.org: use ARRAY_SIZE()-based search]
> Signed-off-by: Lamarque V. Souza <lamarque@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Dave Young <hidave.darkstar@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  net/bluetooth/hidp/core.c |   39 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff -puN
> net/bluetooth/hidp/core.c~bluetooth-fix-for-acer-bluetooth-optical-recharge
>able-mouse net/bluetooth/hidp/core.c ---
> a/net/bluetooth/hidp/core.c~bluetooth-fix-for-acer-bluetooth-optical-rechar
>geable-mouse +++ a/net/bluetooth/hidp/core.c
> @@ -73,6 +73,41 @@ static unsigned char hidp_keycode[256] =
>
>  static unsigned char hidp_mkeyspat[] = { 0x01, 0x01, 0x01, 0x01, 0x01,
> 0x01 };
>
> +/* HIDP device quirks */
> +enum {
> +	HIDP_QUIRK_USE_INPUT_SESSION
> +};
> +
> +struct quirk_id {
> +	__u16 vendor;
> +	__u16 product;
> +	unsigned long quirks;
> +};
> +
> +static const struct quirk_id hidp_quirks[] = {
> +	{
> +		/* Lamarque: Acer Bluetooth Optical Rechargeable Mouse
> +		 * does not work properly with hid session since 2.6.27. */
> +		.vendor = 0x0458,
> +		.product = 0x0058,
> +		.quirks = 1 << HIDP_QUIRK_USE_INPUT_SESSION
> +	},
> +};
> +
> +static int quirk_test_bit(__u16 vendor, __u16 product, int quirk)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hidp_quirks); i++) {
> +		const struct quirk_id *q = hidp_quirks + i;
> +
> +		if (q->vendor == vendor && q->product == product)
> +			return test_bit(quirk, &q->quirks);
> +	}
> +
> +	return 0;
> +}
> +
>  static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
>  {
>  	struct hidp_session *session;
> @@ -833,7 +868,9 @@ int hidp_add_connection(struct hidp_conn
>  	session->flags   = req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
>  	session->idle_to = req->idle_to;
>
> -	if (req->rd_size > 0) {
> +	if (req->rd_size > 0 &&
> +	    !quirk_test_bit(req->vendor, req->product,
> +			   HIDP_QUIRK_USE_INPUT_SESSION)) {
>  		err = hidp_setup_hid(session, req);
>  		if (err && err != -ENODEV)
>  			goto err_skb;
> _


-- 
Lamarque V. Souza
http://www.geographicguide.com/brazil.htm
Linux User #57137 - http://counter.li.org/
