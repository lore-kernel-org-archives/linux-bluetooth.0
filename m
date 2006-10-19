Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Delgado, Monica (ERZIA)" <monica.delgado@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Date: Thu, 19 Oct 2006 16:03:04 +0200
MIME-Version: 1.0
In-Reply-To: <mailman.16579.1161261121.22397.bluez-users@lists.sourceforge.net>
Message-Id: <20061019140002.EBD9A216219@mrelay1.st2.lyceu.net>
Subject: Re: [Bluez-users] PAND Network
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net




Hi Marcel,

>> I have been performing test during the last two weeks with my PAN network
>> topology and I get always the same result.
>> 
>> I have been looking for information in this forum and I have found this
>> message:
>> 
>> 
>> 	From: Max Krasnyansky <maxk@qu...>
>> 	Re: Multiple PAN/BNEP connections from 1 machine  
>>	2003-06-12 12:02
>> 
>> 	 At 10:56 AM 6/12/2003, MUSSON MICHAEL JOHN wrote:
>>  
>> 	 >Hello all,
>> 	 >
>> 	 >I just want to know if it"s possible to have one machine with two
>> 	 >BT adapters establish 2 BNEP connections to a separate machine
>> with 	1
>> 	 >adapter. 
>> 	 No it"s not.
>>  
>>  	>If this is not possible, how hard would it be
>> 	 >to hack the code to make it possible?
>> 	 First we"d have to learn how to plug _two_ Ethernet cables
>> 	 into a _single_ port ;-).
>>  
>> 	 Max
>>  
>>  This is exactly my situation, I have two BT adapters in the same PC
trying
>> to establish two BNEP connections to a separate machine with 1 adapter.
As
>> this message is also quite old, isn't it possible now to have one machine
>> with two BT adapters establish 2 BNEP connections to a separate machine
with
>> 1 adapter?.

>I am pretty sure that I have done that before. However you must be
>careful with your master/slave configuration. Also you must be 100% sure
>to pick the second adapter for the second connection.

>If you run "hcidump -X -V", what is actual error you get or is the
>second connection simply not working.


I'm completely sure that I'm using the second adapter for the second
connection because in the hcidump in the master machine I can see the dialog
between the devices, and the BT address of the slave in the second
connection is the address of the second adapter.

If I try the first connection with hci0 and second connection with hc1, this
is what I obtain with the hcidump of the second adapter (hci1):
 

[root@localhost bt_config]# hcidump -i hci1 -X -V

HCI sniffer - Bluetooth packet analyzer ver 1.18

device: hci1 snap_len: 1028 filter: 0xffffffff

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:07:80:80:4B:04 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5

> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1

> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:07:80:80:4B:04 role 0x01
    Role: Slave

> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:07:80:80:4B:04 type ACL encrypt 0x00

< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 15 scid 0x0040

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK

> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 04 4b 80 80 07 00 01                              .K.....

> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41

> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..

> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41

> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
    Connection successful

< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
    MTU 1691

> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41

> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
    Success

> ACL data: handle 41 flags 0x02 dlen 16
   L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
   MTU 1691

< ACL data: handle 41 flags 0x02 dlen 14
   L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
   Success

< ACL data: handle 41 flags 0x02 dlen 11
   L2CAP(d): cid 0x0040 len 7 [psm 15]
   BNEP: Control(0x01|0)
   Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)

> HCI Event: Number of Completed Packets (0x13) plen 5
  handle 41

> HCI Event: Number of Completed Packets (0x13) plen 5
  handle 41

> ACL data: handle 41 flags 0x02 dlen 8
  L2CAP(d): cid 0x0040 len 4 [psm 15]
  BNEP: Control(0x01|0)
  Setup Rsp(0x02) res 0x0000

< ACL data: handle 41 flags 0x02 dlen 12
  L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5
  handle 41

> ACL data: handle 41 flags 0x02 dlen 12
  L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

< HCI Command: Disconnect (0x01|0x0006) plen 3
  handle 41 reason 0x13
  Reason: Remote User Teminated Connection

> HCI Event: Command Status (0x0f) plen 4
  Disconnect (0x01|0x0006) status 0x00 ncmd 1

> HCI Event: Disconn Complete (0x05) plen 4
  status 0x00 handle 41 reason 0x16
  Reason: Connection Terminated by Local Host

I have tried to find where the error "file exists" arises debugging the
source code, and I have found it in this function of bnep.c when trying to
send the ioctl command "bnepconnadd":


static int bnep_connadd(int sk, uint16_t role, char *dev)
{
	struct bnep_connadd_req req;

	strcpy(req.device, dev);
	req.sock = sk;
	req.role = role;
	if (ioctl(ctl, bnepconnadd, &req))
		return -1;
	strcpy(dev, req.device);
	return 0;
} 



I don't know what to do to make this work, if it must work. I use the same
call in the slave devices, but only first bnep connection is established
successfully 

pand  -r PANU --autozap -i hci0 -c 00:07:80:80:4B:04 -n  
pand  -r PANU --autozap -i hci1 -c 00:07:80:80:4B:04 -n

and if I try the second call with a different master the bnep connection is
established ok.


Thank you and best regards,


Monica 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
