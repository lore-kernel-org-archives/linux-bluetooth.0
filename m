Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-user@schaettgen.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Transfer link key from/to windows
References: <200504291858.19965@ByZsA>
In-Reply-To: <200504291858.19965@ByZsA>
Cc: Attila Zsigmond <mail@backend-wizard.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iincCAgPaM5aFDQ"
Message-Id: <200504292010.42625.bluez-user@schaettgen.de>
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
Date: Fri, 29 Apr 2005 20:10:42 +0200

--Boundary-00=_iincCAgPaM5aFDQ
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday, 29. April 2005 18:58, Attila Zsigmond wrote:
> Hello,
>
> I have a dual boot PC and I want to connect it to my mobile phone via
> bluetooth. Currently I need enter the pin code each time if I boot the
> other operating system. I know where the link key is in my linux and
> could export link key from windows registry. But I cannot replace them
> each other because they have different length. On linux key is 16 bytes
> length while on windows it is 128. Can bluez be configured to create
> longer link keys? Any other idea?

Maybe you can use the attached script as a starting point, which I just 
rescued from the deepest depths of my harddisk. It's supposed to transfer 
link keys from Linux to Windows.

It's highly unlikely that it works as is, and I didn't touch it since quite a 
while since I don't have a windows installation atm. At least one problem I 
remember was that the acl of some registry key had to be changed manually 
before applying the inf-file, because not even an admin can change (or even 
see?) it by default. I'm quite sure that it's possible to change this with 
some inf-file magic, but I didn't feel motivated enough to investiagte 
further and finally abandoned the whole thing in an unknown state.

All I can promise is that it generates some sort of inf file from the 
link_keys file which you can apply under windows. I even can't remember if it 
ever worked. It's for the XP stack, not for Widcomm btw. Maybe you or someone 
else is motivated enough to make this work. 

Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de

--Boundary-00=_iincCAgPaM5aFDQ
Content-Type: application/x-python;
  name="bt_export_linkkeys"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bt_export_linkkeys"

#!/usr/bin/python
#
# This script extracts the Bluetooth link keys
# from BlueZ's link key file /etc/bluetooth/link_key
# and creates a Windows .inf-file in the current
# directory. This inf-file will install the link keys
# under windows (right click -> install).
#
# By sharing the keys between the MS-Stack and BlueZ
# you avoid the problem that devices have to be pair
# every time you switch the OS while using the same
# Bluetooth dongle.
#
# Copyright 2004 by Fred Schaettgen <bluez.sch@ttgen.net>

import sys

outFileName = "bluez_keys.inf"
keyFileName = "/etc/bluetooth/link_key"

def printError(msg):
    print "ERROR: "+msg
    sys.exit(1)

def toRevHexStr(s, separator):
    ret = ""
    sep = ""
    for c in s:
        ret = hex(int(ord(c))+0x100)[3:6] + sep + ret
        sep = separator
    return ret

def toDosStr(s):
    ret = ""
    for c in s:
        if c=="\n":
            ret = ret + "\r\n"
        else:
            ret = ret + c
    return ret

def writeOut(s):
    global outFile
    outFile.write(toDosStr(s))

keyFile = open(keyFileName, "r")
keyRecordsRaw = []

outFile = open(outFileName, "w")

recordSize = 36
record = keyFile.read(recordSize)
while len(record) == recordSize:
    keyRecordsRaw.append(record)
    record = keyFile.read(recordSize)
if len(record) != 0:
    printError("Unexpected end of link key file!")

keyList = []
for record in keyRecordsRaw:
    d = dict()
    d["if"] = toRevHexStr(record[0:6], "")
    d["dev"] = toRevHexStr(record[6:12], "")
    d["key"] = toRevHexStr(record[12:28], ",")
    keyList.append(d)


writeOut("""\
[Version]
Signature=\"$CHICAGO$\"
AdvancedINF=2.5

; This file will install Bluetooth link keys for
; the Microsoft Bluetooth stack.
;
; Edit this file to suit your needs, then save it,
; right-click the file icon and select \"Install\".
;
; The following lines specify for which device/adapter pair
; a link key is installed.
; Simply remove the lines of the link keys that you don't
; want to import.

[DefaultInstall.NT]
AddReg=BaseKeyTree

""")

for inf in keyList:
    writeOut("AddReg=DEV-"+inf["dev"]+"-"+inf["if"]+"\n")

writeOut("""\

; ----------- End of user modifiable section -------------


[BaseKeyTree]
HKLM,%bthport%\Keys,,,,

[BaseKeyTree.security]
"D:AR(A;CI;GRGW;;;PU)(A;CI;GRGW;;;LS)"

[Strings]
bthport="SYSTEM\CurrentControlSet\Services\BTHPORT\Parameters"

""")

for inf in keyList:
    writeOut("[DEV-" + inf["dev"] + "-" + inf["if"] + "]\n")
    writeOut("HKLM,%bthport%\\Keys\\" + inf["if"])
    writeOut(",\"" + inf["dev"] + "\",0x00000001," + inf["key"] + "\n\n")

outFile.close()
print "BlueZ link keys exported to "+outFileName


--Boundary-00=_iincCAgPaM5aFDQ--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
