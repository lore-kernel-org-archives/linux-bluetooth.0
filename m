Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3611f8600602142216l6503d8deub230eb5f5e63076b@mail.gmail.com>
From: Gaby Lence <gabriel.lence@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] obexftp & nokia 6680
In-Reply-To: <1139550190.7791.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3611f8600602090350w6e45325eyec3b85bab18e25a2@mail.gmail.com>
	 <1139550190.7791.2.camel@localhost.localdomain>
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
Date: Wed, 15 Feb 2006 07:16:29 +0100

Thanks for the tips. Obexserver works for me.
Excuse me for not replying to the list but
I request unsuscribing from the list.
Gabriel

On 2/10/06, Fredy P <digitalfredy@debiancolombia.org> wrote:
> El jue, 09-02-2006 a las 12:50 +0100, Gaby Lence escribi=F3:
> read this:
> http://es.wikibooks.org/wiki/Hacks_para_Unix-like:Bluetooth_en_Linux
> > Hi
> > I can put files in my nokia 6680 using obexftp.
> > Instead I didn't get anything when I try to get files using
> > $ obexftpd -b
> try obexftp -b -l
> > No custom transport
> > Waiting for connection...
> > Handling connection...
> > Handling connection...
> > ...
> >
> > This is hcidump just in case someone has deal
> > with it previously.
> >
> > $ hcidump
> > HCI sniffer - Bluetooth packet analyzer ver 1.28
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > > HCI Event: Connect Request (0x04) plen 10
> > < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> > > HCI Event: Command Status (0x0f) plen 4
> > > HCI Event: Connect Complete (0x03) plen 11
> > < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> > > HCI Event: Command Complete (0x0e) plen 6
> > < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> > > HCI Event: Command Status (0x0f) plen 4
> > > HCI Event: Max Slots Change (0x1b) plen 3
> > > ACL data: handle 7 flags 0x02 dlen 12
> >     L2CAP(s): Connect req: psm 1 scid 0x0046
> > < ACL data: handle 7 flags 0x02 dlen 16
> >     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0046 result 0 status 0
> >       Connection successful
> > > ACL data: handle 7 flags 0x02 dlen 12
> >     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> > < ACL data: handle 7 flags 0x02 dlen 14
> >     L2CAP(s): Config rsp: scid 0x0046 flags 0x00 result 0 clen 0
> >       Success
> > < ACL data: handle 7 flags 0x02 dlen 12
> >     L2CAP(s): Config req: dcid 0x0046 flags 0x00 clen 0
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 7 flags 0x02 dlen 14
> >     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
> >       Success
> > > ACL data: handle 7 flags 0x02 dlen 17
> >     L2CAP(d): cid 0x0040 len 13 [psm 1]
> >         SDP SS Req: tid 0x1 len 0x8
> >           pat uuid-16 0x1105 (OBEXObjPush)
> >           max 65535
> >           cont 00
> > < ACL data: handle 7 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0046 len 10 [psm 1]
> >         SDP SS Rsp: tid 0x1 len 0x5
> >           count 0
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 7 flags 0x02 dlen 17
> >     L2CAP(d): cid 0x0040 len 13 [psm 1]
> >         SDP SS Req: tid 0x2 len 0x8
> >           pat uuid-16 0x111b (ImagingResp)
> >           max 65535
> >           cont 00
> > < ACL data: handle 7 flags 0x02 dlen 14
> >     L2CAP(d): cid 0x0046 len 10 [psm 1]
> >         SDP SS Rsp: tid 0x2 len 0x5
> >           count 0
> >           cont 00
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > > ACL data: handle 7 flags 0x02 dlen 12
> >     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0046
> > < ACL data: handle 7 flags 0x02 dlen 12
> >     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0046
> > > HCI Event: Number of Completed Packets (0x13) plen 5
> > ---------------------------------------------------------------
> >
> > Where can I get some help for this?
> > Thanks.
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> > http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=103432&bid#0486&dat=12164=
2
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmdlnk&kid=103432&bid#0486&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
