Return-Path: <cyrus@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <200808131716.39806.oliver@neukum.org>
References: <200807311452.24166.oliver@neukum.org>
	 <200808122253.45829.oliver@neukum.org>
	 <1218577018.25524.39.camel@californication>
	 <200808131716.39806.oliver@neukum.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 13 Aug 2008 20:23:01 +0200
Message-Id: <1218651781.25524.61.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > Still testing. I am new to bluetooth so getting a sound testing environment
> > > up takes a bit of time. I am getting iso urbs to complete now.
> > 
> > I think using scotest would be fine in the beginning. It will of course
> > not send proper audio, but you see data going forth and back.
> 
> Compiling scotest is the problem:
> 
> make[3]: Entering directory `/home/oliver/Documents/bluez-utils-3.36/hcid'
> gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd   -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -I../gdbus -DPLUGINDIR=\""/usr/local/lib/bluetooth/plugins"\" -Wall -O2 -D_FORTIFY_SOURCE=2 -fPIE -MT security.o -MD -MP -MF .deps/security.Tpo -c -o security.o security.c
> security.c: In function ‘link_key_request’:
> security.c:279: error: storage size of ‘req’ isn’t known
> security.c:291: error: ‘HCIGETAUTHINFO’ undeclared (first use in this function)
> security.c:291: error: (Each undeclared identifier is reported only once
> security.c:291: error: for each function it appears in.)
> security.c:279: warning: unused variable ‘req’
> make[3]: *** [security.o] Fehler 1
> make[3]: Leaving directory `/home/oliver/Documents/bluez-utils-3.36/hcid'
> make[2]: *** [all] Fehler 2
> make[2]: Leaving directory `/home/oliver/Documents/bluez-utils-3.36/hcid'
> make[1]: *** [all-recursive] Fehler 1
> make[1]: Leaving directory `/home/oliver/Documents/bluez-utils-3.36'
> make: *** [all] Fehler 2

check your ChangeLog file. It says you need a matching or newer
bluez-libs to get it compiled.

Regards

Marcel


