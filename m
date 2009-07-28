Return-Path: <cyrus@holtmann.org>
Subject: Re: Renaming hci interfaces with udev
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrej Rosano <andrejro@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20090728120507.GB3292@stjenka>
References: <20090728083755.GA3292@stjenka>
	 <1248780878.23466.11714.camel@localhost.localdomain>
	 <20090728120507.GB3292@stjenka>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 14:22:27 +0200
Message-Id: <1248783747.28545.225.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrej,

> > > I would like to change the default name of bluetooth interfaces (hci0, hci1, ...)
> > > using udev rules.
> > 
> > Could I ask why you want to do that?
> 
> I have more than one bt dongle connected to the box and I would like to assign always
> the same bluetooth name (the one set with hciconfig hciX name ...), ex:
> 
> the one with BD_ADDR=xx:yy:zz:00:00:01  ->  foo
> the one with BD_ADDR=xx:yy:zz:00:00:02  ->  bar
> ...
> 
> 
> If one could use the udev persistent rules like with ethernet interfaces:
> 
> ACTION=="add", KERNEL=="hci*", ATTR{address}=="xx:yy:zz:00:00:01", NAME="hci0"
> ACTION=="add", KERNEL=="hci*", ATTR{address}=="xx:yy:zz:00:00:02", NAME="hci1"
> ...
> 
> and then set the appropriate bluetooth name:
> 
> hciconfig hci0 name foo
> hciconfig hci1 name bar
> ...
> 
> Currently I am using a script to do that.

and actually bluetoothd is doing that for you no matter what the device
name is. You just have to set the name once using the D-Bus interface.

Regards

Marcel


