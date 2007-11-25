Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 25 Nov 2007 18:26:07 +0100
From: MIGUEL CABANAS <mc354@tid.es>
To: bluez-users@lists.sourceforge.net
Message-id: <fa5d239a8128.8128fa5d239a@tid.es>
MIME-version: 1.0
Subject: [Bluez-users] connecting laptop and mobile phone
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

Hi, 

I am trying to recieve the audio of my mobile phone in my laptop via
bluetooth. 

I am using ubuntu 6.10 and btsco bluetooth audio handler.

after scanning and locating my phone, I get the following error:

mcm@McM:~$ sudo modprobe snd-bt-sco
mcm@McM:~$ sudo btsco -v 00:16:75:F2:DF:FD
btsco v0.42
Device is 1:0
Voice setting: 0x0060
Can't connect RFCOMM channel: Permission denied

any ideas?

thank you
Miguel


I have installed the bluetooth stack and these bluetooth packets:

ii  bluetooth                                  3.9-0ubuntu4            
              Bluetooth stack utilities
ii  bluez-btsco                                0.50-0ubuntu2           
              Bluez Bluetooth SCO tool
ii  bluez-cups                                 3.9-0ubuntu4            
              Bluetooth printer driver for CUPS
ii  bluez-gnome                                0.6-1ubuntu3            
              Bluetooth utilities for GNOME
ii  bluez-hcidump                              1.33-0ubuntu1           
              Analyses Bluetooth HCI packets
ii  bluez-pin                                  0.30-2.1ubuntu3         
              Bluetooth PIN helper with D-BUS support
ii  bluez-utils                                3.9-0ubuntu4            
              Bluetooth tools and daemons
ii  gbtsco                                     0.1.1-0ubuntu1          
              A bluetooth headset manager for gnome
ii  gnome-bluetooth                            0.8.0-0ubuntu4          
              GNOME Bluetooth tools.
ii  libbluetooth2                              3.9-0ubuntu1            
              Library to use the BlueZ Linux Bluetooth stack
ii  libbluetooth2-dev                          3.9-0ubuntu1            
              Development files for using the BlueZ Linux Bluetooth 
ii  python-bluez                               0.9.1-1                 
              Python wrappers around BlueZ for rapid bluetooth devel


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
