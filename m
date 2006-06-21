Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4498EB58.3090200@ibmt.fraunhofer.de>
References: <4497CE54.5080305@ibmt.fraunhofer.de>
	<4498EB58.3090200@ibmt.fraunhofer.de>
Date: Wed, 21 Jun 2006 11:45:59 +0200
Message-Id: <1150883159.3950.34.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Fwd: Re:  Problem connecting Bluetooth device]
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Harald,

> What does the manual state
> > about Bluetooth pairing etc.
> 
> I don't understand exactly what you mean, therefore the hcid.conf file:
> (the Bluetooth-Device should be SLAVE)

the manual of the device speak at least about pairing etc.

> > The link key you get from the pairing is different from the link key you
> > actually use for authentication in the second try. Please check what has
> > been stored in /var/lib/bluetooth/<bdaddr>/linkkeys.
> 
> The directory /var/lib/bluetooth is empty !!
> 
> It exist two directorys:
> doro:/usr/var/lib/bluetooth/00:0A:3A:64:97:46 #
> doro:/usr/var/lib/bluetooth/00:0B:0D:09:36:E8 #
> 
> (it exist two directorys because I use two USB-Bluetooth connectors)
> 
> linkkeys exist only in:
> 
> doro:/usr/var/lib/bluetooth/00:0A:3A:64:97:46 #
> 
> and contain
> 00:11:B1:A2:01:C9 6F032F60640CF647B6F07173A5A773CD 0
> 
> This entry is older (from March) and different from the key output from
> hcidump : 060E5E846F8206C5AECD5306622526E6
> 
> doro:/usr/var/lib/bluetooth/00:0B:0D:09:36:E8 #
> contains only a file names

Remove all linkkeys files and run "hcidump -X -V" again. Connect to your
device and then compare the link key in the file with the values in the
dump.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
