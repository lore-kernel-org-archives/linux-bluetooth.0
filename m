Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4641F43B.6070803@idlum.be>
Date: Wed, 09 May 2007 18:18:03 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <462F8FCE.3090102@idlum.be>
	<1177528066.14980.21.camel@aeonflux.holtmann.net>
In-Reply-To: <1177528066.14980.21.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Extremely slow SDP extraction from phone
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Hi Marcel,

>> Problem is that I sometimes encounter very long delays to extract a 
>> record using its handle.
> 
> we should implement a disconnect timeout for the SDP session. It makes
> sense to keep the SDP session open for subsequent SDP request. However
> this hasn't been implemented right now.

If I'm not mistaken, you're talking about keeping the SDP session, which 
  takes place on the L2CAP layer. But the delays I encounter and I'm 
talking about here are not related to time being lost establishing the 
L2CAP connection, as you can see it in the log I attached to me previous 
mail. See this example below (it is extracted from the very same log):

We just extracted a record, so SDP session gets disconnected:

[...]
09:53:23,593 hci1  < ACL data: handle 11 flags 0x02 dlen 12
09:53:23,595 hci1      L2CAP(s): Disconn req: dcid 0x007b scid 0x0040
09:53:23,597 hci1  > ACL data: handle 11 flags 0x02 dlen 12
09:53:23,599 hci1      L2CAP(s): Disconn rsp: dcid 0x007b scid 0x0040

Disconnect done, now we reconnect for the next one:

09:53:23,601 hci1  < ACL data: handle 11 flags 0x02 dlen 12
09:53:23,603 hci1      L2CAP(s): Connect req: psm 1 scid 0x0040
09:53:23,605 hci1  > ACL data: handle 11 flags 0x02 dlen 16
09:53:23,607 hci1      L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0040 
result 1 status 2
09:53:23,609 hci1        Connection pending - Authorization pending
09:53:23,632 hci1  > ACL data: handle 11 flags 0x02 dlen 16
09:53:23,634 hci1      L2CAP(s): Connect rsp: dcid 0x007c scid 0x0040 
result 0 status 0
09:53:23,636 hci1        Connection successful
09:53:23,638 hci1  < ACL data: handle 11 flags 0x02 dlen 12
09:53:23,640 hci1      L2CAP(s): Config req: dcid 0x007c flags 0x00 clen 0
09:53:23,644 hci1  > ACL data: handle 11 flags 0x02 dlen 12
09:53:23,646 hci1      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
09:53:23,648 hci1  < ACL data: handle 11 flags 0x02 dlen 14
09:53:23,650 hci1      L2CAP(s): Config rsp: scid 0x007c flags 0x00 
result 0 clen 0
09:53:23,651 hci1        Success
09:53:23,654 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
09:53:23,655 hci1      handle 11 packets 4
09:53:23,659 hci1  > ACL data: handle 11 flags 0x02 dlen 14
09:53:23,672 hci1      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 
result 0 clen 0
09:53:23,674 hci1        Success
09:53:23,676 hci1  < ACL data: handle 11 flags 0x02 dlen 23
09:53:23,678 hci1      L2CAP(d): cid 0x007c len 19 [psm 1]
09:53:23,680 hci1          SDP SA Req: tid 0x0 len 0xe
09:53:23,681 hci1            handle 0x10000
09:53:23,683 hci1            max 65535
09:53:23,685 hci1            aid(s) 0x0000 - 0xffff
09:53:23,687 hci1            cont 00
09:53:23,841 hci1  > HCI Event: Number of Completed Packets (0x13) plen 5
09:53:23,843 hci1      handle 11 packets 1

At this point connection is established, and our request for the next 
record has been sent: the whole process took only about 250ms.

09:53:33,837 hci1  > ACL data: handle 11 flags 0x02 dlen 101
09:53:33,850 hci1      L2CAP(d): cid 0x0040 len 97 [psm 1]
09:53:33,851 hci1          SDP SA Rsp: tid 0x0 len 0x5c
09:53:33,853 hci1            count 89
[...]

But as you can see, we have to wait for about 10s for the data to start 
to come. This is the unexpected and very unconstant delay I'm talking 
about.

What's happening there?

Pierre-Yves

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
