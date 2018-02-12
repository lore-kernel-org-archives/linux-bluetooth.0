Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: =?utf-8?B?xYF1a2Fzeg==?= Rymanowski
        <lukasz.rymanowski@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3] emulator: Add initial LE states to btdev and API to set new one
Date: Mon, 12 Feb 2018 10:09:09 +0100
Message-ID: <16329070.gfSXFqNcKU@ix>
In-Reply-To: <20180209172627.20500-2-lukasz.rymanowski@codecoup.pl>
References: <20180209172627.20500-1-lukasz.rymanowski@codecoup.pl> <20180209172627.20500-2-lukasz.rymanowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi =C5=81ukasz,

On Friday, 9 February 2018 18:26:25 CET =C5=81ukasz Rymanowski wrote:
> ---
>  emulator/btdev.c  | 18 ++++++++++++++++++
>  emulator/btdev.h  |  3 ++-
>  emulator/hciemu.c |  8 ++++++++
>  emulator/hciemu.h |  3 +++
>  4 files changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index a9b225a24..69d84a5fc 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -570,6 +570,17 @@ static void set_le_features(struct btdev *btdev)
>  	btdev->le_features[0] |=3D 0x08;	/* Slave-initiated Features Exchange */
>  }
>=20
> +static void set_le_states(struct btdev *btdev)
> +{
> +	/* Set all 41 bits as per Bluetooth 5.0 specification */
> +	btdev->le_states[0] =3D 0xff;
> +	btdev->le_states[1] =3D 0xff;
> +	btdev->le_states[2] =3D 0xff;
> +	btdev->le_states[3] =3D 0xff;
> +	btdev->le_states[4] =3D 0xff;
> +	btdev->le_states[5] =3D 0x03;
> +}
> +
>  static void set_amp_features(struct btdev *btdev)
>  {
>  }
> @@ -603,6 +614,7 @@ struct btdev *btdev_create(enum btdev_type type,
> uint16_t id) btdev->version =3D 0x09;
>  		set_bredrle_features(btdev);
>  		set_bredrle_commands(btdev);
> +		set_le_states(btdev);
>  		break;
>  	case BTDEV_TYPE_BREDR:
>  		btdev->version =3D 0x05;
> @@ -613,6 +625,7 @@ struct btdev *btdev_create(enum btdev_type type,
> uint16_t id) btdev->version =3D 0x09;
>  		set_le_features(btdev);
>  		set_le_commands(btdev);
> +		set_le_states(btdev);
>  		break;
>  	case BTDEV_TYPE_AMP:
>  		btdev->version =3D 0x01;
> @@ -685,6 +698,11 @@ uint8_t btdev_get_le_scan_enable(struct btdev *btdev)
>  	return btdev->le_scan_enable;
>  }
>=20
> +void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states)
> +{
> +	memcpy(btdev->le_states, le_states, sizeof(btdev->le_states));
> +}
> +
>  static bool use_ssp(struct btdev *btdev1, struct btdev *btdev2)
>  {
>  	if (btdev1->auth_enable || btdev2->auth_enable)
> diff --git a/emulator/btdev.h b/emulator/btdev.h
> index 40c72199b..ba06a1015 100644
> --- a/emulator/btdev.h
> +++ b/emulator/btdev.h
> @@ -84,12 +84,13 @@ uint8_t btdev_get_scan_enable(struct btdev *btdev);
>=20
>  uint8_t btdev_get_le_scan_enable(struct btdev *btdev);
>=20
> +void btdev_set_le_states(struct btdev *btdev, const uint8_t *le_states);
> +
>  void btdev_set_command_handler(struct btdev *btdev, btdev_command_func
> handler, void *user_data);
>=20
>  void btdev_set_send_handler(struct btdev *btdev, btdev_send_func handler,
>  							void *user_data);
> -
>  void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t le=
n);
>=20
>  int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
> diff --git a/emulator/hciemu.c b/emulator/hciemu.c
> index 7debb8f27..1787a6c0d 100644
> --- a/emulator/hciemu.c
> +++ b/emulator/hciemu.c
> @@ -444,6 +444,14 @@ uint8_t hciemu_get_master_le_scan_enable(struct hcie=
mu
> *hciemu) return btdev_get_le_scan_enable(hciemu->master_dev);
>  }
>=20
> +void hciemu_set_master_le_states(struct hciemu *hciemu, const uint8_t
> *le_states) +{
> +	if (!hciemu || !hciemu->master_dev)
> +		return;
> +
> +	btdev_set_le_states(hciemu->master_dev, le_states);
> +}
> +
>  bool hciemu_add_master_post_command_hook(struct hciemu *hciemu,
>  			hciemu_command_func_t function, void *user_data)
>  {
> diff --git a/emulator/hciemu.h b/emulator/hciemu.h
> index 783f99cf1..5c0c4c306 100644
> --- a/emulator/hciemu.h
> +++ b/emulator/hciemu.h
> @@ -57,6 +57,9 @@ uint8_t hciemu_get_master_scan_enable(struct hciemu
> *hciemu);
>=20
>  uint8_t hciemu_get_master_le_scan_enable(struct hciemu *hciemu);
>=20
> +void hciemu_set_master_le_states(struct hciemu *hciemu,
> +						const uint8_t *le_states);
> +
>  typedef void (*hciemu_command_func_t)(uint16_t opcode, const void *data,
>  						uint8_t len, void *user_data);

Patches 1 and 2 are now applied, thanks.

=2D-=20
pozdrawiam
Szymon Janc


