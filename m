Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH] hciattach: bcm43xx: delay reset after firmware download
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <c23b80351e1a4046f1c0087d2243ed4dc16c0d37.1485697508.git.baruch@tkos.co.il>
Date: Wed, 1 Feb 2017 20:50:10 +0100
Cc: linux-bluetooth@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>
Message-Id: <A0AA909E-8FF1-48A8-90C3-6C7BB2FCB1D1@holtmann.org>
References: <c23b80351e1a4046f1c0087d2243ed4dc16c0d37.1485697508.git.baruch@tkos.co.il>
To: Baruch Siach <baruch@tkos.co.il>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Baruch,

> The BCM43438 chip on the Raspberry Pi 3 board needs a delay after firmware
> download for the setup to complete successfully.
> 
> Based on Yocto patch from Phil Elwell.
> ---
> tools/hciattach_bcm43xx.c | 1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
> index 81f38cbbcf92..1140379d5cc4 100644
> --- a/tools/hciattach_bcm43xx.c
> +++ b/tools/hciattach_bcm43xx.c
> @@ -380,6 +380,7 @@ int bcm43xx_init(int fd, int def_speed, int speed, struct termios *ti,
> 			return -1;
> 		}
> 
> +		sleep(1);
> 		if (bcm43xx_reset(fd))
> 			return -1;
> 	}

any reason not to use the hci_bcm driver support in recent kernels? That would be a lot better than hacking the old hciattach code.

Regards

Marcel

