Return-Path: <cyrus@holtmann.org>
Message-Id: <E546BC7F-3BB1-40E6-B78A-211E9522636D@fastmail.com.au>
From: Christopher Armstrong <carmstrong@fastmail.com.au>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 13 Mar 2008 13:52:38 +1100
Subject: [Bluez-users] Buzzing noise on headset
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

Hi all

I'm using bluez 3.28 with a Motorola HS801 headset which I would  
eventually like to setup for voice recording and sound playback.  
Whenever I try to playback a file or record something from the headset  
using aplay/arecord from alsa-utils, all I hear is a low frequency  
buzzing sound that lasts for the duration of the connection.

My headset plays its connection and disconnection tone when I connect  
to it. hcid and bluetoothd-service-audio both show that the headset is  
being connected to (I have hcid running with the -n and -d options).

I have tried two different (brand) bluetooth dongles on two different  
devices but I get the same problem. I am testing against openwrt which  
is a Linux distribution for router-like devices on a ASUS WL500gP  
(Broadcom MIPS architecture). I have also tried the dongles on a PS3  
(powerpc architecture) but that doesn't work either. The builtin  
bluetooth subsystem on the PS3 also fails to work, but it doesn't even  
connect (the sco connection fails for some reason). The kernel version  
on the PS3 is 2.6.23 and the kernel version on the ASUS WL500gP is  
2.4.34, both of which I believe contain the right patches for bluez.

Would anyone have any ideas as to how I could diagnose this problem?

Thanks

Christopher Armstrong
carmstrong __at__ fastmail.com.au




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
