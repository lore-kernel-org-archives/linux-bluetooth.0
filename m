Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Jul 2009 14:05:07 +0200
From: Andrej Rosano <andrejro@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Renaming hci interfaces with udev
Message-ID: <20090728120507.GB3292@stjenka>
References: <20090728083755.GA3292@stjenka> <1248780878.23466.11714.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1248780878.23466.11714.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 28, 2009 at 12:34:38PM +0100, Bastien Nocera wrote:
> On Tue, 2009-07-28 at 10:37 +0200, Andrej Rosano wrote:
> > Hi,
> > I would like to change the default name of bluetooth interfaces (hci0, hci1, ...)
> > using udev rules.
> 
> Could I ask why you want to do that?

I have more than one bt dongle connected to the box and I would like to assign always
the same bluetooth name (the one set with hciconfig hciX name ...), ex:

the one with BD_ADDR=xx:yy:zz:00:00:01  ->  foo
the one with BD_ADDR=xx:yy:zz:00:00:02  ->  bar
...


If one could use the udev persistent rules like with ethernet interfaces:

ACTION=="add", KERNEL=="hci*", ATTR{address}=="xx:yy:zz:00:00:01", NAME="hci0"
ACTION=="add", KERNEL=="hci*", ATTR{address}=="xx:yy:zz:00:00:02", NAME="hci1"
...

and then set the appropriate bluetooth name:

hciconfig hci0 name foo
hciconfig hci1 name bar
...

Currently I am using a script to do that.

Regards,
Andrej

-- 
Andrej Rosano                                               <andrejro@gmail.com>
0x7B470744                    E5DF 7810 AD63 A215 2D0E  AF56 53C7 A2CB 7B47 0744
