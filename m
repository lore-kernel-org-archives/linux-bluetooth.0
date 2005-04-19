Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42654471.7090804@metalan.net>
From: Andre Baron <andre@metalan.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple BT Keyboard and Ubuntu Linux
References: <42649E3C.1080608@metalan.net> <1113907413.16233.167.camel@pegasus>
In-Reply-To: <1113907413.16233.167.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 19 Apr 2005 10:48:33 -0700

Marcel Holtmann wrote:

>Run "hcidump -X -V" as root and show us the dump while you are trying to
>connect. Try to input "0000" on your numeric pad and then press enter or
>call "hciconfig hci0 auth" before you connect for the first time.
>
>Regards
>
>Marcel
>
Hi Marcel

Thanks for the quick response.

Trust Apple to almost conform to standard, but now quite :P.

hcidump -X -V gave me an error message that -V was an invalid option. 
However I ran it without that option and here's the output.

lampshade:/home/andre# hcidump -X
HCIDump - HCI packet analyzer ver 1.12
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  0000: 01                                                .
 > HCI Event: Command Complete (0x0e) plen 4
  0000: 01 20 0c 00                                       . ..
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 08 c8                                    3....
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
 > HCI Event: Inquiry Result (0x02) plen 15
  0000: 01 74 cc 3e 95 0a 00 01  00 00 40 25 00 fb 58     .t.>......@%..X
 > HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 74 cc 3e 95 0a 00 18 cc  01 00 fb d8 01           t.>..........
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
 > HCI Event: Link Key Request (0x17) plen 6
  0000: 74 cc 3e 95 0a 00                                 t.>...
 > HCI Event: PIN Code Request (0x16) plen 6
  0000: 74 cc 3e 95 0a 00                                 t.>...
 > HCI Event: Connect Complete (0x03) plen 11
  0000: 10 29 00 74 cc 3e 95 0a  00 01 00                 .).t.>.....
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  0000: 01                                                .
 > HCI Event: Command Complete (0x0e) plen 4
  0000: 01 20 0c 00                                       . ..
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 74 cc 3e 95 0a 00 18 cc  02 00 00 00 01           t.>..........
 > HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
 > HCI Event: Connect Complete (0x03) plen 11
  0000: 04 00 00 74 cc 3e 95 0a  00 01 00                 ...t.>.....

during which I ran these commands:

lampshade:/etc/network# hciconfig hic0 auth
You have new mail in /var/mail/andre
lampshade:/etc/network# hidd --search
Searching ...
        Connecting to device 00:0A:95:3E:CC:74
Can't create HID control channel: Connection timed out
lampshade:/etc/network# hciconfig hic0 auth
lampshade:/etc/network# hidd --conn 00:0A:95:3E:CC:74
Can't create HID control channel: Host is down

During this time I tried inputting 0000 and hit enter on the Apple keyboard.

Is this an expierence that most people encounter with one of these 
keyboards? I'm just wondering if I should start thinking of trying my 
hand at my first howto describing how to get this up and working.

Thanks Again

Andre


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
