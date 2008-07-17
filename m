Return-Path: <cyrus@holtmann.org>
Message-ID: <a1d1ffe0807171449m5fb5a5aauce8bd14fa05d8719@mail.gmail.com>
Date: Thu, 17 Jul 2008 17:49:42 -0400
From: Sam <rotisseriecat@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: bluez-utils compilation error.
In-Reply-To: <a1d1ffe0807170424r7ae9fa84pa55a504432a8e70e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a1d1ffe0807170424r7ae9fa84pa55a504432a8e70e@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm still encountering compile errors for bluez-utils.  Here are the
bash commands used:

cd '/home/g/bluez-libs-3.36'
./configure --prefix=/g
make
sudo make install

cd home/g/bluez-utils-3.36
./configure --prefix=/g --mandir=/g/share/man  --sysconfdir=/etc
--localstatedir=/var --libexecdir=/lib --enable-all
make
sudo make install

Here's the error:

make  all-am
make[3]: Entering directory `/home/g/bluez-utils-3.36/hcid'
gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include
-I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include   -I../gdbus
-DPLUGINDIR=\""/g/lib/bluetooth/plugins"\" -Wall -O2
-D_FORTIFY_SOURCE=2 -fPIE -MT security.o -MD -MP -MF
.deps/security.Tpo -c -o security.o security.c
security.c: In function 'link_key_request':
security.c:279: error: storage size of 'req' isn't known
security.c:291: error: 'HCIGETAUTHINFO' undeclared (first use in this function)
security.c:291: error: (Each undeclared identifier is reported only once
security.c:291: error: for each function it appears in.)
security.c:279: warning: unused variable 'req'
security.c: At top level:
security.c:1037: fatal error: opening dependency file
.deps/security.Tpo: Permission denied
compilation terminated.
make[3]: *** [security.o] Error 1
make[3]: Leaving directory `/home/g/bluez-utils-3.36/hcid'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/g/bluez-utils-3.36/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/g/bluez-utils-3.36'
make: *** [all] Error 2


I did compile/install the libs first, though they are out of order in
the full bash pastebin: http://paste.ubuntu.com/27889/
If anyone can help, it'd be greatly appreciated!
(Is it possible to find a .deb package of bluez-utils with all the
tools enabled?)

Thank you,

Sam
