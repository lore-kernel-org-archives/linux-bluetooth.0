Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] LAN access devices
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <Pine.BSO.4.53.0411261207460.9290@vakttornet.mynet>
References: <Pine.BSO.4.53.0411261207460.9290@vakttornet.mynet>
Content-Type: text/plain
Message-Id: <1101489877.6514.30.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 26 Nov 2004 18:24:37 +0100

Hi Claes,

> This is not strictly a Bluez question, but anyways... I was thinking if it
> would be possible to use WAP over Bluetooth on a Bluetooth-enabled phone
> to connect to a web server running Bluez. I have a SonyEricsson K700i, and
> as far as I can tell, it does not support the LAN access profile. I don't
> know whether that is required or if there are other ways to accomplish
> this. Are there devices that support this? Not even SonyEricsson P910
> seems to do so.

the K700i contains a SDP record for a WAP client:

Sequence
        Attribute 0x0000 - Service record handle
                UINT32 0x00010007
        Attribute 0x0001 - Service class ID list
                Sequence
                        UUID16 0x1114 - WAP Client
        Attribute 0x0004 - Protocol descriptor list
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                        Sequence
                                UUID16 0x0003 - RFCOMM
                                UINT8 0x0c
        Attribute 0x0005 - Browse group list
                Sequence
                        UUID16 0x1002 - Public Browse Group
        Attribute 0x0009 - Bluetooth profile descriptor list
                Sequence
                        Sequence
                                UUID16 0x1102 - LAN Access Using PPP
                                UINT16 0x0100
        Attribute 0x0100
                String WAP Client

I actually don't know how this may work, but you can try to use dund on
the RFCOMM channel 12. Check the Bluetooth WAP specification for more
details.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
