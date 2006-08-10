Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7ceeaed30608092348o338062f5kc5be0801477880be@mail.gmail.com>
Date: Thu, 10 Aug 2006 08:48:59 +0200
From: Arkaitz <arkaitzj@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] SCO Connection for the handsfree service with a N6600
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

Hi,
I've been using bluez stack for a project and i've a trouble. I
managed to do a stable handsfree connection with a Nokia N90 and a
Motorola V3 using something like the following but through JNI from
java.
As I am unable to make it work with the 6600 i mtrying it in c++ to be
sure that its not a java or JNI problem.
The fact is that i follow these steps:
1) I manually add HF profile to my pc(sdptool add HF)
2) I open a rfcomm connection to the mobile phone at the HFAG service
channel and i send:
       sendCommand(rfsocket,"AT+CGMI\r");
       sleep(1);
       sendCommand(rfsocket,"AT+BRSF=31\r");
       sleep(1);
       sendCommand(rfsocket,"AT+CIND=?\r");
       sleep(1);
       sendCommand(rfsocket,"AT+CIND?\r");
       sleep(1);
       sendCommand(rfsocket,"AT+CMER=?\r");
       sleep(1);
       sendCommand(rfsocket,"AT+CMER=3,0,0,1\r");
       sleep(1);
       sendCommand(rfsocket,"AT+CLIP=1\r");
       sleep(1);
       sendCommand(rfsocket,"AT+NREC=0\r");
       sleep(1);
       sendCommand(rfsocket,"AT+CHLD=?\r");
       sleep(1);

       pthread_create(&scoconth, NULL, scoControllerThread, (void *)sbdaddr);
       sendCommand(rfsocket,"AT+BLDN\r");

3) Before the last command that should do a recall, i start a thread
that will manage the sco connection
3.1) I create a SCO socket, i bind it, listen and the thread waits in
an accept function
4) After asking the recall, the phone should open the scoconnection to
my phone through the socket that is waiting in the accept function,
but it doesnt!!!

The N90 and V3 opened that socket but the 6600 doesn't. Im a bit
confused, because the 6600 lights the handsfree icon in the screen,
but nothing more.

In another code using handsfree i saw a kind of initialization, it
opened the sco socket in client mode and sent a 48 byte packet full of
0s, after taht it closed the socket and opened again in server mode to
start accepting. Ive tried tat kind of initialization too but no way.
Hi,
I've been trying with hcidump but i'm unable to understand exactly what is
happening, could somebody tell me what should i search in the dump?
I've found this:
> ACL data: handle 46 flags 0x02 dlen 12
   L2CAP(s): Disconn req: dcid 0x0041 scid 0x004b
< ACL data: handle 46 flags 0x02 dlen 12
   L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x004b
> HCI Event: Number of Completed Packets (0x13) plen 5
   handle 46 packets 1
> ACL data: handle 46 flags 0x02 dlen 16
> ACL data: handle 46 flags 0x01 dlen 20
   L2CAP(d): cid 0x0040 len 32 [psm 0]

The whole dump is at:

http://wiki.liakona.com/Hcidump_disconnect

I see that the 6600 is doing some SDP, maybe asking for some service
in my laptop? After that when I try to call it asks a disconnection to
the cid 0x0041. The SCO socket is never opened, but I think that that
cid 0x041 connection is something related to the sco connection.
The fact is that I've registered with sdptool add all the services
that sdptool can handle and the disconnection is always there.
Maybe somebody can take a look to the dump and tell me something i don't know.
Thanks a lot for your time.
-- 
Arkaitz

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
