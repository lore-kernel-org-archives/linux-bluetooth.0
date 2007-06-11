Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <466D2E82.7070805@bluecellnetworks.com>
Date: Mon, 11 Jun 2007 13:14:10 +0200
From: Uli Sesselmann <hans-ulrich.sesselmann@bluecellnetworks.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <E1Hwe2S-0003bG-Gu@mail.sourceforge.net>
	<B4DB78E18F6C47E6BA941FB0F17C6A97@iMe>
In-Reply-To: <B4DB78E18F6C47E6BA941FB0F17C6A97@iMe>
Subject: [Bluez-users] multiple server-instances on one single machine
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

Hello List,

I'm trying to build a Bluteooth - receiver, which uses multiple 
bluetooth-devices and has a server running for each stick.
(Background is, that i need a machine for testing-purposes to test a 
bluetooth-sender. I need multiple parallel connections to test the 
transferspeed etc.)

I Took the sources of obexpushd 0.4 (debianpackage) and modified them, 
so the obexpushd can be started with -DhciX to use a certain hci device. 
This works perfect, if i start the server on hci2 for example, only hci2 
gets the files. The big problem is, when i start a second instance of 
the obexpushd eg. on hci3, only hci3 gets the content and hci2 not.

I tracked down the problem and can say, that the sdpd promotes the 
OBEX-PUSH Service for each stick and not only for the one i want it to.

I altered  the  obexpush-sdp.c file from

  session = sdp_connect(BDADDR_ANY,BDADDR_LOCAL,SDP_RETRY_IF_BUSY);
  status = sdp_record_register(session,rec,0);

to

  session = sdp_connect(&btdev,BDADDR_LOCAL,SDP_RETRY_IF_BUSY);
  status = sdp_record_register(session,rec,0);

where btdev is the bdaddr_t of the wanted hci-device, but i still get 
all running services promoted on all hci-devices.

example:
i have 4 BT-Sticks attached to my system and run one instance of 
obexpushd on each stick on one own channel (hci-id +1, eg. hci0 on 
channel 1). Now i want to have one independent Server-instance, that is 
promoted by sdpd on this device and can receive data.

when i now use sdptool browse xx:xx:xx:xx:xx:xx, i get the service 
promoted on every device attached.

sdptool browse 0:15:83:B9:ED:DD returns

Browsing 00:15:83:B9:ED:DD ...
Service Name: OBEX Object Push
Service Description: dummy description
Service Provider: obexpushd
Service RecHandle: 0x10000
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 1
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX Object Push
Service Description: dummy description
Service Provider: obexpushd
Service RecHandle: 0x10001
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX Object Push
Service Description: dummy description
Service Provider: obexpushd
Service RecHandle: 0x10002
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100

Service Name: OBEX Object Push
Service Description: dummy description
Service Provider: obexpushd
Service RecHandle: 0x10003
Service Class ID List:
  "OBEX Object Push" (0x1105)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 4
  "OBEX" (0x0008)
Profile Descriptor List:
  "OBEX Object Push" (0x1105)
    Version: 0x0100


When i start multiple instances, always the last one i started is the 
one that works.


Has anyone a tip for me, how i can manage to get multiple 
server-services on one machine?

greetings,
Uli





-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
