Return-Path: <thomas.chiverton@bluefinger.com>
From: Thomas Chiverton <thomas.chiverton@bluefinger.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Help id'ing USB bluetooth adapter
Date: Wed, 11 Feb 2004 13:39:48 +0000
References: <200402111236.34361.thomas.chiverton@bluefinger.com> <1076505074.2777.69.camel@pegasus>
In-Reply-To: <1076505074.2777.69.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402111339.48630.thomas.chiverton@bluefinger.com>
List-ID: <bluez-users.lists.sourceforge.net>

On Wednesday 11 February 2004 13:11 pm, you said:
> it is a CSR BlueCore02 with HCI 16.4 firmware and 56 bit encryption.

Ahh, good, should work :-)

> This looks like an USB problem. What kernel version is it? 

It's wherever RedHat9 is ... uname -a says
Linux charles-compaq 2.4.20-28.9 #1 Thu Dec 18 13:45:22 EST 2003 i686 i686 
i386 GNU/Linux

>Do hciconfig
> shows your Bluetooth adapter?

:goes off and gets that (I got bluez-lib and -utils from up2date).
hci0:   Type: USB
        BD Address: 00:00:00:00:00:00 ACL MTU: 0:0  SCO MTU: 0:0
        DOWN
        RX bytes:0 acl:0 sco:0 events:0 errors:0
        TX bytes:0 acl:0 sco:0 commands:0 errors:0
        Features: 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy:
        Link mode: SLAVE ACCEPT

I'm assuming that means despite the syslog error, things are mostly working, 
though it seems to have failed to detect the address etc. for some reason - 
any further ideas ?

-- 
Tom Chiverton 
Advanced ColdFusion Programmer

Tel: +44(0)1749 834997
email: tom.chiverton@bluefinger.com
BlueFinger Limited
Underwood Business Park
Wookey Hole Road, WELLS. BA5 1AF
Tel: +44 (0)1749 834900
Fax: +44 (0)1749 834901
web: www.bluefinger.com
Company Reg No: 4209395 Registered Office: 2 Temple Back East, Temple
Quay, BRISTOL. BS1 6EG.
*** This E-mail contains confidential information for the addressee
only. If you are not the intended recipient, please notify us
immediately. You should not use, disclose, distribute or copy this
communication if received in error. No binding contract will result from
this e-mail until such time as a written document is signed on behalf of
the company. BlueFinger Limited cannot accept responsibility for the
completeness or accuracy of this message as it has been transmitted over
public networks.***
