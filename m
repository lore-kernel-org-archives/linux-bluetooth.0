Return-Path: <pokui@ucu.ac.ug>
Message-ID: <33086.193.108.254.98.1098195967.squirrel@ucu.ac.ug>
In-Reply-To: <33070.193.108.254.98.1098195146.squirrel@ucu.ac.ug>
References: <34204.81.199.88.27.1098106921.squirrel@ucu.ac.ug>    
    <1098107316.21553.8.camel@pegasus>    
    <34318.81.199.88.27.1098107653.squirrel@ucu.ac.ug>    
    <1098109156.21553.11.camel@pegasus>    
    <32925.193.108.254.98.1098191310.squirrel@ucu.ac.ug>    
    <1098191809.31395.1.camel@pegasus>  
    <33017.193.108.254.98.1098192097.squirrel@ucu.ac.ug>
    <33070.193.108.254.98.1098195146.squirrel@ucu.ac.ug>
Date: Tue, 19 Oct 2004 17:26:07 +0300 (EAT)
Subject: Re: [Bluez-users] travelmate c110
From: pokui@ucu.ac.ug
To: "Marcel Holtmann" <marcel@holtmann.org>,
   "BlueZ Mailing List" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-ID: <bluez-users.lists.sourceforge.net>


>
> how do I enable the "port 5" of my usb hub?

never mind: figured out how to get the acpi module to behave "civily" :-)

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:02:8A:9E:8B:8A ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:107 acl:0 sco:0 events:14 errors:0
        TX bytes:300 acl:0 sco:0 commands:13 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0xff0100
        Service Classes: Positioning, Networking, Rendering, Capturing,
Object Transfer, Audio, Telephony, Information
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)


thanks all.. (maybe I should write an acer c110 howto ;-) )
