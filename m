Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth hardware that is discoverable by default?
In-Reply-To: <20050121020742.55149.qmail@web25003.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.33.0501211032070.8362-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 21 Jan 2005 10:36:55 +0100 (CET)


Hi Dave,

all "standard" USB dongles behave this way. To get an idea why  read the
standard documents ...

However, you can get a BT serial port adapter (more expensive than USB) or
you can modify the firmware of a standard dongle (you need a
development kit from the BT chip manufacturer for $$$$).

Ciao,
	Peter

On Fri, 21 Jan 2005, Dave West wrote:

> Hi there,
>
> I have very simple requirements for a bluetooth
> 'beacon' that is discoverable, but nothing else (ie.
> it responds to discovery requests, but you don't need
> to connect to it or anything).  At the moment I am
> using a D-Link USB dongle where the USB powerlines are
> soldered to an external power supply.  This supplies
> power to the beacon, but it still needs to connect to
> a linux/bluez equipped laptop (with USB power
> disconnected as it draws its power externally) to
> bring up the device and make it discoverable.
> Immediately disconnecting the bluez laptop you then
> have a cheap standalone beacon as long as the power
> remains.
>
> I'm wondering is there any way to have a beacon like
> this where you don't have to connect it to a laptop
> after its been powered up to make it discoverable?  My
> searches on google and looking at the bluez code make
> me think that normally a HCISETSCAN ioctl is sent to
> the device with SCAN_INQUIRY|SCAN_PAGE option to make
> it discoverable.  My question is are there any dongles
> out there that become discoverable immediately when
> they are powered without having to send them a HCI
> command?  One of you who have written drivers for
> these things might know....
>
> Or if there aren't, can anyone suggest another way I
> might go about making or designing a cheap self
> powered bluetooth beacon that is discoverable on
> powerup?  I may want to manufacture these beacons in
> some quantity later.
>
> Thanks,
> David
>
>
>
>
>
> ___________________________________________________________
> ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
