Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4116692D.1060003@patbert.com>
From: Patrick <patbert@patbert.com>
Reply-To: patbert@patbert.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple bluetooth keyboard fun...
References: <4115A5E3.8000107@patbert.com> <1091959881.2773.6.camel@pegasus>	 <411649EB.9020407@patbert.com> <1091980492.2773.33.camel@pegasus>	 <41165ACF.10802@patbert.com> <1091985064.2773.36.camel@pegasus>
In-Reply-To: <1091985064.2773.36.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 08 Aug 2004 13:55:57 -0400

Ah! Now I am getting somewhere...

In my log there were such obvious errors as....

Aug  8 13:38:53 Kawaii64 hcid[7695]: Bluetooth HCI daemon
Aug  8 13:38:53 Kawaii64 hcid[7695]: Can not open /etc/bluetooth/hcid.conf
Aug  8 13:38:53 Kawaii64 hcid[7695]: Config load failed
Aug  8 13:38:53 Kawaii64 hcid[7695]: Can't open PIN file 
/etc/bluetooth/pin. No such file or directory(2)

When bluez installed it made all those files in /usr/etc/bluetooth/ but 
I guess it wasn't looking there so I copied it all over to 
/etc/bluetooth and things are looking up...

So then I was getting things such as:

 > HCI Event: Link Key Request (0x17) plen 6
   E4 63 3A 95 0A 00
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
   E4 63 3A 95 0A 00

hidd said:

Can't create HID control channel: Invalid exchange

So I replaced /etc/bluetooth/pin and /usr/bin/bluepin with the echo 
"PIN:0000" and now it doesnt seem to complain in hcidump:

 > HCI Event: PIN Code Request (0x16) plen 6
   E4 63 3A 95 0A 00
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
   E4 63 3A 95 0A 00 04 30 30 30 30 00 00 00 00 00 00 00 00 00
   00 00 00
 > HCI Event: Command Complete (0x0e) plen 10
   01 0D 04 00 E4 63 3A 95 0A 00

But hidd says:

Can't create HID control channel: Permission denied

So close...

Marcel Holtmann wrote:
> Hi Patrick,
> 
> 
>>I have been typing in "0000 enter" and "1234 enter" to see if I can get 
>>anything to work but no dice. I didn't have to do this on my old machine 
>>though, or is it something you have to do just once and I've since 
>>forgotten having to do it?
>>
>>I uninstalled 2.7 before installing 2.9. I did save the init script 
>>though and I am still using it... you can view it here:
>>
>>http://www.gentoo.org/cgi-bin/viewcvs.cgi/*checkout*/net-wireless/bluez-utils/files/bluetooth.rc?rev=HEAD&content-type=text/plain
>>
>>Anyhow...when I start the script and then do hidd --connect 
>>00:0A:95:3A:63:E4 I just get the connection timed out error after a few 
>>moments. hcidump says:
>>
>>HCIDump - HCI packet analyzer ver 1.10
>>device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
>> > HCI Event: Connect Complete (0x03) plen 11
>>   10 29 00 E4 63 3A 95 0A 00 01 00
>>< HCI Command: Create Connection (0x01|0x0005) plen 13
>>   E4 63 3A 95 0A 00 18 CC 02 00 00 00 01
>> > HCI Event: Command Status (0x0f) plen 4
>>   00 01 05 04
>> > HCI Event: Link Key Request (0x17) plen 6
>>   E4 63 3A 95 0A 00
>> > HCI Event: Connect Complete (0x03) plen 11
>>   10 29 00 E4 63 3A 95 0A 00 01 00
> 
> 
> this actually means that hcid is not running. Check your logfiles.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by OSTG. Have you noticed the changes on
> Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
> one more big change to announce. We are now OSTG- Open Source Technology
> Group. Come see the changes on the new OSTG site. www.ostg.com
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
