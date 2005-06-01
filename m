Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429E368C.6020407@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: Re: Plantronics M2500 recording problem
References: <429E3429.6000108@ex.ac.uk>
In-Reply-To: <429E3429.6000108@ex.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 01 Jun 2005 16:28:28 -0600

George,

Just a quick note to let you know I looked over it. Everything looks 
fine. I do not know what is happening.

Are you saying the entire recording is bad if it starts out that way? 
it's not transient like interference?

Brad

George Norton wrote:
> Thanks for the quick reply:
> 
> george@G0on:~$ hciconfig -a
> hci0:   Type: USB
>        BD Address: 00:E0:98:D1:B0:5F ACL MTU: 192:8  SCO MTU: 64:8
>        UP RUNNING PSCAN ISCAN
>        RX bytes:101956 acl:25 sco:1980 events:62 errors:0
>        TX bytes:72654 acl:23 sco:1403 commands:29 errors:0
>        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH HOLD SNIFF PARK
>        Link mode: SLAVE ACCEPT
>        Name: 'G0on-0'
>        Class: 0x000100
>        Service Classes: Unspecified
>        Device Class: Computer, Uncategorized
>        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 
> 0x20d
>        Manufacturer: Cambridge Silicon Radio (10)
> 
> george@G0on:~$ hciconfig hci0 revision
> hci0:   Type: USB
>        BD Address: 00:E0:98:D1:B0:5F ACL MTU: 192:8  SCO MTU: 64:8
>        HCI 16.4
>        Chip version: BlueCore02
>        Max key size: 56 bit
>        SCO mapping:  HCI
> 
> george@G0on:~$ hcitool info 00:03:89:B6:0D:F8
> Requesting information ...
>        BD Address:  00:03:89:B6:0D:F8
>        Device Name: M2500 by Plantronics
>        LMP Version: 1.2 (0x2) LMP Subversion: 0x615
>        Manufacturer: Cambridge Silicon Radio (10)
>        Features: 0xbc 0xe8 0x01 0x00 0x08 0x08 0x00 0x00
>                <encryption> <slot offset> <timing accuracy> <role switch>
>                <sniff mode> <SCO link> <HV3 packets> <u-law log> <A-law 
> log>
>                <CVSD> <AFH cap. slave> <AFH cap. master>
> 
> 
> // While recording in audacity, first recording is normal:
> george@G0on:~$ hcidump -X
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
>> HCI Event: Command Status (0x0f) plen 4
> 
>  0000: 00 01 07 04                                       ....
> 
>> HCI Event: Connect Complete (0x03) plen 11
> 
>  0000: 00 2c 00 f8 0d b6 89 03  00 00 01                 .,.........
> 
>> HCI Event: Command Status (0x0f) plen 4
> 
>  0000: 00 01 06 04                                       ....
> 
>> HCI Event: Disconn Complete (0x05) plen 4
> 
>  0000: 00 2c 00 16                                       .,..
> 
>> HCI Event: Command Status (0x0f) plen 4
> 
>  0000: 00 01 07 04                                       ....
> 
>> HCI Event: Connect Complete (0x03) plen 11
> 
>  0000: 00 30 00 f8 0d b6 89 03  00 00 01                 .0.........
> 
>> HCI Event: Command Status (0x0f) plen 4
> 
>  0000: 00 01 06 04                                       ....
> 
>> HCI Event: Disconn Complete (0x05) plen 4
> 
>  0000: 00 30 00 16                                       .0..
> 
> // A second recording which is corrupted:
> 
>> HCI Event: Command Status (0x0f) plen 4
> 
>  0000: 00 01 07 04                                       ....
> 
>> HCI Event: Connect Complete (0x03) plen 11
> 
>  0000: 00 2c 00 f8 0d b6 89 03  00 00 01                 .,.........
> 
>> HCI Event: Command Status (0x0f) plen 4
> 
>  0000: 00 01 06 04                                       ....
> 
>> HCI Event: Disconn Complete (0x05) plen 4
> 
>  0000: 00 2c 00 16                                       .,..
> 
> // I attempted to record and got a corrupted recording:
> george@G0on:~$ btsco -v 00:03:89:B6:0D:F8
> btsco v0.4c
> Device is 1:0
> Voice setting: 0x0060
> RFCOMM channel 1 connected
> speaker volume: 7 mic volume: 15
> i/o needed: connecting sco...
> connected SCO channel
> Done setting sco fd
> recieved AT+VGS=07
> Sending up speaker change 7
> speaker volume: 7 mic volume: 15
> driver is not in use
> disconnected SCO channel
> 
> Kernel Version: 2.6.11.11
> Distribution: Ubuntu 5.04 (Hoary)
> 
> -George
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
