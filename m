Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Using windows breaks bluetooth in linux? huh
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <419AE72F.3030307@patbert.com>
References: <419AE72F.3030307@patbert.com>
Content-Type: text/plain
Message-Id: <1100673867.7208.128.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 17 Nov 2004 07:44:27 +0100

Hi Patrick,

> I have an Apple BT keyboard and a D-Link usb BT adaptor.
> 
> I have had it up and running in linux now for quite some time without 
> any trouble. I reboot, turn the pc off, whatever, the bluetooth always 
> works.
> 
> But today I booted my pc into windows (half life 2 lol) and thanks to 
> service pack 2 I can now use my BT adaptor in windows so I fiddled 
> around and got the apple keyboard connected.
> 
> So now I reboot back into linux and I cannot for the life of me get 
> bluetooth working again! I have had the pc/keyboard off for an extended 
> period of time, unplugged and plugged the adaptor back in, nothing will 
> get this keyboard connected again!
> 
> 
> Kawaii64 patrick # hidd --search
> Searching ...
>          Connecting to device 00:0A:95:3A:63:E4
> Can't create HID control channel: Permission denied
> 
> 
> And while this is happening hcidump says:
> 
> 
> Kawaii64 ~ # hcidump
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>  > HCI Event: Command Status (0x0f) plen 4
>  > HCI Event: Inquiry Result (0x02) plen 15
>  > HCI Event: Inquiry Complete (0x01) plen 1
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>  > HCI Event: Command Status (0x0f) plen 4
>  > HCI Event: Link Key Request (0x17) plen 6
> < HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
>  > HCI Event: Command Complete (0x0e) plen 10
>  > HCI Event: Connect Complete (0x03) plen 11
> 
> 
> I used the same passkey in windows as I do in linux (0000). I honestly 
> cannot see how running BT while in windows would have any affect on its 
> functioning in linux, especially after everything has been off for a 
> long time in between.
> 
> The only reason I suspect there is a connection is that I had this crop 
> up in the past. For the longest time I stopped using the apple keyboard 
> because after I had it working in linux I rebooted into windows the same 
> day and then it never worked again in linux. I chalked it up to my 
> stupidty but here again it is happening.
> 
> Any idea what is going on here? Is this all unrelated? Thank you for any 
>   insight.

you re-paired your keyboard with Windows and thus the Linux side
provides a wrong link key now. What does "hciconfig -a" say?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
