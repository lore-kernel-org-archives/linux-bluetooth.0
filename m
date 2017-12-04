Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <etPan.5a21b1a2.4bcf8189.3551@mynabay.com>
References: <etPan.5a21b1a2.4bcf8189.3551@mynabay.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Dec 2017 11:53:32 +0200
Message-ID: <CABBYNZLk+Vkfj4wbXLjtmmehiXHq0jCpn1qOTnG6H8GSN-aQhg@mail.gmail.com>
Subject: Re: BlueZ Help
To: Kevin Snow <Kevin@mynabay.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin,

On Fri, Dec 1, 2017 at 9:46 PM, Kevin Snow <Kevin@mynabay.com> wrote:
>
> We have a product using BlueZ. The device has both BLE and BR/EDR (for Au=
dio). When attempting to make a BLE connection from some Android devices, t=
he connection establishes as BR/EDR. Thus, our service UUID isn=E2=80=99t v=
isible and can=E2=80=99t be accessed. I=E2=80=99ve been told this is per th=
e Bluetooth Spec, although I=E2=80=99ve been unable to find it in the spec.=
 Additionally,I don=E2=80=99t understand why the spec would do this as it e=
ffectively makes dual mode (both BLE and BR/EDR) worthless if the connectio=
n will be BR/EDR. This problem does not happen with Apple devices. They alw=
ays connect as BLE. Many Android are fine too, just not all.

I guess this depends on how old the Android is, previously 4.0 spec
did not allow connecting on LE. Btw, how are you advertising?

> One workaround would be to expose the BLE service via BR/EDR. Has anyone =
done this?

I suppose you are talking about GATT services, we will need to do some
fixes in order to support this, I will have a look into this since
that is mandatory for qualification.

> We=E2=80=99re very eager to wrap this up. Is there a BlueZ expert out the=
re open to a short term contract to help us through this? Any modifications=
 made to BlueZ would of course become part of the open source. We don=E2=80=
=99t want anything custom, just for our product to be completed.
>
> Thanks
>
> Kevin Snow
> kevin@mynabay.com
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
