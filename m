Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <7ceeaed30608051104n266c2cd4m28382c474a41dc58@mail.gmail.com>
Date: Sat, 5 Aug 2006 20:04:14 +0200
From: Arkaitz <arkaitzj@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] SCO Connection not working in handsfree with a Nokia
	6600
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

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

Maybe im missing something?
Thanks a lot for your time


-- 
Arkaitz

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
