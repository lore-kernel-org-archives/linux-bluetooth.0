Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110612173139.63533a90.yugiohjcj-mailinglist@laposte.net>
References: <1307874927.6198.2.camel@localhost> <BANLkTim6_pgow2+an11ktfHz49RAoJHK=w@mail.gmail.com>
 <20110612173139.63533a90.yugiohjcj-mailinglist@laposte.net>
From: Takeshi Hamasaki <takeshi.ken.hamasaki@gmail.com>
Date: Mon, 13 Jun 2011 15:57:41 +0900
Message-ID: <BANLkTi=L44VBVA1aO-V4mD=3495yLxMdwA@mail.gmail.com>
Subject: Re: Re: bluetooth headset on linux
To: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2011/6/13 YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>:
> Ok, so you think this is probably because I use the last version of bluez that I get this compile error.

No. Not only libbluetooth-dev but build tools were also old
at that libbluetooth.so.2* time.
For successful build of plugz, find line:

ECHO="echo"

in libtool and add next line under or above that:

echo="echo"

I found this solution during googling with keywords "$echo libtool" .
I saw that make command finished with success status but did not installed them.
If you find some progress beyond that, please let us know.

Cheers!

Oh, I should add this:
I don't have libbluetooth.so.2* installed.
I also use bluez 4.94, and my distro is Debian squeeze/wheezy.
-- 
Takeshi Hamasaki
