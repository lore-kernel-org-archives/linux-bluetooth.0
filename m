Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Apr 2008 15:38:17 +0200
From: Stefan Seyfried <seife@suse.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080404133817.GA8298@suse.de>
References: <16c4cb990804040152m6a6a3eecsc8ff1539cd5df158@mail.gmail.com>
	<16c4cb990804040328i3af92a0x2db7d7297d323d31@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <16c4cb990804040328i3af92a0x2db7d7297d323d31@mail.gmail.com>
Subject: Re: [Bluez-devel] Loading plugin error
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Fri, Apr 04, 2008 at 03:58:31PM +0530, rahul tank wrote:
> Ok .. i tried compiling bluez-utils with --enable-glib option and it solv=
ed
> the issue.

It did not for me.
I configured like this:

./configure --prefix=3D/usr \
	--mandir=3D/usr/share/man \
	--sysconfdir=3D/etc \
	--libdir=3D/usr/lib \
	--libexecdir=3D/lib \
	--localstatedir=3D/var \
	--enable-pie \
	--enable-all --enable-glib

(enable-all should IIUC include enable-glib, but i used it anyway, it did n=
ot
change anything)

starting hcid with "-x -s" gives:

hcid[10053]: Bluetooth HCI daemon
hcid[10053]: HCI dev 0 registered
hcid[10053]: HCI dev 0 already up
hcid[10053]: Device hci0 has been added
hcid[10053]: Starting security manager 0
hcid[10053]: Device hci0 has been activated
hcid[10053]: Starting SDP server
hcid[10053]: Can't load plugin: /usr/lib/bluetooth/plugins/libaudio.so: inv=
alid mode for dlopen(): Invalid argument
hcid[10053]: Can't load plugin: /usr/lib/bluetooth/plugins/libserial.so: in=
valid mode for dlopen(): Invalid argument
hcid[10053]: Can't load plugin: /usr/lib/bluetooth/plugins/libnetwork.so: i=
nvalid mode for dlopen(): Invalid argument
hcid[10053]: Can't load plugin: /usr/lib/bluetooth/plugins/libinput.so: inv=
alid mode for dlopen(): Invalid argument

The plugins are available, unstripped etc:
seife@susi:~> file /usr/lib/bluetooth/plugins/*so
/usr/lib/bluetooth/plugins/libaudio.so:   ELF 32-bit LSB shared object, Int=
el 80386, version 1 (SYSV), not stripped
/usr/lib/bluetooth/plugins/libinput.so:   ELF 32-bit LSB shared object, Int=
el 80386, version 1 (SYSV), not stripped
/usr/lib/bluetooth/plugins/libnetwork.so: ELF 32-bit LSB shared object, Int=
el 80386, version 1 (SYSV), not stripped
/usr/lib/bluetooth/plugins/libserial.so:  ELF 32-bit LSB shared object, Int=
el 80386, version 1 (SYSV), not stripped

Probably i'm doing something stupid, but i have no idea what ;-)

Thanks,

	seife
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
