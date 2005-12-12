Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <532f6c3c0512121211j3f1fa779r@mail.gmail.com>
From: Beware of the Hare <hujumuju@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] MSDUN failed. Connection timed out(110)
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
Date: Mon, 12 Dec 2005 21:11:39 +0100

Hi.

I am trying to connect my PocketPC 2003 to the internet via bluetooth.

i have all needed modules

-------------------
rfcomm                 34972  3
l2cap                  22404  5 rfcomm
hci_usb                13192  2
bluetooth              43012  7 rfcomm,l2cap,hci_usb
--------------------------------

and deamons ( HCID, SDPD, DUND) loaded (i think ;)

-------------------
HCID_EXEC=3D"`which $HCID_NAME || true`"
SDPD_EXEC=3D"`which $SDPD_NAME || true`"
HIDD_EXEC=3D"`which $HIDD_NAME || true`"
HID2HCI_EXEC=3D"`which $HID2HCI_NAME || true`"
RFCOMM_EXEC=3D"`which $RFCOMM_NAME || true`"
PAND_EXEC=3D"`which $PAND_NAME || true`"
DUND_EXEC=3D"`which $DUND_NAME || true`"

HCID_ENABLE=3Dtrue
SDPD_ENABLE=3Dtrue
HIDD_ENABLE=3Dfalse
HID2HCI_ENABLE=3Dfalse
RFCOMM_ENABLE=3Dfalse
DUND_ENABLE=3Dtrue
PAND_ENABLE=3Dfalse

HCID_CONFIG=3D"/etc/bluetooth/hcid.conf"
RFCOMM_CONFIG=3D"/etc/bluetooth/rfcomm.conf"

HIDD_OPTIONS=3D""
DUND_OPTIONS=3D"--listen --msdun call dun-mda-bt"
PAND_OPTIONS=3D"--listen --role NAP"
-------------------

dun-mda-bt peer file is:

-------------------
root@pajonk:/etc/ppp/peers # cat /etc/ppp/peers/dun-mda-bt
115200
local
noipdefault
connect "/etc/ppp/at-cmd.pl -v"
noauth
nodefaultroute
192.168.1.1:192.168.1.10
ms-dns 192.168.1.1
------------------

/etc/ppp/at-cmd.pl is a perl script that "do talking":

----------------------------
root@pajonk:/etc/ppp/peers # cat /etc/ppp/at-cmd.pl
#!/usr/bin/perl
#
# Copyright (c) 2004 Henk Vergonet
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#
# This script simulates an 'AT' modem command interface.
# Some dial-up-networking clients (pocketPC 2003 ...) will insist on sendin=
g
# AT command strings before connecting via PPP.
#
# Example ppp/peers/dun script for connecting my MDA to the network.
#  115200
#  local
#  noipdefault
#  connect "/etc/ppp/at-cmd.pl -v"
#  noauth
#  nodefaultroute
#  noipx
#  10.10.10.10:10.10.10.11
#  ms-dns 10.10.10.1
#
use strict;
use Getopt::Std;
use Sys::Syslog;
use POSIX qw(strftime);

my %opt;
getopts('hv', \%opt);

die "Fake at command parser\n\nusage:\n\t-v\tDebug messages in syslog\n"
        if $opt{h};

openlog($0, 'cons,pid', 'user') or die "openlog $!";
END {
        closelog();
}

$/ =3D "\r";
while(<STDIN>)
{
        syslog('debug', "got: $_") if defined $opt{v};
        $_ =3D uc;
        if(/^ATD/) {
                print "CONNECT\r";
                syslog('debug', "send: CONNECT\r") if defined $opt{v};
                exit(0);
        } elsif(/^AT/) {
                print "OK\r";
                syslog('debug', "send: OK\r") if defined $opt{v};
        }
}

-----------------------------

DUN profile is registered by /usr/local/bin/sdptool add DUN

----------------------
root@pajonk:/etc/ppp/peers # /usr/local/bin/sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: Dial-Up Networking
Service RecHandle: 0x10000
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

Service Name: Dial-Up Networking
Service RecHandle: 0x10001
Service Class ID List:
  "Dialup Networking" (0x1103)
  "Generic Networking" (0x1201)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
Profile Descriptor List:
  "Dialup Networking" (0x1103)
    Version: 0x0100

-------------------------------------

Device can be seen:

---------------------------------
root@pajonk:/etc/ppp/peers # /usr/local/bin/hcitool scan
Scanning ...
        00:09:2D:4D:62:FE       MDAcompact
---------------------------------

Now i am trying to connect. Here is the log:

=3D=3D> /var/log/syslog <=3D=3D
Dec 12 21:00:16 pajonk hcid[1952]: link_key_request
(sba=3D00:08:F4:00:70:D3, dba=3D00:09:2D:4D:62:FE)
Dec 12 21:00:26 pajonk dund[2035]: MSDUN failed. Connection timed out(110)

I have no idea what's wrong.

Thank you for any help


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
