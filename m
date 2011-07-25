Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309547558-9617-2-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547558-9617-1-git-send-email-vinicius.gomes@openbossa.org>
	<1309547558-9617-2-git-send-email-vinicius.gomes@openbossa.org>
Date: Mon, 25 Jul 2011 16:40:12 -0700
Message-ID: <CAE-CKuhXwsUnQta4VjBvRxmXobC__=hutJre7y_uNDxjpQmthQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/8] Add stubs for storing SMP keys
From: mike tsai <mikeyhtsai@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

<cut>
> diff --git a/src/event.c b/src/event.c
> index 86a413e..3f0f454 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -395,9 +395,8 @@ proceed:
>        adapter_set_state(adapter, STATE_IDLE);
>  }
>
> -int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
> -                               uint8_t *key, uint8_t key_type,
> -                               uint8_t pin_length)
> +int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer, uint8_t *key,
> +               uint8_t key_type, uint8_t pin_length, int dlen, uint8_t *data)
>  {
>        struct btd_adapter *adapter;
>        struct btd_device *device;
> @@ -408,7 +407,10 @@ int btd_event_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
>
>        DBG("storing link key of type 0x%02x", key_type);
>
> -       ret = write_link_key(local, peer, key, key_type, pin_length);
> +       if (key_type < 0x10)
> +               ret = write_link_key(local, peer, key, key_type, pin_length);
> +       else
> +               ret = write_longtermkeys(local, peer, NULL);
>
>        if (ret == 0 && device_is_temporary(device))
>                device_set_temporary(device, FALSE);
[MT] The event.c in the mainline is different from this, It is currently as
	if (ret == 0) {
		device_set_bonded(device, TRUE);

		if (device_is_temporary(device))
			device_set_temporary(device, FALSE);
	}
this causes applying patches failed.

I am also wandering why these patches are not up-streamed yet. It
would seem to me that the kernel SMP patches will need these to
support full capability.

Regards,

Mike
