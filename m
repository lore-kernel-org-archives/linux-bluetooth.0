Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <8712867d0608231418ld76b304oc8ae4ba1d8269d56@mail.gmail.com>
Date: Wed, 23 Aug 2006 16:18:07 -0500
From: "Jaime Alberto Silva" <jaimealbertosilva@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <8712867d0608231353l6aa027bbha331a44392231f92@mail.gmail.com>
MIME-Version: 1.0
References: <8712867d0608231353l6aa027bbha331a44392231f92@mail.gmail.com>
Subject: [Bluez-users] Fwd: bluez-utils: The inquiry scan (ISCAN) gets
	turned off
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

I'm forwarding this message I recently posted to debian-bugs in order
to see if some of you know how to solve the problem:

---------- Forwarded message ----------
From: Jaime Alberto Silva <jaimealbertosilva@gmail.com>
Date: Aug 23, 2006 3:53 PM
Subject: bluez-utils: The inquiry scan (ISCAN) gets turned off
To: Debian Bug Tracking System <submit@bugs.debian.org>


Package: bluez-utils
Version: 3.1-3.1
Severity: important

Whenever I try to discover the local system (Debian computer) from a remote
system (mobile device, or other computer) it can't be found. After
some research I found out that the ISCAN mode is disabled:

--------------------------------------------------------------------
# hciconfig hci0
hci0:   Type: USB
        BD Address: 00:0E:6D:3B:31:AE ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN
        RX bytes:3190 acl:16 sco:0 events:208 errors:0
        TX bytes:1840 acl:17 sco:0 commands:105 errors:0
--------------------------------------------------------------------

But according to my hcid.conf file it should be enabled by default for
all devices, I'm using the prepackaged hcid.conf :

--------------------------------------------------------------------
# cat /etc/bluetooth/hcid.conf
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
        security auto;

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
        class 0x3e0100;

        # Default packet type
        #pkt_type DH1,DM1,HV1;

        # Inquiry and Page scan
        pscan enable; iscan enable;

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
--------------------------------------------------------------------

In an effort to make the Debian computer visible to other devices
I'm running the following command:

--------------------------------------------------------------------
# hciconfig hci0 piscan
# hciconfig hci0
hci0:   Type: USB
        BD Address: 00:0E:6D:3B:31:AE ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:3294 acl:16 sco:0 events:221 errors:0
        TX bytes:1878 acl:17 sco:0 commands:112 errors:0
--------------------------------------------------------------------

But after a while the ISCAN mode gets disabled and I must keep running
hciconfig to make the computer visible again.

I have tried with two USB-BLUETOOTH dongles of different brands
and the problem persists.

I have also tried it in sid and etch with the same results.

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (500, 'unstable')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.15-1-k7
Locale: LANG=es_CO, LC_CTYPE=es_CO (charmap=ISO-8859-1)

Versions of packages bluez-utils depends on:
ii  libbluetooth2                3.1-1       Library to use the BlueZ Linux Blu
ii  libc6                        2.3.6-18    GNU C Library: Shared libraries
ii  libdbus-1-2                  0.62-4      simple interprocess messaging syst
ii  libdbus-glib-1-2             0.62-4      simple interprocess messaging syst
ii  libglib2.0-0                 2.10.3-3    The GLib library of C routines
ii  libusb-0.1-4                 2:0.1.12-2  userspace USB programming library
ii  lsb-base                     3.1-12      Linux Standard Base 3.1 init scrip
ii  makedev                      2.3.1-82    creates device files in /dev
ii  module-init-tools            3.2.2-3     tools for managing Linux kernel mo
ii  modutils                     2.4.27.0-6  Linux module utilities
ii  sysvinit                     2.86.ds1-15 System-V-like init utilities
ii  udev                         0.093-1     /dev/ and hotplug management daemo

bluez-utils recommends no packages.

-- no debconf information


--
Jaime Alberto Silva       L I N U X       .~.
                                   The Choice     /V\
                                    of a GNU      / ( ) \
                                   Generation    ^^-^^

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
