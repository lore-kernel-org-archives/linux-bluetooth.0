Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1476698552-8030-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1476698552-8030-1-git-send-email-lukasz.rymanowski@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Oct 2016 13:59:07 +0300
Message-ID: <CABBYNZ+hwetcYD77kiAvCDvL-8DHFg-K8fK6fVD1gT1B7wHFzQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] unit/test-gatt: Add /TP/GAD/CL/BV-02-C-1-alternative
To: =?UTF-8?Q?=C5=81ukasz_Rymanowski?= <lukasz.rymanowski@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Mon, Oct 17, 2016 at 1:02 PM, =C5=81ukasz Rymanowski
<lukasz.rymanowski@codecoup.pl> wrote:
> According to GATT.TS.4.2.1,
> 4.4.3 TP/GAD/CL/BV-02-C [Discover Primary Services by Service UUID =E2=80=
=93 by Client]
>
> Pass verdict is also when response has end_handle =3D 0xffff.
> This patch add such test.
> ---
>  unit/test-gatt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 8129719..c7a8fa5 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -2414,6 +2414,14 @@ int main(int argc, char *argv[])
>                                         0x18),
>                         raw_pdu(0x01, 0x06, 0x08, 0x00, 0x0a));
>
> +       define_test_att("/TP/GAD/CL/BV-02-C-1-alternative",
> +                       test_search_primary, &uuid_16,
> +                       NULL,
> +                       MTU_EXCHANGE_CLIENT_PDUS,
> +                       raw_pdu(0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28,=
 0x00,
> +                                       0x18),
> +                       raw_pdu(0x07, 0x01, 0x00, 0xFF, 0xFF));
> +
>         define_test_att("/TP/GAD/CL/BV-02-C-2", test_search_primary, &uui=
d_128,
>                         NULL,
>                         MTU_EXCHANGE_CLIENT_PDUS,
> --
> 2.7.4

Applied, thanks. I just change the order so it doesn't break bisect.


--=20
Luiz Augusto von Dentz
