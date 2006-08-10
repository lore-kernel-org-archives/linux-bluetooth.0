Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44DB1CEA.2070001@pracucci.com>
Date: Thu, 10 Aug 2006 11:47:54 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44DA046D.7020600@pracucci.com>
	<1155160420.4492.6.camel@aeonflux.holtmann.net>
In-Reply-To: <1155160420.4492.6.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] connect() and L2CAP_CONN_TIMEOUT
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

Hi Marcel,

I have dump it (hcidump -i hci1 -t -X -V). Here I publish only
interesting commands and events:

2006-08-10 11:10:51.168745 < HCI Command: Create Connection
(0x01|0x0005) plen 13
bdaddr 00:07:80:81:03:E0 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
2006-08-10 11:10:51.171492 > HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x00 ncmd 1

2006-08-10 11:10:54.773623 > HCI Event: Role Change (0x12) plen 8
status 0x00 bdaddr 7B:00:00:01:C3:E0 role 0x00
Role: Master
2006-08-10 11:10:54.921650 > HCI Event: Connect Complete (0x03) plen 11
status 0x21 handle 1 bdaddr 7B:00:00:01:C3:E0 type ACL encrypt 0x00
Error: Role Change Not Allowed

No other related event has been received, but the connect() system call
returns after 40 seconds (2006-08-10 11:11:31). Have you any idea and/or
suggestion?

Marco Pracucci


P.S. bdaddr 7B:00:00:01:C3:E0 is wrong: is it a little bug of hcidump?

>> I need to be sure that an SDP connection does not take more than X
>> seconds. In order to achieve my goal, I have correctly set the page
>> timeout of my local device. However, if I'm right, the page timeout is
>> the max time the local Link Manager will wait for a baseband page
>> response. But what does it happen if the page request is successfully
>> completed and an error occur during the connection to L2CAP remote
>> "layer"? Is there a timeout for this? Maybe L2CAP_CONN_TIMEOUT...
>>
>> I have posted this message, because practical experiments demonstrate
>> that sometimes the sdp_connect() timeout expires after 40 seconds.
>>     
>
> run "hcidump -X -V" to check what timeout you really run into.
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
