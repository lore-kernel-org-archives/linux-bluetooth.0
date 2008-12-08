Return-Path: <cyrus@holtmann.org>
Message-ID: <493D7110.1020508@tommie-lie.de>
Date: Mon, 08 Dec 2008 20:10:08 +0100
From: Thomas Liebetraut <thomas@tommie-lie.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: How to set link policy with Logitech diNovo dongle
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi everyone,

I recently got a used Logitech diNovo Media Desktop. It has a bluetooth
hub and the Logitech MX900 bluetooth mouse. I first connected everything
to my laptop with integrated Cambridge Silicon Bluetooth and everything
worked fine. Then I plugged the Logitech hub to my desktop PC and used
hid2hci to switch it over to HCI mode. I configured bluetooth for my
system and connected to all the devices. Keyboard and Media Pad work
fine, but the mouse is jumpy, as if some packets get buffered for some
milliseconds before being send.
I googled around and found a message from 2004 [1] stating that the
link policy has to be set correctly. As you can see from my output of
hciconfig -a (see below), it is not. I have a correct lp line in my
/etc/bluetooth/hcid.conf (see below) and the exact same configuration
enables all lp flags on my laptop's internal bluetooth (plugging in the
Logitech hub to my laptop doesn't set the hub to proper lp either, but
the internal bluetooth works!).
Is there a way I can manually set the link policy? I understand that I
can't use much of the tips from the thread refered to in [1], as the
tools used there are outdated (I don't even have a hcid on my Ubuntu
Intrepid Ibex 8.10 with bluez-utils 4.12 and kernel 2.6.27).
Using another bluetooth mouse (Logitech Travel Mouse) on the Logitech
hub connected to my PC works fine, the problem only occurs with the MX900.

Thanks in advance for any help.

Regards,
Thomas

[1] http://osdir.com/ml/linux.bluez.user/2004-03/msg00147.html

Output of hciconfig -a:
hci0:   Type: USB
        BD Address: 00:07:61:19:49:79 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:688561 acl:44090 sco:0 events:194 errors:0
        TX bytes:3136 acl:107 sco:0 commands:60 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Majestix'
        Class: 0x0a0104
        Service Classes: Networking, Capturing
        Device Class: Computer, Desktop workstation
        HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP Subver:
0x34e
        Manufacturer: Cambridge Silicon Radio (10)


/etc/bluetooth/hcid.conf
#
# HCI daemon configuration file.
#

# HCId options
options {
        # Automatically initialize new devices
        autoinit yes;

        # Security Manager mode
        #   none - Security manager disabled
        #   auto - Use local PIN for incoming connections
        #   user - Always ask user for a PIN
        #
        security user;

        # Pairing mode
        #   none  - Pairing disabled
        #   multi - Allow pairing with already paired devices
        #   once  - Pair once and deny successive attempts
        pairing multi;

        # Default PIN code for incoming connections
        passkey "1234";
}

# Default settings for HCI devices
device {
        # Local device name
        #   %d - device id
        #   %h - host name
        name "%h-%d";

        # Local device class
        class 0x000100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        iscan enable; pscan enable;
        discovto 0;

        # Default link mode
        #   none   - no specific policy
        #   accept - always accept incoming connections
        #   master - become master on incoming connections,
        #            deny role switch on outgoing connections
        lm accept;

        # Default link policy
        #   none    - no specific policy
        #   rswitch - allow role switch
        #   hold    - allow hold mode
        #   sniff   - allow sniff mode
        #   park    - allow park mode
        lp rswitch,hold,sniff,park;
}


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkk9cRAACgkQxVmZpTAq4IiPVQCfX92BhmnXfIDmQa2IYF3TA7YE
fQMAn0I6DuSTcikL6UYgmfdyxkPbS7RQ
=0OVJ
-----END PGP SIGNATURE-----
