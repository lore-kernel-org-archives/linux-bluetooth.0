Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4099DEAB.2080402@dsto.defence.gov.au>
From: Duncan Grove <duncan.grove@dsto.defence.gov.au>
MIME-Version: 1.0
To: h5400-port@handhelds.org, ipaq@handhelds.org,
   bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] PCMCIA bluetooth cards on Ipaq 5400 and above
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 06 May 2004 16:13:55 +0930

Apologies for the cross-post, but I thought my question makes good sense 
in all three forums.

I'm developing some Blueooth-rfcomm applications for Ipaqs (5400 series 
and above) but have found their built-in bluetooth interfaces to be 
terribly unreliable. Until the drivers become more stable, I'd like to 
do my devlopment using a PCMCIA bluetooth card in an expansion sleeve. 
I've tried the bt3c_cs module with a 3Com Bluetooth card (version 2.0) 
which required compiling bluefw for the Ipaq, but didn't have any luck 
with that in the end. Has anyone had any success with other PCMCIA 
bluetooth cards on an Ipaq? I'd rather use a card that doesn't require 
kernel support for loading the firmware - does this mean all hci_uart 
cards? I've specifically been considering the following:

1) 3Com Bluetooth Card (version 3.0) 3CRWB6096B
2) ComOne Platinum Card MC310
3) Brain Boxes BL-500 (H4 or BCSP version?)
4) Socket CF BL4517-386 with PCMCIA adaptor
5) TDK Bluetooth Card or PC Card+

These are all CSR-based and use hci_uart. They vary quite a lot in 
price. Has anyone got any of these working on an Ipaq?

Regards,
Duncan






-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
