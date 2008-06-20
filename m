Return-Path: <cyrus@holtmann.org>
Message-ID: <016a01c8d27c$2c0a4f70$6e01a8c0@Raymondpc>
From: "colorant" <colorant@163.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
References: <a481fbf0806190642u6732d93ew7aec2f17d05dc4d8@mail.gmail.com>
Date: Fri, 20 Jun 2008 10:20:13 +0800
MIME-Version: 1.0
Subject: [Bluez-users] How to using security "Auto" in pairing ,
	I tried but not working ?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

    I do not have passkey-agent running , so I try to use auto for security 
and hope it can send back the passkey auto.

My setting in hcid.conf is as below :

options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security auto;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # Do the same as "hciconfig hci0 down" when SetMode("off")
        # is called.
        offmode devdown;

        # Default PIN code for incoming connections
        passkey "1234";
}

But this don't work :

When I try to start the bonding process following 
http://wiki.bluez.org/wiki/HOWTO/Bonding
The output of hcidump :

~ # dbus-send --system --type=method_call --print-reply --dest=org.bluez 
/org/bluez/hci0 org.bluez.Adapter.CreateBonding string:00:02:72:B0:00:26
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:02:72:B0:00:26 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 42 bdaddr 00:02:72:B0:00:26 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 42
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 42 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 42 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 42
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:02:72:B0:00:26 mode 2 clkoffset 0x0000
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 42
    Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 42
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:02:72:B0:00:26
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:02:72:B0:00:26
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:02:72:B0:00:26 name 'Raymond-pc'
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:02:72:B0:00:26
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:02:72:B0:00:26
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
    bdaddr 00:02:72:B0:00:26
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
    status 0x00 bdaddr 00:02:72:B0:00:26
> HCI Event: Auth Complete (0x06) plen 3
    status 0x06 handle 42
    Error: PIN or Key Missing

According to the wiki, this is the senario that : no passkey agent available 
or rejection

But , Since I using security "auto", why it still looking for an agent ?

Raymond







-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
