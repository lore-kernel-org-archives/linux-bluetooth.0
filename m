Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] News about the Broadcom BCM92035DGL
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1107433695.11944.48.camel@pegasus>
References: <1107191003.7902.27.camel@pegasus>
	 <1107433695.11944.48.camel@pegasus>
Content-Type: text/plain
Message-Id: <1107521620.6921.19.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 04 Feb 2005 13:53:40 +0100

Hi,

> > the Broadcom dongles with the USB product id 0x2009 like the IOgear
> > GBU311 need a special HCI vendor command to switch from HID into full
> > HCI. Without this command the dongle is working, but only responses to
> > commands in the OGF_INFO_PARAM class. This command is 3B FC 01 00 and
> > the last byte toggles between HCI and HID mode.
> > 
> > < HCI Command: Vendor (0x3f|0x003b) plen 1
> >   0000: 00                                                .
> > > HCI Event: Command Complete (0x0e) plen 4
> >   0000: 01 3b fc 00                                       .;..
> > 
> > Right now I have no solution how to integrate this so that it works
> > nicely, because I don't wanna pollute the Bluetooth core with Broadcom
> > specific hacks. However you can execute "hcitool cmd 3f 3b 00" by hand
> > and after that the mouse and keyboard devices provided by this dongle
> > should disconnect and you can fully use the Bluetooth part.
> 
> so everyone with the IOgear GBU311 or the Microsoft Wireless Transceiver
> for Bluetooth 2.0 should test the attached kernel patch and report back.
> The patch will apply cleanly against 2.6.10-mh3 and 2.6.11-rc3.

so nobody owns the Microsoft Wireless Transceiver for Bluetooth 2.0 and
is willing to test this patch for me. I like to get this patch into the
final 2.6.11 kernel and so I am a little bit in rush.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
