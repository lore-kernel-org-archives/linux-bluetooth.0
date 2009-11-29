Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Nov 2009 17:44:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	kernel list <linux-kernel@vger.kernel.org>
Subject: Re: bluetooth cf slow (10KB/sec), lots of dmesg spam
Message-ID: <20091129164450.GA1438@ucw.cz>
References: <20091129155801.GA1634@ucw.cz> <20091130153915.0a6910e3@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091130153915.0a6910e3@lxorguk.ukuu.org.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi!

> > I believe the problem is 115200 bitrate between system and CF serial;
> 
> and lack of flow control I assume ?

I guess so. (But flow control can be hard for bluetooth, I guess. Data
are coming from the air...)

> > I did setserial baud_base 921600,  but that does not seem to speed it
> > up. Do I need to do some special magic to enable high speed?
> 
> Just set the baud rate to 921600. You may need to write an app to do this
> directly via the TERMIOS2 ioctl because it seems three years ago is a bit
> quick for the glibc maintainers to keep up.
> 
> Basically set the baud to BOTHER, set the ispeed = ospeed = 921600 and
> the kernel will do its best to give you your request

hciattach seems to do this:

...
open("/dev/ttyBT", O_RDWR|O_NOCTTY)     = 3
ioctl(3, TCFLSH, 0x2)                   = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon -echo ...}) = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon -echo ...}) = 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {B115200 -opost -isig -icanon -echo ...}) = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon -echo ...}) = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon -echo ...}) = 0
ioctl(3, SNDCTL_TMR_START or TCSETS, {B921600 -opost -isig -icanon -echo ...}) = 0

...set 921K using TCSETS/B921600... and kernel says ok, but ...

ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon -echo ...}) = 0
ioctl(3, TCFLSH, 0x2)                   = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B115200 -opost -isig -icanon -echo ...}) = 0

...we are still at 115200... I wonder if 921600 is the right speed to
use after all? Any other speeds I should try? (and can 400MHz arm
handle 921K on serial line?)

...when I was setting 921600 baud_base, I basically broke it so that
it used 115200, right? I guess I should play a bit more...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
