Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297373795-14909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1297373795-14909-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 11 Feb 2011 08:09:43 -0300
Message-ID: <AANLkTin9U-Zj6MHPdb7VA54U8uKGJQux1Eow8OXGqQWG@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hcitool: add option for LE_Scan_Type parameter
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Feb 10, 2011 at 6:36 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> The LE_Scan_Type parameter controls the type of scan to perform.
> ---
>  tools/hcitool.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index c097526..6d17ad5 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -2350,23 +2350,33 @@ done:
>  static struct option lescan_options[] = {
>        { "help",       0, 0, 'h' },
>        { "privacy",    0, 0, 'p' },
> +       { "scantype",   1, 0, 's' },
>        { 0, 0, 0, 0 }
>  };
>
>  static const char *lescan_help =
>        "Usage:\n"
> -       "\tlescan [--privacy] enable privacy\n";
> +       "\tlescan [--privacy] enable privacy\n"
> +       "\tlescan [--scantype] set scan type 0 - passive, 1 - active (default)\n";

I think it is enough to have a "--passive" boolean option and set
scantype to 0x00 if it is TRUE and 0x01 if it is FALSE.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
