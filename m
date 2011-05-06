Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs settings
From: Bastien Nocera <hadess@hadess.net>
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-bluetooth@vger.kernel.org, linux-input@vger.kernel.org,
	Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>,
	"Pascal A . Brisset" <pascal44973@pabr.org>,
	Marcin Tolysz <tolysz@gmail.com>,
	Christian Birchinger <joker@netswarm.net>,
	Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>,
	Mikko Virkkila <virkkila@kapsi.fi>
Date: Fri, 06 May 2011 02:14:38 +0100
In-Reply-To: <1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	 <1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1304644488.16101.28.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
> +                       [AC_LANG_PROGRAM([[
> +                               #include <sys/ioctl.h>
> +                               #include <linux/hidraw.h>
> +                               #if ! (defined(HIDIOCSFEATURE) &&
> defined(HIDIOCGFEATURE))
> +                               #error "HIDIOCSFEATURE and
> HIDIOCGFEATURE are required (linux-libc-dev >= 2.6.3x)"
> +                               #endif
> +                               ]], 

The only part of the patch I have a problem with is this one.

I'd rather the code had:
#ifndef HIDIOCSFEATURE
#define HIDIOCSFEATURE bleh
#endif

And gracefully handled the ioctl not being available on the running
kernel (eg. "Not handling plugged in Sixaxis joypad because the kernel
lacks HIDIOCSFEATURE support").

The rest looks fine, and I'll be testing whether my Fedora 15 kernel has
the feature merged in yet (which would make testing your code much
easier).

Cheers

