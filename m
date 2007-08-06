Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46B6D6B1.5030007@idlum.be>
Date: Mon, 06 Aug 2007 10:07:13 +0200
From: Pierre-Yves Paulus <py@idlum.be>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <46B6CC07.9010105@idlum.be> <1186386755.20129.1.camel@violet>
In-Reply-To: <1186386755.20129.1.camel@violet>
Content-Type: multipart/mixed; boundary="------------040505090806000509000004"
Subject: Re: [Bluez-devel] "Invalid CID in request"
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040505090806000509000004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

> what kernel are you using? And I need the full trace from the HCI create
> connection to the HCI disconnect.

The kernel used is 2.6.21-2-486 (from debian).

The file I attached to my last e-mail (re-attached to this one) contains 
the output of "hcidump -XV", are you requesting something else?

Best Regards,
Pierre-Yves

--------------040505090806000509000004
Content-Type: text/x-log;
 name="hci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hci.log"

2007-08-05 09:41:17,627 hci2  < HCI Command: Create Connection (0x01|0x0005) plen 13
2007-08-05 09:41:17,659 hci2      bdaddr 00:16:4E:D6:5D:1A ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
2007-08-05 09:41:17,660 hci2      Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
2007-08-05 09:41:17,662 hci2  > HCI Event: Command Status (0x0f) plen 4
2007-08-05 09:41:17,663 hci2      Create Connection (0x01|0x0005) status 0x00 ncmd 1
2007-08-05 09:41:20,678 hci2  > HCI Event: Connect Complete (0x03) plen 11
2007-08-05 09:41:20,680 hci2      status 0x00 handle 11 bdaddr 00:16:4E:D6:5D:1A type ACL encrypt 0x00
2007-08-05 09:41:20,681 hci2  < ACL data: handle 11 flags 0x02 dlen 12
2007-08-05 09:41:20,682 hci2      L2CAP(s): Connect req: psm 1 scid 0x0040
2007-08-05 09:41:20,683 hci2  < HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
2007-08-05 09:41:20,684 hci2      handle 11
2007-08-05 09:41:20,685 hci2  > HCI Event: Command Status (0x0f) plen 4
2007-08-05 09:41:20,686 hci2      Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
2007-08-05 09:41:20,687 hci2  < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
2007-08-05 09:41:20,688 hci2      handle 11 policy 0x0f
2007-08-05 09:41:20,689 hci2      Link policy: RSWITCH HOLD SNIFF PARK 
2007-08-05 09:41:20,691 hci2  > HCI Event: Read Remote Supported Features (0x0b) plen 11
2007-08-05 09:41:20,692 hci2      status 0x00 handle 11
2007-08-05 09:41:20,693 hci2      Features: 0xbf 0xee 0x0f 0x46 0x98 0x19 0x00 0x00
2007-08-05 09:41:20,694 hci2  > HCI Event: Command Complete (0x0e) plen 6
2007-08-05 09:41:20,696 hci2      Write Link Policy Settings (0x02|0x000d) ncmd 1
2007-08-05 09:41:20,696 hci2      status 0x00 handle 11
2007-08-05 09:41:20,697 hci2  > HCI Event: Max Slots Change (0x1b) plen 3
2007-08-05 09:41:20,699 hci2      handle 11 slots 5
2007-08-05 09:41:20,700 hci2  < HCI Command: Remote Name Request (0x01|0x0019) plen 10
2007-08-05 09:41:20,701 hci2      bdaddr 00:16:4E:D6:5D:1A mode 2 clkoffset 0x0000
2007-08-05 09:41:20,702 hci2  > HCI Event: Command Status (0x0f) plen 4
2007-08-05 09:41:20,703 hci2      Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
2007-08-05 09:41:20,800 hci2  > ACL data: handle 11 flags 0x02 dlen 10
2007-08-05 09:41:20,801 hci2      L2CAP(s): Info req: type 2
2007-08-05 09:41:20,802 hci2  < ACL data: handle 11 flags 0x02 dlen 12
2007-08-05 09:41:20,803 hci2      L2CAP(s): Info rsp: type 2 result 1
2007-08-05 09:41:20,804 hci2        Not supported
2007-08-05 09:41:20,966 hci2  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-08-05 09:41:20,967 hci2      handle 11 packets 2
2007-08-05 09:41:28,013 hci2  > ACL data: handle 11 flags 0x02 dlen 16
2007-08-05 09:41:28,031 hci2      L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
2007-08-05 09:41:28,032 hci2        Connection successful
2007-08-05 09:41:28,033 hci2  < ACL data: handle 11 flags 0x02 dlen 12
2007-08-05 09:41:28,034 hci2      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-08-05 09:41:28,035 hci2  > ACL data: handle 11 flags 0x02 dlen 12
2007-08-05 09:41:28,036 hci2      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-08-05 09:41:28,037 hci2  < ACL data: handle 11 flags 0x02 dlen 18
2007-08-05 09:41:28,046 hci2      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
2007-08-05 09:41:28,047 hci2        Success
2007-08-05 09:41:28,048 hci2        MTU 672 
2007-08-05 09:41:28,049 hci2  > ACL data: handle 11 flags 0x02 dlen 12
2007-08-05 09:41:28,050 hci2      L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
2007-08-05 09:41:28,051 hci2  < ACL data: handle 11 flags 0x02 dlen 18
2007-08-05 09:41:28,052 hci2      L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
2007-08-05 09:41:28,053 hci2        Success
2007-08-05 09:41:28,054 hci2        MTU 672 
2007-08-05 09:41:28,055 hci2  > ACL data: handle 11 flags 0x02 dlen 14
2007-08-05 09:41:28,056 hci2      L2CAP(s): Command rej: reason 2 dcid 0x0040 scid 0x0000
2007-08-05 09:41:28,057 hci2        Invalid CID in request
2007-08-05 09:41:28,059 hci2  > HCI Event: Remote Name Req Complete (0x07) plen 255
2007-08-05 09:41:28,060 hci2      status 0x00 bdaddr 00:16:4E:D6:5D:1A name 'Nokia N70'
2007-08-05 09:41:28,216 hci2  > HCI Event: Number of Completed Packets (0x13) plen 5
2007-08-05 09:41:28,217 hci2      handle 11 packets 3
2007-08-05 09:41:28,301 hci2  > ACL data: handle 11 flags 0x02 dlen 14
2007-08-05 09:41:28,303 hci2      L2CAP(s): Command rej: reason 2 dcid 0x0000 scid 0x0040
2007-08-05 09:41:28,304 hci2        Invalid CID in request
2007-08-05 09:41:29,291 hci2  > ACL data: handle 11 flags 0x02 dlen 14
2007-08-05 09:41:29,293 hci2      L2CAP(s): Command rej: reason 2 dcid 0x0000 scid 0x0040
2007-08-05 09:41:29,294 hci2        Invalid CID in request
2007-08-05 09:41:32,094 hci2  > HCI Event: Disconn Complete (0x05) plen 4
2007-08-05 09:41:32,095 hci2      status 0x00 handle 11 reason 0x13
2007-08-05 09:41:32,096 hci2      Reason: Remote User Terminated Connection


--------------040505090806000509000004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--------------040505090806000509000004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------040505090806000509000004--
