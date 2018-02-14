Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4C851F03BEE04A418B7A2D283DDCAB5D47F28210@EFJDFWMB01.EFJDFW.local>
References: <4C851F03BEE04A418B7A2D283DDCAB5D47F28210@EFJDFWMB01.EFJDFW.local>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 14 Feb 2018 08:49:22 -0200
Message-ID: <CABBYNZLLqrO511-KgbY2rir7EXWKh=yefvE0KHCn+m+rEHXk8Q@mail.gmail.com>
Subject: Re: GAP and GATT always added to sdp records
To: Austin Riffle <ARiffle@efji.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Austin,

On Tue, Feb 13, 2018 at 6:22 PM, Austin Riffle <ARiffle@efji.com> wrote:
> Hello
>
> I'm developing a Bluetooth solution using BlueZ 5.46 on kernel 4.12.0, an=
d I'm using a TI Wilink chip for both BR/EDR and BLE. My plan is to initial=
ly release software with support for only BR/EDR, and then at a later point=
 release software which supports BLE.
>
> I have not yet enabled BLE (knowingly), however, during testing I noticed=
 that other devices are seeing my device advertise both GAP and GATT UUID's=
 through SDP. I am starting bluetoothd as follows:
>
> /usr/libexec/bluetooth/bluetoothd --noplugin=3D*
>
> I also do have bredr only marked in main.conf.

That should have prevented any GATT functionality, so perhaps there is
bug handling this configuration.

> Tracing through the bluetoothd source, this is what I see:
>
> ...
> adapter_register

Looks like a bug indeed.

> btd_gatt_database_new
> register_core_services
> populate_gap_service/populate_gatt_service  **These add GAP_UUID and GATT=
_UUID to the SDP records
>
> If any of these steps fail, the adapter fails to register, and these step=
s are required to be called. I realize that not marking the flag "G_DBUS_FL=
AG_ENABLE_EXPERIMENTAL" prevents any advertising, but I would really like t=
o avoid putting GATT/GAP into my SDP records as they are not supported in a=
ny meaningful way on my device.
>
> Does BlueZ really force all adapters to advertise these services? Or is t=
here a "nice" way to stop these from being added?
>
> I'm guessing I could go around bluetoothd's back and use sdp_lib to remov=
e them, but I'm not sure what unintended consequences that may have.
> This e-mail transmission, and any documents, files or previous e-mail mes=
sages attached to it, may contain confidential information. If you are not =
the intended recipient, or a person responsible for delivering it to the in=
tended recipient, you are hereby notified that any disclosure, distribution=
, review, copy or use of any of the information contained in or attached to=
 this message is STRICTLY PROHIBITED. If you have received this transmissio=
n in error, please immediately notify us by reply e-mail, and destroy the o=
riginal transmission and its attachments without reading them or saving the=
m to disk. Thank you.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Luiz Augusto von Dentz
