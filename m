Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple keyboard
References: <20040210175802.GA17705@mail.gmx.de> <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de>
In-Reply-To: <20040211151146.GA19818@mail.gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402111722.13334.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 11 Feb 2004 17:22:12 +0100

Hi,

switch encrypt and auth off in hcid.conf and try again

Michal

Dne st 11. =FAnora 2004 16:11 Radu Maurer napsal(a):
> On Di, 10 Feb, 2004 at 23:26:19 +0100, Marcel Holtmann wrote:
> > Hi Radu,
> >
> > > What is the method of choice to get an Apple BT keyboard running with
> > > linux?
> >
> > start here http://www.bueche.ch/comp/mx900/mx900.html
>
> thanks Marcel, I followed the instructions there.
> - recompiled the 2.4.24 kernel with your patch for uinput.
> - got libs2 and utils2 from bluez cvs and compiled them
>   (as debian packages).
>
> - made /dev/input/uinput device.
>
> - installed:
> bluetooth-hci_0.1-1_i386.deb
> bluetooth-hid_0.1-1_i386.deb
> bluez-utils_0.1-1_i386.deb
> libbluetooth2-dev_0.1-1_i386.deb
> libbluetooth2_0.1-1_i386.deb
> libbluez1-dev_0.1-1_i386.deb
> libbluez1_0.1-1_i386.deb
>
> - started bthid:
> 	bthid --daemon
>
> /var/log/daemon.log sais:
> bthid[19500]: Bluetooth HID service started
>
> then I try to connect:
> 	bthid -c <Apple Keyboard Address>
>
> I switch on the keyboard, the green LED on the back side starts to blink.
>
> after a few seconds I get the message:
> bthid[19500]: Connection failed: Function not implemented (38)
>
> where do i go from here?
>
> thanks
> Radu
>
>
>
> -------------------------------------------------------
> SF.Net is sponsored by: Speed Start Your Linux Apps Now.
> Build and deploy apps & Web services for Linux with
> a free DVD software kit from IBM. Click Now!
> http://ads.osdn.com/?ad_id=3D1356&alloc_id=3D3438&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
