Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ullrich Martini <mailbox@ullrich.martini.name>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2ping Can't connect.: Permission denied
References: <200403232153.26004.mailbox@ullrich.martini.name> <1080076647.2515.47.camel@pegasus>
In-Reply-To: <1080076647.2515.47.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403232243.25854.mailbox@ullrich.martini.name>
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
Date: Tue, 23 Mar 2004 22:43:25 +0100

Hi Marcel,
here's the output of hcidump -x.
ciptool doesn't work also; I thought that if l2ping doesn't work It's no use 
to try anything else.  Do you prefer to try it with ciptool?
hcidump of ciptool is attached below.

hcitool scan
> HCI Event: Command Status(0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 F2 EA
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 3A EB
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 F3 EE
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 F5 FA
> HCI Event: Inquiry Complete(0x01) plen 1
  00
> HCI Event: Command Status(0x0f) plen 4
  00 01 19 04
> HCI Event: Remote Name Req Complete(0x07) plen 255
  00 F5 15 84 0E 04 00 42 6C 75 65 74 6F 6F 74 68 20 49 53 44
  4E 20 41 63 63 65 73 73 20 50 6F 69 6E 74 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# l2ping  00:04:0E:84:15:F5
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete(0x03) plen 11
  05 0C 00 F5 15 84 0E 04 00 01 00



On Tuesday 23 March 2004 22:17, you wrote:
> Hi Ullrich,
>
> > bluez does not work for me. I tried to produce a simple problem with
> > l2ping only. Other things like hcitool cc also don't work.
> > The connection is ok under Windows XP.
> >
> > local device is an AVM BlueFritz!, remote device is an AVM ISDN Access
> > Point
> >
> > # hcitool scan
> > Scanning ...
> >         00:04:0E:84:15:F5       Bluetooth ISDN Access Point
> > # l2ping 00:04:0E:84:15:F5
> > Can't connect.: Permission denied
> >
> > # hcitool cc 0 00:04:0E:84:15:F5
> > Can't create connection: Connection timed out
>
> why don't you try to connect with ciptool?
>
> > hcidump of l2ping 00:04:0E:84:15:F5
> >
> > > HCI Event: Command Status(0x0f) plen 4
> > > HCI Event: Connect Complete(0x03) plen 11
> >
> > hcidump of hcitool cc 00:04:0E:84:15:F5
> >
> > > HCI Event: Command Status(0x0f) plen 4
> > > HCI Event: Connect Complete(0x03) plen 11
>
> Run it with -x to see the error codes.
>
> Regards
>
> Marcel



# ciptool search
Searching ...
        Checking service for 00:04:0E:84:15:F5
        Connecting to device 00:04:0E:84:15:F5
Can't connect L2CAP socket: Invalid argument

> HCI Event: Command Status(0x0f) plen 4
  00 01 01 04
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 0E 3F
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 68 47
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 12 53
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 6A 53
> HCI Event: Inquiry Result(0x02) plen 15
  01 F5 15 84 0E 04 00 01 00 00 14 02 42 13 57
> HCI Event: Inquiry Complete(0x01) plen 1
  00
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04
> HCI Event: Connect Complete(0x03) plen 11
  05 0F 00 F5 15 84 0E 04 00 01 00


regards,
Ullrich



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
