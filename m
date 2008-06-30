Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 Jun 2008 21:57:28 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: bluez-users@lists.sourceforge.net
Message-ID: <alpine.LNX.1.10.0806292110440.10816@nge2.ngu.pk>
MIME-Version: 1.0
Subject: [Bluez-users] obexd usage?
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



I'm trying out obexd, but I can't get it to do much. I've had opd working for 
obex-push before, and sent vcards and such from a phone to computer. No SDP 
records show for obex-push now. When I send an object from a remote device, 
nothing is transfered to the computer, and the remote system reports an error.

Am I correct in that dbus might start the server by looking 
at /usr/share/dbus-1/services/org.openobex.service? This file points to the 
binary w/its parameters:

[D-BUS Service]
Name=org.openobex
Exec=/usr/sbin/obexd --root /var/btroot --auto-accept --opp

Trying to start obexd from the command line usually results in nothing:

#obexd --help

I figured out some command lines by strings'ing the binary.

#obexd --root /var/btroot --auto-accept --opp
#obexd
#obexd --debug
No server selected (use either --opp or --ftp or both)
#obexd --debug --opp
#

I did manage to get one message that alludes to X11, but this is the console, 
so I'm not sure what that has to do with it. Neither obexd nor dbus link any 
X11 libs.

# obexd -n --root /var/btroot --auto-accept --opp
dbus-launch failed to autolaunch D-Bus session: Autolaunch error: X11 
initialization failed.


DBus is there:

daemon   15185  0.0  0.1   2568   652 ?        Ss   20:59   0:00 
/usr/bin/dbus-daemon --system


#sdptool browse local | grep -i obex

#

The only thing in syslog at the point I tried to send the file was:

2008-06-29T21:08:42.105241-04:00 vdrl obexd[15242]: Enabling debug information
2008-06-29T21:17:44.336818-04:00 vdrl obexd[15393]: Enabling debug information
2008-06-29T21:39:49.280026-04:00 vdrl rsyslogd:-- MARK --
2008-06-29T21:42:17.914270-04:00 vdrl hcid[15199]: link_key_request 
(sba=00:0A:3A:7C:5C:74, dba=00:1C:62:19:B1:6A)



> HCI Event: Remote Name Req Complete (0x07) plen 255
   . j . . b . . L G   V X 8 3 0 0 . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . . . . . . .
   . . . . . . . . . . . . . . .
> HCI Event: Number of Completed Packets (0x13) plen 5
   . . . . .
> ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 11 flags 0x02 dlen 18
     L2CAP(s): Config rsp: scid 0x0070 flags 0x00 result 0 clen 4
       MTU 672
< ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0070 flags 0x00 clen 0
> ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
       Success
> ACL data: handle 11 flags 0x02 dlen 22
     L2CAP(d): cid 0x0040 len 18 [psm 1]
         SDP SSA Req: tid 0x0 len 0xd
           pat uuid-16 0x1105 (OBEXObjPush)
           max 48
           aid(s) 0x0004 (ProtocolDescList)
           cont 00
< ACL data: handle 11 flags 0x02 dlen 14
     L2CAP(d): cid 0x0070 len 10 [psm 1]
         SDP SSA Rsp: tid 0x0 len 0x5
           count 2
           cont 00
> ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0070
< ACL data: handle 11 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0070
> HCI Event: Number of Completed Packets (0x13) plen 5
   . . . . .
> HCI Event: Disconn Complete (0x05) plen 4
   . . . .



Not sure if this helps:

# dbus-monitor --system --monitor

signal sender=org.freedesktop.DBus -> dest=:1.3 path=/org/freedesktop/DBus; 
interface=org.freedesktop.DBus; member=NameAcquired
    string ":1.3"
signal sender=:1.0 -> dest=(null destination) path=/org/bluez/hci0; 
interface=org.bluez.Adapter; member=RemoteDeviceConnected
    string "00:1C:62:19:B1:6A"
signal sender=:1.0 -> dest=(null destination) path=/org/bluez/hci0; 
interface=org.bluez.Adapter; member=RemoteNameUpdated
    string "00:1C:62:19:B1:6A"
    string "LG VX8300"
signal sender=:1.0 -> dest=(null destination) path=/org/bluez/hci0; 
interface=org.bluez.Adapter; member=RemoteDeviceDisconnected   string 
"00:1C:62:19:B1:6A"


How to use obexd?



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
