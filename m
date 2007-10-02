Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon,  1 Oct 2007 21:30:59 -0300
Message-Id: <JP9DFN$2CC7FDC0DC59E96AF33FC3C7C4E3D353@multidominios>
MIME-Version: 1.0
From: "vcallegari" <vcallegari@terra.com.br>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Need help to Bluez works on the same distance that
	Bluesoleil ?
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

Hello everybody.

This is the first time I write, but I'm following Bluez development since some months ago.
I have my linux debian with 2.6.22 kernel (unstable) and a dongle USB of CSR, bluecore 4, class 1. Also I have installed the 
obexftpd to receive archives. Over the same desk, there is a PC of my girlfriend with windows and a software Bluesolei with the 
same dongle bluetooth. If I am very near, i can send an archive to both computers (my linux and my girlfriend windows) from my 
mobile, Motorola V3.

In fact, over Bluesoleil it always works, but in the Linux, just sometimes. And the Linux is always slower than the Bluesoleil. Now, 
if I go to another room, the windows continues working without delays, but in the linux only establish the connection obex and 
then, few seconds later, I receive a timeout. And sometimes not even that. Should that works equal in Linux and Windows, isn't it 
? I'd like to know if it has some special configuration that I need, to get the same performance (in the linux and windows) ?

I already tried to exchange the dongles between PCs, even I connected the HD of the linux in the PC of my girlfriend, always 
without success.

As far, I read  in these cases I have to try  > hcidump -X -V,  I did it and obtained these lines:

2007-10-01 18:00:23.644457 > ACL data: handle 42 flags 0x02 dlen 47
    L2CAP(d): cid 0x0041 len 43 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 39 fcs 0x9a 
        OBEX: Put cmd(c): len 39
        Name (0x01) = Unicode length 14
        0000: 00 61 00 61 00 2e 00 6a  00 70 00 67 00 00        .a.a...j.p.g..
        Type (0x42) = Sequence length 11
        0000: 69 6d 61 67 65 2f 6a 70  65 67 00                 image/jpeg.
        Length (0xc3) = 6215
2007-10-01 18:00:23.645022 < ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0041 len 7 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 3 fcs 0x40 
        OBEX: Put rsp(f): status 100 len 32007-10-01 18:00:23.651443 > HCI Event: Number of Completed Packets (0x13) plen 5
    handle 42 packets 1
2007-10-01 18:00:23.662468 > ACL data: handle 42 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 1
2007-10-01 18:00:33.903432 > ACL data: handle 42 flags 0x02 dlen 224
2007-10-01 18:00:44.153415 > ACL data: handle 42 flags 0x01 dlen 224
2007-10-01 18:00:44.154331 < ACL data: handle 42 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 0 dlci 2 pf 1 ilen 0 fcs 0xd9 
2007-10-01 18:00:44.155407 > ACL data: handle 42 flags 0x01 dlen 224
2007-10-01 18:01:04.171438 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 42 reason 0x08
    Reason: Connection Timeout

But I cannot understand them. Someone could help-me ?



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
