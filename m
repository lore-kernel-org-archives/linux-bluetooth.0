Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/sdptool: Check if HCI is powered UP before executing commands
Date: Thu, 29 Jan 2015 16:47:54 +0100
Message-ID: <2597711.MuBCiDUiW2@leonov>
In-Reply-To: <1422452421-32092-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1422452421-32092-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday 28 of January 2015 14:40:21 Grzegorz Kolodziejczyk wrote:
> Before executing commands should be checked if any or chosen HCI is
> powered up. If not further executing of command makes no sense.
> ---
>  android/pics-spp.txt  |  2 +-
>  android/pixit-spp.txt |  2 +-

This shouldn't be part of this patch.

>  tools/sdptool.c       | 12 ++++++++++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-spp.txt b/android/pics-spp.txt
> index f015236..d9bb883 100644
> --- a/android/pics-spp.txt
> +++ b/android/pics-spp.txt
> @@ -1,6 +1,6 @@
>  SPP PICS for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-spp.txt b/android/pixit-spp.txt
> index a8a8202..8e2d70f 100644
> --- a/android/pixit-spp.txt
> +++ b/android/pixit-spp.txt
> @@ -1,6 +1,6 @@
>  SPP PIXIT for the PTS tool.
> 
> -PTS version: 5.3
> +PTS version: 6.0
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/tools/sdptool.c b/tools/sdptool.c
> index 17561b1..9ff7a1c 100644
> --- a/tools/sdptool.c
> +++ b/tools/sdptool.c
> @@ -4352,17 +4352,20 @@ static struct option main_options[] = {
> 
>  int main(int argc, char *argv[])
>  {
> -	int i, opt;
> +	int i, opt, err;
> 
>  	bacpy(&interface, BDADDR_ANY);
> 
> +	err = hci_get_route(NULL);
> +
>  	while ((opt=getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
>  		switch(opt) {
>  		case 'i':
>  			if (!strncmp(optarg, "hci", 3))
> -				hci_devba(atoi(optarg + 3), &interface);
> +				err = hci_devba(atoi(optarg + 3), &interface);
>  			else
>  				str2ba(optarg, &interface);
> +				err = hci_get_route(&interface);
>  			break;
> 
>  		case 'h':
> @@ -4374,6 +4377,11 @@ int main(int argc, char *argv[])
>  		}
>  	}
> 
> +	if (err < 0) {
> +		printf("No powered on HCI interface found\n");
> +		exit(0);
> +	}
> +
>  	argc -= optind;
>  	argv += optind;
>  	optind = 0;

-- 
BR
Szymon Janc
