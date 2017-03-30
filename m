Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
To: Szymon Janc <szymon.janc@codecoup.pl>
CC: Avinash Kadam <avinashk@marvell.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        "Wong, Mun choy" <mun.choy.wong@intel.com>,
        "Zulqarnain, Adam" <adam.zulqarnain@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [EXT] Re: Unexpected SMP Command 0x17
Date: Thu, 30 Mar 2017 00:00:29 +0000
Message-ID: <E3B98393E6037849B63EA428240A6513607C80@PGSMSX103.gar.corp.intel.com>
References: <E3B98393E6037849B63EA428240A651360654F@PGSMSX103.gar.corp.intel.com>
 <3fa5cd6f9317401fbf4da0b5236c1ff1@SC-EXCH02.marvell.com>
 <AC5A66AA-49F3-4F10-8D7A-EDDEC395A4FE@holtmann.org> <1589262.TPhyyzNXdL@ix>
In-Reply-To: <1589262.TPhyyzNXdL@ix>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> On Monday, 27 March 2017 16:55:05 CEST Marcel Holtmann wrote:
> > Hi Avinash,
> >
> > please also refrain from top posting.
> >
> > > Yes, for secure connection the LTK is generated locally.
> > > But issue here is observed that after Pairing is complete the key
> > > distribution is not completed from Master.
> > >
> > > i.e. After Slave sends the  "Signature key:" but Master doesn't
> > > share any key.  Attached logs.
> > I get that and that is clear from the logs. Something is stalling here
> > and because of that, you run into the 30 seconds SMP timeout. We just
> > need to know if the 4.9 kernel is doing this correctly. If so, then
> > you can bi-sect that patch that fixes. Without proof that 4.9 is also
> > broken, nobody will even bother to chase this down.
>=20
> I think the problem here is race between ACL data and HCI events on USB
> dongle...  We get initial slave keys but those get dropped due to encrypt=
ion
> changed event not being received yet. Since keys were silently dropped we=
 later
> on get unexpected SMP PDU and ignoring remaining keys as well which
> eventually leads to SMP timeout.
>=20
> If this is USB dongle (using btusd) then only (AFAIK) solution would be t=
o have a
> workaround for this inside chip (it would delay ACL data received right a=
fter
> encryption change giving host time to handle encpryption change event).
> Bluetooth specification for USB transport is unfortunatelly kinda broken.
>=20
> --
> pozdrawiam
> Szymon Janc

Thank you for your reply. Your inputs are valuable to us in helping to debu=
g the issue. Yes, we are indeed using the btusb kernel module and it is usi=
ng a USB interface (Bluetooth over USB).

I noticed that when btmgmt settings are set to turn 'bredr off', the 'ssp' =
mode also turns off. Is this behavior expected to occur?
My current settings are 'powered connectable discoverable bondable le secur=
e-conn'

Thank you.

Best regards,
Joshua


