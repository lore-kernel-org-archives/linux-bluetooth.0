Return-Path: <cyrus@holtmann.org>
Message-ID: <a1d1ffe0807170424r7ae9fa84pa55a504432a8e70e@mail.gmail.com>
Date: Thu, 17 Jul 2008 07:24:57 -0400
From: Sam <rotisseriecat@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: bluez-utils compilation error.
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello. I'm having a bit of trouble compiling bluez-utils using the
.tar.gz source. I need to run this configuration to enable all the
tools (dfutool, etc.)

Here's a pastebin of the bash: http://pastebin.ca/1073779

make[2]: Entering directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
make  all-am
make[3]: Entering directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -I../eglib
-I../gdbus -DPLUGINDIR=\""/g/lib/bluetooth/plugins"\" -Wall -O2
-D_FORTIFY_SOURCE=2 -fPIE -MT security.o -MD -MP -MF
.deps/security.Tpo -c -o security.o security.c
security.c: In function 'link_key_request':
security.c:279: error: storage size of 'req' isn't known
security.c:291: error: 'HCIGETAUTHINFO' undeclared (first use in this function)
security.c:291: error: (Each undeclared identifier is reported only once
security.c:291: error: for each function it appears in.)
security.c:279: warning: unused variable 'req'
make[3]: *** [security.o] Error 1
make[3]: Leaving directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/g/Desktop/bluez/bluez-utils-3.36/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/g/Desktop/bluez/bluez-utils-3.36'
make: *** [all] Error 2

Any thoughts on what might be the trouble would be greatly
appreciated.  Is it possible to find a .deb package of bluez-utils
with all the tools enabled?

Thank you,

Sam
