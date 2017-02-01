Return-Path: <baruch@tkos.co.il>
Date: Wed, 1 Feb 2017 22:10:19 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, Phil Elwell <phil@raspberrypi.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] hciattach: bcm43xx: delay reset after firmware download
Message-ID: <20170201201019.wn7ofkefo62v77cq@tarshish>
References: <c23b80351e1a4046f1c0087d2243ed4dc16c0d37.1485697508.git.baruch@tkos.co.il>
 <A0AA909E-8FF1-48A8-90C3-6C7BB2FCB1D1@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A0AA909E-8FF1-48A8-90C3-6C7BB2FCB1D1@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 01, 2017 at 08:50:10PM +0100, Marcel Holtmann wrote:
> > The BCM43438 chip on the Raspberry Pi 3 board needs a delay after firmware
> > download for the setup to complete successfully.
> > 
> > Based on Yocto patch from Phil Elwell.
> > ---
> > tools/hciattach_bcm43xx.c | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
> > index 81f38cbbcf92..1140379d5cc4 100644
> > --- a/tools/hciattach_bcm43xx.c
> > +++ b/tools/hciattach_bcm43xx.c
> > @@ -380,6 +380,7 @@ int bcm43xx_init(int fd, int def_speed, int speed, struct termios *ti,
> > 			return -1;
> > 		}
> > 
> > +		sleep(1);
> > 		if (bcm43xx_reset(fd))
> > 			return -1;
> > 	}
> 
> any reason not to use the hci_bcm driver support in recent kernels? That 
> would be a lot better than hacking the old hciattach code.

Mainly the lack of device tree probe support in hci_bcm. I now see that Rob's 
serial device work[1] would address that for hci_bcm. In the mean time, 
hciattach is my only option, AFAIK.

[1] https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git/log/?h=serial-bus-v4

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
