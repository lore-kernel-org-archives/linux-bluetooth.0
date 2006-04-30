Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <445409F8.3010104@gmail.com>
From: JP Freeley <jpf321@gmail.com>
MIME-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
References: <4453D6C5.6090905@gmail.com>
In-Reply-To: <4453D6C5.6090905@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Re: obtainining client BTADDR during obexserver (1.0-3) session?
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 29 Apr 2006 20:51:04 -0400

Thanks Colllin .. ran into a bit of a snag .. "address already in use on 
channel 1"

I assume that I must use channel 1 since my handheld device has OPUSH on 
channel 1.

# sdptool search opush
Inquiring ...
Searching for opush on 00:07:E0:xx.xx.xx ...
Service Name: OBEX Object Push
Service RecHandle: 0x10001
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
  "OBEX" (0x0008)
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x8cc
  base_offset: 0x100

Perhaps I'm wrong .. thanks...perhaps usefull output below..

$ sobexsrv -l ONPTD -s 1 -iRS -r /tmp -c 1
server bind: : Address already in use

$sdptool browse local
Browsing FF:FF:FF:00:00:00 ...

#hciconfig -a
hci0:   Type: USB
        BD Address: 00:03:C9:xx.xx.xx ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1093 acl:30 sco:0 events:55 errors:0
        TX bytes:1251 acl:30 sco:0 commands:31 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'Device03-0'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP 
Subver: 0x4127
        Manufacturer: Broadcom Corporation (15)

#rfcomm -a
#





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
