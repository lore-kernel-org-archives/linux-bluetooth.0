Return-Path: <wnhuang@google.com>
MIME-Version: 1.0
In-Reply-To: <1464750564-21027-1-git-send-email-wnhuang@chromium.org>
References: <1464750564-21027-1-git-send-email-wnhuang@chromium.org>
From: Wei-Ning Huang <wnhuang@google.com>
Date: Wed, 1 Jun 2016 15:25:04 +0800
Message-ID: <CABicQ-U0hHagZpnt9SONwpWOEgfP9mcgxHjJi0Y3JASso=1gzA@mail.gmail.com>
Subject: Re: [PATCH] dt: bindings: fix documentation for MARVELL's bt-sd8xxx
 wireless device
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Amitkumar Karwar <akarwar@marvell.com>,
	Wei-Ning Huang <wnhuang@chromium.org>, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	Hu Xinming <huxm@marvell.com>, marcel@holtmann.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Please ignore this patch. I think we should make the driver parse 32
bit value instead (to be consistent with mwifiex driver).

On Wed, Jun 1, 2016 at 11:09 AM, Wei-Ning Huang <wnhuang@chromium.org> wrot=
e:
> The property marvell,wakeup-pin and marvell,wakeup-gap-ms are read as
> u16 in the driver. Fix documentation and example accordingly.
>
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> ---
>  Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt =
b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> index 14aa6cf..6a9a63c 100644
> --- a/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> +++ b/Documentation/devicetree/bindings/net/marvell-bt-sd8xxx.txt
> @@ -13,10 +13,10 @@ Optional properties:
>                       initialization. This is an array of 28 values(u8).
>
>    - marvell,wakeup-pin: It represents wakeup pin number of the bluetooth=
 chip.
> -                       firmware will use the pin to wakeup host system.
> +                       firmware will use the pin to wakeup host system (=
u16).
>    - marvell,wakeup-gap-ms: wakeup gap represents wakeup latency of the h=
ost
>                       platform. The value will be configured to firmware.=
 This
> -                     is needed to work chip's sleep feature as expected.
> +                     is needed to work chip's sleep feature as expected =
(u16).
>    - interrupt-parent: phandle of the parent interrupt controller
>    - interrupts : interrupt pin number to the cpu. Driver will request an=
 irq based
>                  on this interrupt number. During system suspend, the irq=
 will be
> @@ -50,7 +50,7 @@ calibration data is also available in below example.
>                         0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f=
 0x04 0x02
>                         0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00=
 0x00 0x00
>                         0x00 0x00 0xf0 0x00>;
> -               marvell,wakeup-pin =3D <0x0d>;
> -               marvell,wakeup-gap-ms =3D <0x64>;
> +               marvell,wakeup-pin =3D /bits/ 16 <0x0d>;
> +               marvell,wakeup-gap-ms =3D /bits/ 16 <0x64>;
>         };
>  };
> --
> 2.1.2
>



--=20
Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 | Software Engineer, Google Inc=
., Taiwan |
wnhuang@google.com | Cell: +886 910-380678
