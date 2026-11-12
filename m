Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509770;
	b=W0zhNq0rpXksoeJzZ13ClXCCZ3Y1tkovDEac+JQXg6pclVDvyvbvYKrgVbsX6pN4MxDf
	 S75711w6dMKBNSDcsCwsP7Y9wL4x/pxPiavjneFRPvUIeUl0YtBp+hFpDI8EaiAbyijDb
	 zRfrgJzrH51DFYZuif5XxJOm7Dcm9oGgRUH/+mdweoU7DgJu8j1a5ndJ8Qw9FEe0y+3Hl
	 JfFL8gKbd2Or5ddUNWf/ZWJvqjmueuO0vhLj3JoTfTeBFGe5utFHGCUg9TsjSxnYuTP4S
	 tOYjeKNIddRIfr8PmT64YnUUbgB5GP07KdWS+zIL+Okv3cZFJvissxdipsnZIM7szPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509770;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=UaCcqVGf6Uu0P/7T6aSPuRTVhpR0K764Inm2Yffey/I=;
	b=Wz+KUoQjZEYMntx1ykCbrmkdNzgZSObhyO4Khg8LzOxCP30R2DSUTGv9DrwEQI3LMzGK
	 ReLRZbHYdExq4vDPZMKhGojuNKm6usaWzMqqvPyCOVLNVQ/vKu5nVMPiMNxdKtjhHX0GL
	 VEnXhLR8+YZisUOVaBGjfS2gSh9aVaUTfgUvCQSD8DXkneNEko8+cDjJ3pkwxDV6VY+8D
	 Hpi1KcT5aIreVPoF+kGSZ20xkci1NH0xAgiGnyx2Bxg2YlanH3+fNZRF16Kk+UwNcQICX
	 QNB9TrH7ltw6ZHc5hbTa4fritZkSypnCMZQJ2QZ29QPay/JcrK1QnUpMBVKb+MceDfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=UUAgRAb3;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD59606A330
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CD59606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=UUAgRAb3
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 34A8B240028
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:56:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1794509761;
	bh=UaCcqVGf6Uu0P/7T6aSPuRTVhpR0K764Inm2Yffey/I=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=UUAgRAb3/LrJf3RDNM76QD3vhZlEGd3Gj2vjYTYU320fw9323CUD3nOQFzQz/tcCw
	 fNiyLavlj3OJcD7b3CiRe8xxCO0FLqRyo4WSbAsyL8FQctUp2DbdKNIIPbDBM/FTCL
	 ax4ZkjB7jjME6chhc4EtPo4oIRcnlS6je97Lj11XllKzi3bHxCxdeNmYL4OzqEv+Rg
	 9Seroi3EPoEixzb/RYaP1tV9OCVV6gSJHzUYNzhgK27wBCddvBR4HlNPTti5AJbFth
	 axgt7tJszN3A9Js67H6La5JtBkLcA98o5yOZoWf1QK3ByzKhP7lo6jBtReu4cG/XlN
	 X4P8JeJoverEQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jQV3406T2z6v0l;
	Thu, 12 Nov 2026 19:55:59 +0100 (CET)
Message-ID: <341e56b1ff7d8a5b109e26e30dfed61faa54d603.camel@posteo.de>
Subject: Re: [PATCH 2/4] Bluetooth: hci_serdev: Track whether the serial
 port is open
From: Markus Probst <markus.probst@posteo.de>
To: Michael McAllister <me@michaelmcallister.org>, Marcel Holtmann
	 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski
	 <brgl@kernel.org>, linux-bluetooth@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Balakrishna
 Godavarthi <quic_bgodavar@quicinc.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Matthias Kaehlcke	 <mka@chromium.org>
Date: Thu, 12 Nov 2026 18:56:00 +0000
In-Reply-To: <179322687811.94538.11949086384142524062.wcn3950-poweroff-v1-2@michaelmcallister.org>
References: 
	<179322687810.94538.4628148055419456389.wcn3950-poweroff-v1-0@michaelmcallister.org>
	 <179322687811.94538.11949086384142524062.wcn3950-poweroff-v1-2@michaelmcallister.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-egiABX/yCJ54Ho5mwMOW"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-egiABX/yCJ54Ho5mwMOW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-28 at 22:34 +0000, Michael McAllister wrote:
> QCA setup temporarily closes the serial port while enabling the supplies.
> If enabling the supplies or reopening the port fails, PROTO_READY stays
> set. Error cleanup can then flush or close an already-closed port.
>=20
> Track the open state separately from protocol readiness. Use the same
> open and close helpers in the transport and the QCA and Marvell drivers,
> so setup retries do not close the port twice. Skip the serial flush when
> the port is closed, while still flushing the protocol queues.
>=20
> Close the port during unregister according to its actual open state.
>=20
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>
> ---
>  drivers/bluetooth/hci_mrvl.c   |  4 ++--
>  drivers/bluetooth/hci_qca.c    | 12 +++++------
>  drivers/bluetooth/hci_serdev.c | 37 +++++++++++++++++++++++++++-------
>  drivers/bluetooth/hci_uart.h   |  3 +++
>  4 files changed, 41 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
> index 5798a8db0..38d9add89 100644
> --- a/drivers/bluetooth/hci_mrvl.c
> +++ b/drivers/bluetooth/hci_mrvl.c
> @@ -76,7 +76,7 @@ static int mrvl_open(struct hci_uart *hu)
>  	hu->priv =3D mrvl;
> =20
>  	if (hu->serdev) {
> -		ret =3D serdev_device_open(hu->serdev);
> +		ret =3D hci_uart_serdev_open(hu);
Hi,

Why is `serdev_device_open`/`hci_uart_serdev_open` even called here?

According to Sashiko [1], `hci_uart_register_device` already calls
`serdev_device_open` and directly after that `p->open` (effectively
`mvrl_open` and thus another `serdev_device_open`). If Sashiko is right
(which appears to be the case at first look), the device is always
opened twice on probe.

=46rom what I can tell, opening it twice is *undefined behaviour*. This
patch adds a check if the device is open, before calling
`serdev_device_open`. This solves the issue (possibly by accident), but
does not explain why it exists in the first place.

My patch [2] would instead return the error -EALREADY, which could
prevent it to probe entirely. It would also allow calling
`serdev_device_close` on a already closed serdev device, which makes
the use in the commit message obsolete.

Thanks
- Markus Probst

[1]
https://lore.kernel.org/linux-serial/sashiko-outbox-211656@kernel.org/
[2]
https://lore.kernel.org/linux-serial/20261112-rust_serdev_probe_refactor-v6=
-1-3568ed56264c@posteo.de/


>  		if (ret)
>  			goto err;
>  	}
> @@ -95,7 +95,7 @@ static int mrvl_close(struct hci_uart *hu)
>  	BT_DBG("hu %p", hu);
> =20
>  	if (hu->serdev)
> -		serdev_device_close(hu->serdev);
> +		hci_uart_serdev_close(hu);
> =20
>  	skb_queue_purge(&mrvl->txq);
>  	skb_queue_purge(&mrvl->rawq);
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 8705c4543..3d9e6cd15 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1755,8 +1755,8 @@ static int qca_port_reopen(struct hci_uart *hu)
>  	 * Without this, we will have RTS and CTS synchronization
>  	 * issues.
>  	 */
> -	serdev_device_close(hu->serdev);
> -	ret =3D serdev_device_open(hu->serdev);
> +	hci_uart_serdev_close(hu);
> +	ret =3D hci_uart_serdev_open(hu);
>  	if (ret) {
>  		bt_dev_err(hu->hdev, "failed to open port");
>  		return ret;
> @@ -1780,12 +1780,12 @@ static int qca_regulator_init(struct hci_uart *hu=
)
>  	qcadev =3D serdev_device_get_drvdata(hu->serdev);
> =20
>  	if (!qcadev->bt_power->vregs_on) {
> -		serdev_device_close(hu->serdev);
> +		hci_uart_serdev_close(hu);
>  		ret =3D qca_regulator_enable(qcadev);
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D serdev_device_open(hu->serdev);
> +		ret =3D hci_uart_serdev_open(hu);
>  		if (ret) {
>  			bt_dev_err(hu->hdev, "failed to open port");
>  			return ret;
> @@ -2061,8 +2061,8 @@ static int qca_setup(struct hci_uart *hu)
>  		if (retries < MAX_INIT_RETRIES) {
>  			bt_dev_warn(hdev, "Retry BT power ON:%d", retries);
>  			if (hu->serdev) {
> -				serdev_device_close(hu->serdev);
> -				ret =3D serdev_device_open(hu->serdev);
> +				hci_uart_serdev_close(hu);
> +				ret =3D hci_uart_serdev_open(hu);
>  				if (ret) {
>  					bt_dev_err(hdev, "failed to open port");
>  					return ret;
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serde=
v.c
> index 48ba017e2..05aa490a9 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -21,6 +21,29 @@
> =20
>  #include "hci_uart.h"
> =20
> +int hci_uart_serdev_open(struct hci_uart *hu)
> +{
> +	int err;
> +
> +	if (hu->serdev_open)
> +		return 0;
> +
> +	err =3D serdev_device_open(hu->serdev);
> +	if (!err)
> +		hu->serdev_open =3D true;
> +
> +	return err;
> +}
> +
> +void hci_uart_serdev_close(struct hci_uart *hu)
> +{
> +	if (!hu->serdev_open)
> +		return;
> +
> +	hu->serdev_open =3D false;
> +	serdev_device_close(hu->serdev);
> +}
> +
>  static inline void hci_uart_tx_complete(struct hci_uart *hu, int pkt_typ=
e)
>  {
>  	struct hci_dev *hdev =3D hu->hdev;
> @@ -102,7 +125,8 @@ static int hci_uart_flush(struct hci_dev *hdev)
>  	}
> =20
>  	/* Flush any pending characters in the driver and discipline. */
> -	serdev_device_write_flush(hu->serdev);
> +	if (hu->serdev_open)
> +		serdev_device_write_flush(hu->serdev);
> =20
>  	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
>  		hu->proto->flush(hu);
> @@ -123,7 +147,7 @@ static int hci_uart_open(struct hci_dev *hdev)
>  	 * BT OFF. Upon next BT ON UART port should be opened.
>  	 */
>  	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> -		err =3D serdev_device_open(hu->serdev);
> +		err =3D hci_uart_serdev_open(hu);
>  		if (err)
>  			return err;
>  		set_bit(HCI_UART_PROTO_READY, &hu->flags);
> @@ -154,7 +178,7 @@ static int hci_uart_close(struct hci_dev *hdev)
>  	 */
>  	if (hci_test_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP)) {
>  		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> -		serdev_device_close(hu->serdev);
> +		hci_uart_serdev_close(hu);
>  	}
> =20
>  	return 0;
> @@ -314,7 +338,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu=
,
>  	if (percpu_init_rwsem(&hu->proto_lock))
>  		return -ENOMEM;
> =20
> -	err =3D serdev_device_open(hu->serdev);
> +	err =3D hci_uart_serdev_open(hu);
>  	if (err)
>  		goto err_rwsem;
> =20
> @@ -385,7 +409,7 @@ int hci_uart_register_device_priv(struct hci_uart *hu=
,
>  	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>  	p->close(hu);
>  err_open:
> -	serdev_device_close(hu->serdev);
> +	hci_uart_serdev_close(hu);
>  err_rwsem:
>  	percpu_free_rwsem(&hu->proto_lock);
>  	return err;
> @@ -438,8 +462,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
>  	 */
>  	hu->proto->close(hu);
> =20
> -	if (proto_ready)
> -		serdev_device_close(hu->serdev);
> +	hci_uart_serdev_close(hu);
> =20
>  	hci_free_dev(hdev);
> =20
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 7fbe8dffa..2f8e346f3 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -66,6 +66,7 @@ struct hci_uart_proto {
>  struct hci_uart {
>  	struct tty_struct	*tty;
>  	struct serdev_device	*serdev;
> +	bool			serdev_open;
>  	struct hci_dev		*hdev;
>  	unsigned long		flags;
>  	unsigned long		hdev_flags;
> @@ -112,6 +113,8 @@ static inline int hci_uart_register_device(struct hci=
_uart *hu,
>  }
> =20
>  void hci_uart_unregister_device(struct hci_uart *hu);
> +int hci_uart_serdev_open(struct hci_uart *hu);
> +void hci_uart_serdev_close(struct hci_uart *hu);
> =20
>  int hci_uart_tx_wakeup(struct hci_uart *hu);
>  int hci_uart_wait_until_sent(struct hci_uart *hu);

--=-egiABX/yCJ54Ho5mwMOW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmr2C7AbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS+nEP/jTtNtnueC+QwqaD9dd7
Z2NvNiny0WTQbXoTx8I/gAgaijICIm3bn1vQEpU7ZqnNp1l96n+TAVGfDo/RmJ6h
RHmxsipGRUUnCJxbm7I05PPDt3kziUAkxh9/sJZg0dI3/omLcacptoTZVvXIhYMP
jKhgN89EKKkUZUAhjXfCCgV5XqOgZPTanCKOKKafqmm9d1jEyDsBp2YNtnrxjQgk
5GhV8NDcV+N7nCw1Vwdpw8E5cJ3kq/pZZn+KVH/+HU4Z2N5/5FNIudVzVd4/iOMM
ISge9qQz5oCJWmFbgEtdePNziFFGiOUwTrgozrmRYkzYBn17z/T/pNRlES6NHj4i
k+l78MBN18jhPkuQd2oNqNiLyA5rFeB+7h+hRQQcfw9s39LGT1ThoOdomRP3Mt9n
yKPkL+H0ecdxtGeQrSS+2o1lIzJdJXLC5W9+/iiJr2RdshL5D/P3GpPqEJczSWUY
kurdSMTo0WPGJW6mX/Qgdy4lQIN9dbk185QfNRwdHANG0cHDxUUPlpyIwdqBJcCK
ass+LvrtzkxecRhRDU6QH6tdbPhRRQoMEJ7bXA48X4bn1yuJR+r/GwMVp5uO5GiE
5WzQyg4AHzF801LmOoIpon3bQzKntpzfKsGSjVPoTvkBWkvQJjf8ktdB98exuQxC
vTP/rElAGqYT8cnAAilSKNL5
=NJDm
-----END PGP SIGNATURE-----

--=-egiABX/yCJ54Ho5mwMOW--
