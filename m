Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000701c46c08$958becd0$af2dbeac@oemcomputer>
From: "Daniel Stoddart" <d.stoddart@cs.ucl.ac.uk>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <000d01c46b72$fb6af0f0$8425b9ac@oemcomputer> <1090012501.9117.29.camel@pegasus>
Subject: Re: [Bluez-devel] Service registering but not visible
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Sat, 17 Jul 2004 15:15:57 +0100

Hi Marcel,

I tried the commands you suggested with the following results:

root@darkstar:~# hcid
root@darkstar:~# /usr/sbin/sdpd
root@darkstar:~# hcitool dev
Devices:
        hci0    00:0A:3A:50:2F:2D
root@darkstar:~# hcitool inq
Inquiring ...
        00:0E:6D:11:E6:EB       clock offset: 0x4c21    class: 0x500204
root@darkstar:~# sdptool add --channel=13 OPUSH
OBEX Object Push service registered
root@darkstar:~# sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Search failed: Protocol error
root@darkstar:~# hcidump -x
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff

root@darkstar:~# hcidump -x
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  EB E6 11 6D 0E 00 04 02 50 01
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  EB E6 11 6D 0E 00 01
> HCI Event: Command Status (0x0f) plen 4
  00 01 09 04
> HCI Event: Connect Complete (0x03) plen 11
  00 29 00 EB E6 11 6D 0E 00 01 00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  29 00 0E 00
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  EB E6 11 6D 0E 00 01
> HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 29 00
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  29 00 18 CC
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0041
< ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 2 status 0
> HCI Event: Command Status (0x0f) plen 4
  00 01 0F 04
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
  00 29 00 18 CC
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 29 00 01 00
> HCI Event: Max Slots Change (0x1b) plen 3
  29 00 05
> HCI Event: Disconn Complete (0x05) plen 4
  00 29 00 13

The output from "sdptool browse local" seems to point to some kind of
configuration problem. Do i need to
register my local device address to the sdptool or the sdpd?

Thanks

Dan



----- Original Message -----
From: "Marcel Holtmann" <marcel@holtmann.org>
To: "Daniel Stoddart" <d.stoddart@cs.ucl.ac.uk>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sent: Friday, July 16, 2004 10:15 PM
Subject: Re: [Bluez-devel] Service registering but not visible


> Hi Daniel,
>
> > When i add a service using the command
> >
> > root@darkstar:~# sdptool add --channel=13 OPUSH
> >
> > OBEX Object Push service registered
> >
> > And then using my Nokia 6600, search for available services no
> > services are shown.
>
> check with "sdptool browse local" if the service record is really
> present.
>
> Run "hcidump -x" as root to see for what services your phone is
> searching and try to set the correct class of device bits.
>
> Regards
>
> Marcel
>
>



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
