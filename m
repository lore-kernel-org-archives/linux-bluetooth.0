Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU117-W20D3DB521A58B65CD0748E88F20@phx.gbl>
From: Benson Dong <dongas86.dev@hotmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Tue, 8 Apr 2008 16:00:18 +0800
In-Reply-To: <47FB1295.7070508@tfh-berlin.de>
References: <BLU117-W350837E07CCCAD9D0B092E88F20@phx.gbl>
	<47FB1295.7070508@tfh-berlin.de>
MIME-Version: 1.0
Subject: Re: [Bluez-users] SDP couldn't discovery any device
	or	service	(stlc2500)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1526063657=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1526063657==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi David,

First ,thanks for your reply. :)
 
> your hciconfig output shows, that there is only one BT device with an
> UART interface. If both, UART and headset, are connected, your hciconfig
> shows only one device, missing the headset.
Yes, my BT device(stlc2500) is with an UART interface. It did not connect to the headset since it couldn't find the headset. The sdp service didnot work.

> You are using a BT dev with UART, but did you compile bluez kernel
> module for UART?
I did compile the bluez kernel with hci uart driver supported.
 
>> I wonder only from the output of 'hciconfig -a ',could i make sure
> that the BT Module i used has really got up?
>
> The first "UP" in the third line of hciconfig output means, that the
> device is running.
It's where the question is ,it is running but can't work , that it can't find any other bt device or be found. 
If it could be bt module problem or any other possible problem?

> Kind regards
>
> David

B.R
Benson

> Benson Dong schrieb:
>> The environment i used is BT Module (STLC2500) with bluez 3.26 running on Montavista kernel 2.6.18.
>>
>> Here is hciconfig output:
>> # hciconfig -a
>> hci0: Type: UART
>> BD Address: 00:80:E1:00:AB:BA ACL MTU: 1021:7 SCO MTU: 0:0
>> UP RUNNING PSCAN ISCAN
>> RX bytes:718 acl:0 sco:0 events:23 errors:0
>> TX bytes:369 acl:0 sco:0 commands:23 errors:0
>> Features: 0xff 0xeb 0x8d 0xfe 0x9b 0xe9 0x00 0x00
>> Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>> Link policy: RSWITCH HOLD SNIFF PARK
>> Link mode: ACCEPT MASTER
>> Name: 'BlueZ (0)'
>> Class: 0x080100
>> Service Classes: Capturing
>> Device Class: Computer, Uncategorized
>> HCI Ver: 2.0 (0x3) HCI Rev: 0x402 LMP Ver: 2.0 (0x3) LMP Subver: 0x520
>> Manufacturer: ST Microelectronics (48)
>>
>> I wonder only from the output of 'hciconfig -a ',could i make sure that the BT Module i used has really got up?
>>
>> The following is the output from 'hcidump -x -V &' when trying 'sdptool browse' and 'hcitool scan':
>> # hcidump -x -V &
>> # HCI sniffer - Bluetooth packet analyzer ver 1.41
>> device: hci0 snap_len: 1028 filter: 0xffffffff
>> # sdptool browse
>> Inquiring ...
>> < HCI Command: Inquiry (0x01|0x0001) plen 5
>> lap 0x9e8b33 len 10 num 20
>>> HCI Event: Command Status (0x0f) plen 4
>> Inquiry (0x01|0x0001) status 0x00 ncmd 1
>>> HCI Event: Inquiry Complete (0x01) plen 1
>> status 0x00
>>> HCI Event: Command Status (0x0f) plen 4
>> Unknown (0x00|0x0000) status 0x00 ncmd 2
>> # hcitool scan
>> Scanning ...
>> < HCI Command: Inquiry (0x01|0x0001) plen 5
>> lap 0x9e8b33 len 8 num 0
>>> HCI Event: Command Status (0x0f) plen 4
>> Inquiry (0x01|0x0001) status 0x00 ncmd 1
>>> HCI Event: Inquiry Complete (0x01) plen 1
>> status 0x00
>>> HCI Event: Command Status (0x0f) plen 4
>> Unknown (0x00|0x0000) status 0x00 ncmd 2
>>
>> It couldn't discovery any services with 'sdptool browse' or 'hcitool scan' ,although there's a bt headset openned.
>> It seems that it has a right 'hciconfig -a' output ,but still could not work.Is it a hardware problem or software problem?
>>
>> Could someone give me some hints?
>> Any help would be much appreciated!
>>
>> Best Regards
>> Benson
>>
>>
>> _________________________________________________________________
>> Connect to the next generation of MSN Messenger
>> http://imagine-msn.com/messenger/launch80/default.aspx?locale=en-us&source=wlmailtagline
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
>> Register now and save $200. Hurry, offer ends at 11:59 p.m.,
>> Monday, April 7! Use priority code J8TLD2.
>> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
>> _______________________________________________
>> Bluez-users mailing list
>> Bluez-users@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> Register now and save $200. Hurry, offer ends at 11:59 p.m.,
> Monday, April 7! Use priority code J8TLD2.
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx


--===============1526063657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
--===============1526063657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1526063657==--
