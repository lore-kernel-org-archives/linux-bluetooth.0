Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000201c46c5a$126175d0$13e9baac@oemcomputer>
From: "Daniel Stoddart" <d.stoddart@cs.ucl.ac.uk>
To: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <000d01c46b72$fb6af0f0$8425b9ac@oemcomputer> <1090012501.9117.29.camel@pegasus> <000701c46c08$958becd0$af2dbeac@oemcomputer> <1090078779.4558.35.camel@pegasus>
Subject: Re: [Bluez-devel] Service registering but not visible
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 18 Jul 2004 00:55:51 +0100

Hi Marcel,

It does look like there is something wrong with the sdpd daemon but it does
seem to be running and the sdptool can find services on my nokia 6600.

Below is the output from a "ps aux", a "sdptool search 0x1101" and a
"lsmod". I know there's a lot of info in the ps aux but i thought i'd
show it all to you in case there is something else you might be able to see

root@darkstar:~# hciconfig
hci0:   Type: USB
        BD Address: 00:0A:3A:50:2F:2D ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:135 acl:0 sco:0 events:19 errors:0
        TX bytes:569 acl:0 sco:0 commands:18 errors:0
root@darkstar:~# hcid
root@darkstar:~# /usr/sbin/sdpd
root@darkstar:~# ps aux
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  3.0  0.0   484  236 ?        S    00:35   0:04 init
root         2  0.0  0.0     0    0 ?        SW   00:35   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  00:35   0:00
[ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SW   00:35   0:00 [kswapd]
root         5  0.0  0.0     0    0 ?        SW   00:35   0:00 [bdflush]
root         6  0.0  0.0     0    0 ?        SW   00:35   0:00 [kupdated]
root        10  0.0  0.0     0    0 ?        SW<  00:35   0:00 [mdrecoveryd]
root        23  0.0  0.0     0    0 ?        SW   00:35   0:00 [krfcommd]
root        26  0.0  0.2  1456  560 ?        S    00:35   0:00 hcid:
processing
root       125  0.0  0.0     0    0 ?        SW   00:35   0:00 [knodemgrd_0]
root       142  0.0  0.0     0    0 ?        SW   00:35   0:00 [khubd]
root      1007  0.0  0.2  1436  608 ?        S    00:35   0:00
/usr/sbin/syslogd
root      1044  0.0  0.1  1376  460 ?        S    00:35   0:00
/usr/sbin/klogd -
root      1047  0.0  0.2  1412  540 ?        S    00:35   0:00
/usr/sbin/inetd
root      1068  0.0  0.5  3080 1416 ?        S    00:35   0:00
/usr/sbin/sshd
root      1080  0.0  0.2  1492  552 ?        S    00:35   0:00
/usr/sbin/crond -
daemon    1082  0.0  0.2  1504  644 ?        S    00:35   0:00
/usr/sbin/atd -b
root      1085  0.0  0.8  4828 2064 ?        S    00:35   0:00 sendmail:
accepti
smmsp     1088  0.0  0.7  4732 1952 ?        S    00:35   0:00 sendmail:
Queue r
root      1096  0.0  0.1  1420  472 ?        S    00:35   0:00
/usr/sbin/gpm -m
root      1098  0.0  0.5  2312 1316 tty1     S    00:35   0:00 -bash
root      1099  0.0  0.1  1368  480 tty2     S    00:35   0:00 /sbin/agetty
3840
root      1100  0.0  0.1  1368  480 tty3     S    00:35   0:00 /sbin/agetty
3840
root      1101  0.0  0.1  1368  480 tty4     S    00:35   0:00 /sbin/agetty
3840
root      1102  0.0  0.1  1368  480 tty5     S    00:35   0:00 /sbin/agetty
3840
root      1103  0.0  0.1  1368  480 tty6     S    00:35   0:00 /sbin/agetty
3840
root      1116  0.0  0.3  2044  972 tty1     S    00:36   0:00 /bin/sh
/usr/X11R
root      1128  0.0  0.2  2240  628 tty1     S    00:36   0:00 xinit
/usr/X11R6/
root      1129  3.2  4.5 62768 11764 ?       R<   00:36   0:02 X :0
root      1133  0.0  0.3  2036  932 tty1     S    00:36   0:00 /bin/sh
/usr/X11R
root      1135  0.0  0.3  2052  972 tty1     S    00:36   0:00 /bin/sh
/opt/kde/
root      1153  0.2  3.6 20544 9304 ?        S    00:36   0:00 kdeinit:
Running.
root      1156  0.1  3.6 20252 9348 ?        S    00:36   0:00 kdeinit:
dcopserv
root      1159  0.0  4.0 21616 10404 ?       S    00:36   0:00 kdeinit:
klaunche
root      1161  0.3  4.6 21560 11872 ?       S    00:36   0:00 kdeinit: kded
root      1174  1.3  2.2  9916 5820 ?        S    00:36   0:00
/opt/kde/bin/arts
root      1176  0.2  5.6 26876 14352 ?       S    00:36   0:00 kdeinit:
knotify
root      1177  0.0  0.1  1364  336 tty1     S    00:36   0:00 kwrapper
ksmserve
root      1179  0.2  4.4 21228 11452 ?       S    00:36   0:00 kdeinit:
ksmserve
root      1180  0.6  5.1 23092 13232 ?       S    00:36   0:00 kdeinit:
kwin -se
root      1182  0.2  4.7 21836 12252 ?       S    00:36   0:00 kdeinit:
kwrited
root      1184  1.9  5.6 23852 14380 ?       S    00:36   0:01 kdeinit:
kdesktop
root      1187  1.2  5.8 25296 14968 ?       S    00:36   0:00 kdeinit:
kicker
root      1188  0.0  3.7 20624 9656 ?        S    00:36   0:00 kdeinit:
kio_file
root      1189  0.0  3.7 20580 9644 ?        S    00:36   0:00 kdeinit:
kio_devi
root      1192  0.2  4.9 22592 12708 ?       S    00:36   0:00 kdeinit:
klipper
root      1195  0.1  4.4 21240 11364 ?       S    00:36   0:00 kdeinit:
kaccess
root      1196  2.6  8.5 31620 21932 ?       S    00:36   0:01 kdeinit:
konquero
root      1197  0.4  4.9 22176 12552 ?       S    00:36   0:00
korgac --miniicon
root      1198  3.3  9.1 33312 23432 ?       S    00:36   0:01 kdeinit:
konquero
root      1199  1.4  6.7 27384 17244 ?       S    00:36   0:00 kdeinit:
kwrite -
root      1200  1.6  7.1 27112 18360 ?       S    00:36   0:00 kdeinit:
konquero
root      1201  1.3  6.6 27280 17140 ?       S    00:36   0:00 kdeinit:
kwrite -
root      1202  1.4  6.7 27312 17172 ?       S    00:36   0:00 kdeinit:
kwrite -
root      1203  1.7  6.6 27280 17140 ?       S    00:36   0:00 kdeinit:
kwrite -
root      1204  1.8  6.7 27392 17252 ?       S    00:36   0:00 kdeinit:
kwrite -
root      1205  1.5  6.8 26208 17656 ?       S    00:36   0:00 kdeinit:
konquero
root      1206  1.5  6.8 26176 17620 ?       S    00:36   0:00 kdeinit:
konquero
root      1207  1.1  6.2 26144 16028 ?       S    00:36   0:00 kdeinit:
kwrite -
root      1208  0.0  3.7 20648 9680 ?        S    00:36   0:00 kdeinit:
kio_file
root      1209  1.6  6.8 26220 17672 ?       S    00:36   0:00 kdeinit:
konquero
root      1212  0.0  3.8 21508 9824 ?        S    00:36   0:00 kdeinit:
kio_file
root      1213  0.0  3.8 21532 9880 ?        S    00:36   0:00 kdeinit:
kio_file
root      1218  0.0  3.8 21532 9884 ?        S    00:36   0:00 kdeinit:
kio_file
root      1219  0.0  3.8 21508 9828 ?        S    00:36   0:00 kdeinit:
kio_file
root      1220  0.3  4.3 21156 11080 ?       S    00:36   0:00
kalarmd --login
root      1221  0.0  3.7 20648 9680 ?        S    00:36   0:00 kdeinit:
kio_file
root      1223  0.0  3.8 21508 9844 ?        S    00:36   0:00 kdeinit:
kio_file
root      1224  0.0  3.7 20636 9668 ?        S    00:36   0:00 kdeinit:
kio_file
root      1226  0.9  3.1 16304 8132 ?        S    00:36   0:00
gs -sDEVICE=x11 -
root      1227  0.0  3.7 20648 9680 ?        S    00:36   0:00 kdeinit:
kio_file
root      1229  0.0  3.7 20648 9680 ?        S    00:36   0:00 kdeinit:
kio_file
root      1231  0.0  3.7 20648 9680 ?        S    00:36   0:00 kdeinit:
kio_file
root      1233  0.0  3.7 20648 9680 ?        S    00:36   0:00 kdeinit:
kio_file
root      1234  0.0  3.7 20648 9680 ?        S    00:36   0:00 kdeinit:
kio_file
root      1236  1.3  5.6 25444 14484 ?       S    00:37   0:00 kdeinit:
konsole
root      1237  0.1  0.5  2308 1316 pts/1    S    00:37   0:00 -bash
root      1252  0.0  0.2  1448  560 ?        S    00:37   0:00 hcid:
processing
root      1257  0.0  0.2  1428  536 ?        S    00:37   0:00
/usr/sbin/sdpd
root      1258  0.0  0.4  3016 1068 pts/1    R    00:37   0:00 ps aux
root@darkstar:~# sdptool search 0x1101
Class 0x1101
Inquiring ...
Searching for 0x1101 on 00:0E:6D:11:E6:EB ...
Service Name: Bluetooth Serial Port
Service Description: Bluetooth Serial Port
Service Provider: Symbian Ltd.
Service RecHandle: 0x10002
Service Class ID List:
  "Serial Port" (0x1101)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

root@darkstar:~# lsmod
Module                  Size  Used by    Not tainted
snd-pcm-oss            37252   0
snd-mixer-oss          11992   0  [snd-pcm-oss]
hci_usb                 7736   1
parport_pc             14724   0
parport                23264   0  [parport_pc]
uhci                   24496   0  (unused)
usbcore                58400   1  [hci_usb uhci]
snd-via82xx            11712   0
snd-pcm                55904   0  [snd-pcm-oss snd-via82xx]
snd-timer              13252   0  [snd-pcm]
snd-ac97-codec         37240   0  [snd-via82xx]
snd-page-alloc          6004   0  [snd-via82xx snd-pcm]
snd-mpu401-uart         3136   0  [snd-via82xx]
snd-rawmidi            12512   0  [snd-mpu401-uart]
snd-seq-device          3920   0  [snd-rawmidi]
snd                    27460   0  [snd-pcm-oss snd-mixer-oss snd-via82xx
snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3332   3  [snd]
ohci1394               24200   0  (unused)
ieee1394               42436   0  [ohci1394]
pcmcia_core            40032   0
ide-scsi                9424   0
agpgart                39576   0  (unused)
rfcomm                 30688   0  (unused)
l2cap                  15884   2  [rfcomm]
bluez                  30436   5  [hci_usb rfcomm l2cap]


I hope this helps to decipher the problem.
Also, I'm not too sure what a PSM is - could you explain?

Thanks

Dan




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
