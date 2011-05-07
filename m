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
Date: Sat, 07 May 2011 17:57:07 +0100
In-Reply-To: <20110507011412.ba0ad1e9.ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
	 <1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
	 <1304644488.16101.28.camel@novo.hadess.net>
	 <20110507011412.ba0ad1e9.ospite@studenti.unina.it>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1304787442.2427.11.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2011-05-07 at 01:14 +0200, Antonio Ospite wrote:
> On Fri, 06 May 2011 02:14:38 +0100
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > On Fri, 2011-02-25 at 11:04 +0100, Antonio Ospite wrote:
> > > +                       [AC_LANG_PROGRAM([[
> > > +                               #include <sys/ioctl.h>
> > > +                               #include <linux/hidraw.h>
> > > +                               #if ! (defined(HIDIOCSFEATURE) &&
> > > defined(HIDIOCGFEATURE))
> > > +                               #error "HIDIOCSFEATURE and
> > > HIDIOCGFEATURE are required (linux-libc-dev >= 2.6.3x)"
> > > +                               #endif
> > > +                               ]], 
> > 
> > The only part of the patch I have a problem with is this one.
> > 
> > I'd rather the code had:
> > #ifndef HIDIOCSFEATURE
> > #define HIDIOCSFEATURE bleh
> > #endif
> > 
> > And gracefully handled the ioctl not being available on the running
> > kernel (eg. "Not handling plugged in Sixaxis joypad because the kernel
> > lacks HIDIOCSFEATURE support").
> >
> 
> Thinking twice about that, maybe I haven't fully understood what you
> mean.
> 
> Do you want that the plugin can be enabled and _compiled_ on _older_
> kernels as well?

No, the plugin can be built with older kernel headers. The kernel
headers are shipped as part of the glibc, and should offer a "stable"
interface to the Linux kernel. The Debian way of shipping supposed glibc
kernel headers which actually come from the running kernel is something
that's frowned upon.

> Because about compiling on _supported_ ones and then _running_ it on
> _older_ ones, well, the ioctl return values are already checked and
> they should just (gracefully?) fail on unsupported kernels. But I'll
> double check this scenario.
> 
> If you want indeed it to be _compiled_ on older kernels and nonetheless
> still work on supported ones, I think we just have to copy the iotcls
> request defines from hidraw.h if they are not defined but I still don't
> know if I like that.

Again, it's not compiling against older kernels. but compiling against
older kernel headers, which is a wildly different thing.

I'd like the plugin to be enabled, even if building with older kernel
headers, as those have no relation to the capabilities of the running
kernel.

It would also make the whole thing easier to test (just install a newer
kernel with the patches merged in, and voila, working sisaxis pairing).

Cheers

