Return-Path: <cijoml@volny.cz>
From: CIJOML <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net, marcel@holtmann.org
Subject: Phis in /proc/bus/input/devices same for all devices?
Date: Wed, 21 Feb 2007 22:24:47 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200702212224.47446.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Hi all,

I use 2.6.20-mh1 patch and would like to differ devices based on Phis, but it 
is the same for all devices??

I: Bus=0005 Vendor=045e Product=007c Version=0035
N: Name="Microsoft Five Button Mouse"
P: Phys=00:0D:88:8E:AB:2F
S: Sysfs=/class/input/input19
H: Handlers=mouse1 event6
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103

I: Bus=0005 Vendor=045e Product=007b Version=0039
N: Name="Microsoft Bluetooth keyboard"
P: Phys=00:0D:88:8E:AB:2F
S: Sysfs=/class/input/input20
H: Handlers=kbd event7
B: EV=12000b
B: KEY=10f80 44007 ffe01878 800d7ff febeffdf f3cfffff ffffffff fffffffe
B: ABS=700 0
B: LED=107

I: Bus=0005 Vendor=046d Product=b3e3 Version=2503
N: Name="Logitech Bluetooth Mediapad"
P: Phys=00:0D:88:8E:AB:2F
S: Sysfs=/class/input/input21
H: Handlers=kbd event8
B: EV=12000f
B: KEY=7fff 2c3027 bf004440 0 0 1 10f80 8807c007 ffe67bfa d9415fff febeffdf 
ffefffff ffffffff fffffffe
B: REL=40
B: ABS=301 0
B: LED=1f

Shouldn't be there it's BDADDR?

Thanks for reply

Michal
