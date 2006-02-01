Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Gabriel Wicke <lists@wikidev.net>
Message-ID: <pan.2006.02.01.09.16.29.862248@wikidev.net>
References: <pan.2006.01.30.19.35.06.850476@wikidev.net> <19c2b3920601310536l77bdc32ay@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] Re: [micro-howto] Ericsson K700i as hid device (hidd options)
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
Date: Wed, 01 Feb 2006 10:16:31 +0100

On Tue, 31 Jan 2006 14:36:16 +0100, rangzen wrote:

> Still doesn't work for me with a K750i :/
> 
> rm all in /var/lib/bluetooth/
> no device in the phone
> 
> All works fine :)
> 
> But now the device is registred in the phone and the "local" device is in
> /var/lib/bluetooth
> I try again and :
> 
> # /usr/local/sbin/hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.29
> device: hci0 snap_len: 1028 filter: 0xffffffff
>> HCI Event: Connect Request (0x04) plen 10
>     bdaddr 00:16:20:2E:4F:08 class 0x520204 type ACL
> < HCI Command: Accept Connection Request (0x01|0x0009) plen 7
>     bdaddr 00:16:20:2E:4F:08 role 0x00
>     Role: Master
>> HCI Event: Command Status (0x0f) plen 4
>     Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
>> HCI Event: Role Change (0x12) plen 8
>     status 0x00 bdaddr 00:16:20:2E:4F:08 role 0x00
>     Role: Master
>> HCI Event: Link Key Request (0x17) plen 6
>     bdaddr 00:16:20:2E:4F:08
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>     bdaddr 00:16:20:2E:4F:08 key 7D2DBC19D998316AE9DB5D9645707E08
>> HCI Event: Command Complete (0x0e) plen 10
>     Link Key Request Reply (0x01|0x000b) ncmd 1
>     status 0x00 bdaddr 00:16:20:2E:4F:08
>> HCI Event: Connect Complete (0x03) plen 11
>     status 0x00 handle 42 bdaddr 00:16:20:2E:4F:08 type ACL encrypt 0x01
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>     handle 42 policy 0x0f
>     Link policy: RSWITCH HOLD SNIFF PARK
>> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
>     bdaddr 00:16:20:2E:4F:08 mode 1
>> HCI Event: Command Complete (0x0e) plen 6
>     Write Link Policy Settings (0x02|0x000d) ncmd 1
>     status 0x00 handle 42
> < HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
>     handle 42 ptype 0xcc18
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
>> HCI Event: Command Status (0x0f) plen 4
>     Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
>> HCI Event: Connection Packet Type Changed (0x1d) plen 5
>     status 0x00 handle 42 ptype 0xff1e
>     Packet type: DM1 DM3 DM5 DH1 DH3 DH5 2-DH1 2-DH3 2-DH5 3-DH1 3-DH3 3-DH5
>> HCI Event: Max Slots Change (0x1b) plen 3
>     handle 42 slots 5
>> HCI Event: Disconn Complete (0x05) plen 4
>     status 0x00 handle 42 reason 0x13
>     Reason: Remote User Terminated Connection
> 
> :/
> The phone display "Connection failed"

Do you get any messages in /var/log/syslog from hidd?

-- 
Gabriel



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
