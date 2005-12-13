Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20051213025947.87747.qmail@web50503.mail.yahoo.com>
From: oj ravadilla <ojravadilla@yahoo.com>
Subject: Re: [Bluez-users] problem adding 1284 ID SDP attribute
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051213020124.42762.qmail@web50501.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Mon, 12 Dec 2005 18:59:47 -0800 (PST)

Hi Marcel,

Just to add.. If I dont use 0x00 to my 1248 id, it
works. But If I put a 0x00 to the data it wont work.
So I guess it is a problem considering that the first
two bytes is the length of the id and for the first
byte  not to be 0x00 I should give a data that the
length is more the 255. for the first to bytes not to
be 0x00, the lowest that i can to use is 0x01 and
0x01... this is equal to 257. Is there a way to
correct this problem?

Thanks for your time.
OJ

--- oj ravadilla <ojravadilla@yahoo.com> wrote:

> Hi Marcel,
> 
> I'm still having problems with the 1248 id. I
> already
> used the bluez-lib-2.23 function
> sdp_data_alloc_with_length for this. Im seeing
> nothing
> still in my 1248 id. 
> 
> Her is the hcidump:
> 
> /root # hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.23
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:02:EE:3C:B0:9A class 0x502204 type ACL
> < HCI Command: Accept Connection Request
> (0x01|0x0009)
> plen 7
>     bdaddr 00:02:EE:3C:B0:9A role 0x01
>     Role: Slave
> > HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status
> 0x00 ncmd 1
> > HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 41 bdaddr 00:02:EE:3C:B0:9A
> type ACL encrypt 0x00
> < HCI Command: Change Connection Packet Type
> (0x01|0x000f) plen 4
>     handle 41 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > HCI Event: Page Scan Repetition Mode Change (0x20)
> plen 7
>     bdaddr 00:02:EE:3C:B0:9A mode 1
> > HCI Event: Command Status (0x0f) plen 4
>     Change Connection Packet Type (0x01|0x000f)
> status
> 0x00 ncmd 1
> > HCI Event: Connection Packet Type Changed (0x1d)
> plen 5
>     status 0x00 handle 41 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0072
> < ACL data: handle 41 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0072
> result 0 status 0
>       Connection successful
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00
> clen
> 0
> < ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0072 flags 0x00
> result 0 clen 0
>       Success
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Config req: dcid 0x0072 flags 0x00
> clen
> 0
> > HCI Event: Max Slots Change (0x1b) plen 3
>     handle 41 slots 5
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 41 packets 1
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 14
>     L2CAP(s): Config rsp: scid 0x0040 flags 0x00
> result 0 clen 0
>       Success
> > ACL data: handle 41 flags 0x02 dlen 17
>     L2CAP(d): cid 0x0040 len 13 [psm 1]
>         SDP SS Req: tid 0x1 len 0x8
>           pat uuid-16 0x1118
>           max 65535
>           cont 00
> < ACL data: handle 41 flags 0x02 dlen 18
>     L2CAP(d): cid 0x0072 len 14 [psm 1]
>         SDP SS Rsp: tid 0x1 len 0x9
>           count 1
>           handle 0x10001
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 41 packets 1
> > ACL data: handle 41 flags 0x02 dlen 33
>     L2CAP(d): cid 0x0040 len 29 [psm 1]
>         SDP SA Req: tid 0x2 len 0x18
>           handle 0x10001
>           max 1024
>           aid(s) 0x0004 (ProtocolDescList) 0x000d
> (IconURL) 0x0350 (unknown) 0x0358 (unknown) 0x035a
> (unknown)
>           cont 00
> < ACL data: handle 41 flags 0x02 dlen 192
> < ACL data: handle 41 flags 0x01 dlen 45
>     L2CAP(d): cid 0x0072 len 233 [psm 1]
>         SDP SA Rsp: tid 0x2 len 0xe4
>           count 225
>           aid 0x0004 (ProtocolDescList)
>              < < uuid-16 0x0100 (L2CAP) > <
>              uuid-16 0x0003 (RFCOMM) uint 0x2 > <
>              uuid-16 0x0008 (OBEX) > >
>           aid 0x000d (IconURL)
>              < < uuid-16 0x0100 (L2CAP) > < uuid-16
> 0x0003 (RFCOMM) uint 0x3 > < uuid-16 0x0008 (OBEX) >
> >
>           aid 0x0350 (unknown)
>              str
>
"application/vnd.pwg-xhtml-print+xml:0.95,application/vnd.pwg-multiplexed"
>           aid 0x0358 (unknown)
>              str ""
>           aid 0x035a (unknown)
>              str "My-Bluetooth"
>           cont 00
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 41 packets 2
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0072
> < ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0072
> > HCI Event: Number of Completed Packets (0x13) plen
> 5
>     handle 41 packets 1
> > HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 41 reason 0x13
>     Reason: Remote User Terminated Connection
> 
> 
> _________
> As seen in the trace --  aid 0x0358 (unknown) is
> blank
> or data is nothing. Do you have any idea whats the
> problem? How do I solve this problem? 
> 
> Thanks for your time.
> 
> OJ
> 
> 
>  
> 
> --- oj ravadilla <ojravadilla@yahoo.com> wrote:
> 
> > Hi Marcel,
> > 
> > I'm having problems like this too. I cant add a
> 1248
> > id because of 0x00 that I assume is interpreted by
> > the
> > bluezstack as a null terminator. 
> > 
> > Thanks!
> > 
> > --- Arch Sayo <a12chi@yahoo.com> wrote:
> > 
> > > Hi Marcel,
> > >    
> > >   I am having a problem adding the 1284ID
> > attribute.
> > > The 1284ID is of type String. (So I use
> > > SDP_TEXT_STR8) However, the first 2 characters
> of
> > > this string are to be interpreted as a 2-byte
> > length
> > > field. The length of my string is 80 which is
> > 0x0050
> > > in HEXADECIMAL. So when I add it as a string,
> the
> > > SDP function interprets the 1st byte as a null
> > > terminator and sends an empty string.
> > >    
> > >   I tried increasing the length of my string to
> > > 0x0101 to avoid a 0x00 byte. However, this
> cannot
> > be
> > > done since the maximum length for an
> SDP_TEXT_STR8
> > > is only 255 which is 0x00FF.
> > >    
> > >   In this case, how will I be able to add a
> 1284ID
> > > string attribute whose length field contains a
> > 0x00
> > > byte?
> > >    
> > >   Thanks,
> > >   Arch Sayo
> > > 
> > > 			
> > > ---------------------------------
> > > Yahoo! Shopping
> > >  Find Great Deals on Holiday Gifts at Yahoo!
> > > Shopping 
> > 
> 
=== message truncated ===


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
