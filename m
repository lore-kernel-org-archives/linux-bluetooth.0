Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Dongle firmware
References: <20050104110418.M39860@bandos.homelinux.com> <1104841297.8894.92.camel@pegasus> <20050104210042.M19007@bandos.homelinux.com>
In-Reply-To: <20050104210042.M19007@bandos.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501042245.58663.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 4 Jan 2005 22:45:58 +0100

Dne =FAt 4. ledna 2005 22:16 Jose Bernardo Silva napsal(a):
> On Tue, 04 Jan 2005 13:21:37 +0100, Marcel Holtmann wrote
>
> > Hi Jose,
> >
> > > I've seen recently a few messages about new firmwares, is there a list
> > > of dongles and firmwares available?
> > > I have a Acer BT-500 and a MSI MS-6967, and I'd like to update these
> > > two.
> >
> > you should actually ask the vendor of these dongles for updates. However
> > the ACER is a BlueCore01b and can't be updated with the
> > GenericCSR.dfu firmware file and for the MSI I don't know. The
> > general rule at the moment is if "hciconfig hci0 revision" don't
> > show BlueCore02 and lsusb don't show it as a "Cambridge Silicion
> > Radio". You shouldn't even try to update it.
>
> Marcel,
>
> My BT-500 shows in lsusb as " ID 0a12:0001 Cambridge Silicon Radio Ltd.",
> and "hciconfig hci0 revision shows it as a BlueCore02 as follows:
> hci0:   Type: USB
>         BD Address: 00:60:57:32:96:0E ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 14.7
>         Chip version: BlueCore02 (ES2)
>         Max key size: 56 bit
>         SCO mapping:  PCM
>
> Does this mean I can update it? If so, where can I get that GenericCSR.dfu
> firmware, and what can I use to update?

This dongle looks prepared for apple firmware :)

>
> As for the MSI, the lsusb output isn't very promising ("ID 0db0:1967"),
> even thoguh the output of hciconfig is similar:
> hci0:   Type: USB
>         BD Address: 00:10:DC:AF:E1:13 ACL MTU: 192:8  SCO MTU: 64:8
>         HCI 16.4
>         Chip version: BlueCore02
>         Max key size: 56 bit
>         SCO mapping:  HCI

Don't think about flashing MSI, there isn't firmware for it...I own one too=
  :
((

Michal


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
