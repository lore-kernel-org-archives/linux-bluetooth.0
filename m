Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 7610 file transfer to computer
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1102553068.22127.5.camel@nephlim.homenet>
References: <1102381335.13235.8.camel@nephlim.homenet>
	 <1102406104.8447.15.camel@pegasus>
	 <1102438800.21032.3.camel@nephlim.homenet>
	 <1102478181.8447.52.camel@pegasus>
	 <1102553068.22127.5.camel@nephlim.homenet>
Content-Type: text/plain
Message-Id: <1102577073.9988.92.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 09 Dec 2004 08:24:33 +0100

Hi Stefan,

> > is the ACL link still open? Check with "hcitool con". Run "hcidump -X"
> > as root as I told you.
> 
> 
> no there are no active connections.
> 
> Here is the output for the successful transfer:

actually I asked for "hcidump -X" and not "hcidump -x" and it seems that
the RFCOMM channel assignment of OBEX don't works. Must be because the
7610 has a quite crazy way to ask for the OBEX push service record. So
you should try "hcidump --obex=3 -X".

> and here is the output, when I try it again:
> 
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>   C4 0F 15 ED 0E 00 0C 02 50 01
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>   C4 0F 15 ED 0E 00 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 09 04
> > HCI Event: Max Slots Change (0x1b) plen 3
>   01 00 05
> > ACL data: handle 0x0001 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0046
> > HCI Event: Connect Complete (0x03) plen 11
>   00 01 00 C4 0F 15 ED 0E 00 01 00
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   01 00 0F 00
> > HCI Event: Max Slots Change (0x1b) plen 3
>   01 00 05
> > HCI Event: Command Complete (0x0e) plen 6
>   01 0D 08 00 01 00
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>   01 00 18 CC
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 0F 04
> > HCI Event: Connection Packet Type Changed (0x1d) plen 5
>   00 01 00 18 CC
> > HCI Event: Disconn Complete (0x05) plen 4
>   00 01 00 13

The problem is that we get the ACL data for the SDP L2CAP channel before
we got the connect complete for the ACL link. You can't send any data
when your underlaying link is not fully established. What kind of dongle
are you using (hciconfig -a) and what phone (hcitool info)?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
