Return-Path: <cyrus@holtmann.org>
Message-ID: <272b49620807250956j507f2c0du70aa8d4363fb6957@mail.gmail.com>
Date: Fri, 25 Jul 2008 17:56:53 +0100
From: muckypups <muckypups@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Problems on Fedora 9
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, apologies if this is the wrong place, but the BlueZ site says to
come here for help.
Anyway, I have Fedora 9 x86-64 and I have BlueZ version 0.26 running
as per the OS install. (I didn't know it was installed, but I just
plugged in a BT usb dongle and it was detected immediately)

I have tried to pair with my Motorola HT820 headphones, and it seems
to detect the device fine, and accepts the passcode.

I can browse the device list ok, however, if I click Connect I get an error :

Couldn't display "obex://[00:07:A4:B7:B6:7F]/".
Error: Host down
Please select another viewer and try again.

Thinking that this is an issue with obex I have tried to install the
latest version of obexd (0.3).

When running configure I get the error :

[root@xeon obexd-0.3]# ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether to enable maintainer-specific portions of Makefiles... no
checking for gcc... gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for suffix of executables...
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking whether gcc accepts -fPIE... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking for ranlib... ranlib
checking for tm_gmtoff in struct tm... yes
checking for timezone variable... yes
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for GLIB... yes
checking for DBUS... yes
checking for dbus_watch_get_unix_fd in -ldbus-1... yes
checking for OPENOBEX... no
configure: error: libopenobex is required

So I have located and downloaded openobex-1.3-13.fc9.x86_64.rpm to try
and rectify the apparent lack of libopenobex.

Unfortunately, when I try to install the rpm I get :

	file /usr/lib64/libopenobex.so.1.3.0 from install of
openobex-1.3-13.fc9.x86_64 conflicts with file from package
openobex-1.3-11.fc9.x86_64

So I must assume it is already available, but obexd can't find it.
I have also installed the gnome-bluetooth-devel package provided by
FC9 but to no avail.

In the Bluetooth preferences window, my device is shown as connected,
but in the Browse device window, it is shown as not connected.
I have also set it to be a trusted device.

How can I resolve this ?
I have SE Linux turned off, but do I need to change firewall settings ?
Is this possibly an issue with the headphones themselves ?
Is this an x86 versus x86-64 library issue ?

Thanks in advance.

Alan
