Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <425EAF08.3020701@potchin.co.uk>
From: Jeff <jeff@potchin.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] NAP prob with FC3 & WinXP
References: <425BD0F8.80403@potchin.co.uk> <1113498228.8989.59.camel@pegasus>
In-Reply-To: <1113498228.8989.59.camel@pegasus>
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
Date: Thu, 14 Apr 2005 18:57:28 +0100

I just managed to get it working. The BT stack on XP was corrupt...the 
joys of windows ;)

Its all working now :)

[OT]
Anyone know how to get XP to automatically connect to a PAN on boot?

TIA
Jeff

Marcel Holtmann wrote:

>Hi Jeff,
>
>  
>
>>I having a few probs setting up a BT NAP access point. I'm running...
>>
>>Fedor Core 3 w/ kernel 2.6.9-1.667 (Bluetooth built into the kernel)
>>
>>$ rpm -qa | grep  blue
>>bluez-pin-0.23-3
>>bluez-hcidump-1.11-1
>>bluez-utils-2.10-2
>>bluez-libs-2.10-2
>>bluez-bluefw-1.0-6
>>
>>/etc/bluetooth/hcid.conf....
>>
>>options {
>>        autoinit yes;
>>        security auto;
>>        pairing multi;
>>        pin_helper /usr/bin/bluepin;
>>}
>>device {
>>        name "potchin";
>>        class 0x120104;
>>        iscan enable; pscan enable;
>>        lm accept;
>>        lp rswitch,hold,sniff,park;
>>}
>>
>>
>>
>>with a usb-tech usb BT dongle 
>>(http://www.usbtech.co.uk/catalog/product_info.php/products_id/266)
>>
>>The physical layer seems to be up - i can perform an l2ping to the other 
>>device and get a response. The client machine (Win XP SP2) detects the 
>>Linux box and can see some of the sdp services I add (serial port for 
>>example) but cannot detect the NAP services.
>>
>>I'm running pand with "pand --listen --role=NAP" and it registers the 
>>NAP service with sdp...
>>
>>$ sdptool browse local
>>Browsing FF:FF:FF:00:00:00 ...
>>Service Name: Public Browse Group Root
>>Service Description: Root of public browse hierarchy
>>Service Provider: BlueZ
>>Service RecHandle: 0xf81f9008
>>Service Class ID List:
>>  "Browse Group Descriptor" (0x1001)
>>Language Base Attr List:
>>  code_ISO639: 0x656e
>>  encoding:    0x6a
>>  base_offset: 0x100
>>
>>Service Name: Network Access Point
>>Service RecHandle: 0xf81f96f0
>>Service Class ID List:
>>  "Network access point" (0x1116)
>>Protocol Descriptor List:
>>  "L2CAP" (0x0100)
>>    PSM: 15
>>  "BNEP" (0x000f)
>>    Version: 0x0100
>>    SEQ16: 800 806
>>Profile Descriptor List:
>>  "PAN access point" (0x1116)
>>    Version: 0x0100
>>
>>Service Name: SDP Server
>>Service Description: Bluetooth service discovery server
>>Service Provider: BlueZ
>>Service RecHandle: 0x0
>>Service Class ID List:
>>  "SDP Server" (0x1000)
>>Protocol Descriptor List:
>>  "L2CAP" (0x0100)
>>    PSM: 1
>>    Version: 0x0001
>>Language Base Attr List:
>>  code_ISO639: 0x656e
>>  encoding:    0x6a
>>  base_offset: 0x100
>>
>>
>>
>>
>>
>>Can anyone help - should windows pick up a PAN from the NAP service (Im 
>>using the standard M$ drivers)?
>>    
>>
>
>run "hcidump -X -V" as root and see what the Windows side is looking
>for.
>
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.
>http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
