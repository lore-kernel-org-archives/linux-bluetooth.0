Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4563C044.3030200@comcast.net>
Date: Tue, 21 Nov 2006 22:13:08 -0500
From: dave sailer <d.sailer@comcast.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] hcid.conf multiple dongles
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

I have a Microsoft bluetooth keyboard and mouse that has worked well for
some time. I bought new bluetooth dongle (Kensington) in hopes of
getting my palm to connect via bluetooth (the Microsoft dongle didn't
work for this). With this arrangement, how do I control which dongle the
keyboard & mouse connect to? (it seems more reliable with Microsoft to
Microsoft).

Also, the results of "hci tool scan" are confusing me a bit. For
example, I get...

myth1 ~ # hcitool scan
Scanning ...
        00:50:F2:7E:11:F1       Myth1 Kensington dongle4


firstly, this bdadr is the microsoft dongle. Does this normally return a
dongle address? At one point I'm sure it was returning the palm pilot
address. Secondly, this name "Myth1 Kensington dongle4" is old. I used
to have that in hcid.conf, but changed it and even rebooted the box. 
Just for history, at one point I had an hcid.conf file with only one
device section (no device id's). Now I have the following ... (wasn't
sure about the device syntax, but this seems to work. btw, it would be
nice if the hcid.conf man page was more clear about the syntax on how to
specify multiple devices)


options {
    # Automatically initialize new devices
    autoinit yes;

    # Security Manager mode
    #   none - Security manager disabled (palm fails completely with this)
    #   auto - Use local PIN for incoming connections
    #   user - Always ask user for a PIN
    #
    security user;

    # Pairing mode
    #   none  - Pairing disabled
    #   multi - Allow pairing with already paired devices
    #   once  - Pair once and deny successive attempts
    pairing multi;

    # PIN helper
    pin_helper /etc/bluetooth/pin-helper;
    #pin_helper /usr/bin/bluepin;

    # D-Bus PIN helper
    #dbus_pin_helper;
}

# Default settings for HCI devices
device 00:16:38:BE:F1:21 {
        name "Myth1 Kensington dongle1";
    class 0x020100;
    iscan enable; pscan enable;
    lm accept;
    lp rswitch,hold,sniff,park;
}

device 00:50:F2:7E:11:F1 {
        name "Myth1 Microsoft dongle2";
    class 0x020100;
    iscan enable; pscan enable;
    lm accept;
    lp rswitch,hold,sniff,park;
}


thanks


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
