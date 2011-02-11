Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297299551-10297-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1297299551-10297-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 11 Feb 2011 08:14:33 -0300
Message-ID: <AANLkTinNtgej4pGhk3fK275fmg1+CtMEsm0fsQOJ96Hq@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hcitool: add bdaddr type option to lecc
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 9, 2011 at 9:59 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> ---
>  tools/hcitool.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index 536d407..c097526 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -2420,7 +2420,7 @@ static struct option lecc_options[] = {
>
>  static const char *lecc_help =
>        "Usage:\n"
> -       "\tlecc <bdaddr>\n";
> +       "\tlecc <bdaddr> [conn type]\n";

Actually it would be "[bdaddr type]", right?

But I still think we should have a --random boolean option that sets
the bdaddr type to 0x01 if it is TRUE, FALSE otherwise. Other values
are RFU.

>
>  static void cmd_lecc(int dev_id, int argc, char **argv)
>  {
> @@ -2437,7 +2437,7 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
>                        return;
>                }
>        }
> -       helper_arg(1, 1, &argc, &argv, lecc_help);
> +       helper_arg(1, 2, &argc, &argv, lecc_help);
>
>        if (dev_id < 0)
>                dev_id = hci_get_route(NULL);
> @@ -2450,10 +2450,14 @@ static void cmd_lecc(int dev_id, int argc, char **argv)
>
>        str2ba(argv[0], &bdaddr);
>
> +       if (argc == 2)
> +               peer_bdaddr_type = atoi(argv[1]);
> +       else
> +               peer_bdaddr_type = 0;
> +

Note you are not validating values here as in your other patch.

>        interval = htobs(0x0004);
>        window = htobs(0x0004);
>        initiator_filter = 0x00;
> -       peer_bdaddr_type = 0x00;
>        own_bdaddr_type = 0x00;
>        min_interval = htobs(0x000F);
>        max_interval = htobs(0x000F);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
