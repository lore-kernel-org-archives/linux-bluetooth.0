Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1497612061-30334-1-git-send-email-bergo.torino@gmail.com>
References: <1497612061-30334-1-git-send-email-bergo.torino@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 19 Jun 2017 11:10:37 +0300
Message-ID: <CABBYNZ+2WUx+_T2=3Bb_66ppiqB4SwQ+pQ_imYRWstBTdB7sWw@mail.gmail.com>
Subject: Re: [PATCH] tester: fix inproper printout from cmd handler
To: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Konrad,

On Fri, Jun 16, 2017 at 2:21 PM, Konrad Zapalowicz
<konrad.zapalowicz@canonical.com> wrote:
> From: Konrad Zapa=C5=82owicz <konrad.zapalowicz@canonical.com>
>
> ---
>  tools/hci-tester.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/hci-tester.c b/tools/hci-tester.c
> index 75d09f0..e900789 100644
> --- a/tools/hci-tester.c
> +++ b/tools/hci-tester.c
> @@ -451,7 +451,7 @@ static void test_le_read_local_pk_status(const void *=
data, uint8_t size,
>         uint8_t status =3D *((uint8_t *) data);
>
>         if (status) {
> -               tester_warn("Failed to send DHKey gen cmd (0x%02x)", stat=
us);
> +               tester_warn("Failed to send Read Local PK256 cmd (0x%02x)=
", status);
>                 tester_test_failed();
>                 return;
>         }
> --
> 2.7.4

Applied, thanks.

--=20
Luiz Augusto von Dentz
