Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Douglas Russell <puggy@gentoo.org>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Logiteh MX900 / USB Bluetooth "dongle" support?
References: <4114CE58.5070302@dark-reality.de> <1091883214.2773.0.camel@pegasus>
In-Reply-To: <1091883214.2773.0.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408071412.54806.puggy@gentoo.org>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 7 Aug 2004 14:12:54 +0100

On Saturday 07 August 2004 13:53, Marcel Holtmann wrote:
> Hi Lars,
>
> > I just bought a Logitech MX900 - works fine with the dongle, as it
> > registers as a native USB HID.
> >
> > But as the USB "dongle" that comes with the mouse also works as a
> > bluetooth device, it would be nice to have support for this.
> >
> > I'm not sure if there already is support, if not, I'd like to have a
> > look at it myself. The thingy reports as two USB devices,
> > "Logitech Inc." and "Texas Instruments, Inc. TUSB2036 HUB". I think the
> > second one might be the Bluetooth device.
> >
> > Any experiences with ti chipsets?
> >
> > or maybe I just overlooked something and everything is already "there"...
>
> I think so, because hid2hci should already support switching it into HCI
> mode.
>
> Regards
>
> Marcel
>
Yeah, that works.

Puggy


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
