Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: digger vermont <dv_mlist@verizon.net>
To: bluez-users <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1074566227.3670.24.camel@myrna>
Mime-Version: 1.0
Subject: [Bluez-users] Config for Socket CF card
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
Date: Mon, 19 Jan 2004 21:37:08 -0500

Hello All,

I give up. Its time to look for help.  After too much time I discovered
that I was trying to use the wrong module (dtl1_cs) and for all the
threads in the mailing list archives I haven't been able to figure it
out.  Also keep in mind that anything I've done are wild guesses due to
desperation :)

Here's the card I have:

-------------------------------------------
product info: "Socket", "CF+ Personal Network Card Rev 2.5"
  manfid: 0x0104, 0x0096
  function: 2 (serial)
-----------------------------------------

I believe that means I have the infamous revision G.

My laptop is a powerbook G4.  The kernel is 2.6.1-ben1 using devfs.

Cardmgr seems to starting correctly.  Pcmcia had no config for this card
or for the hci_uart so I added an entry to /etc/pcmcia/config.opts.  I
also changed  the port and memory settings for the powerbook.  Is this
correct?

----------------------------------
device "hci_uart"
  class "bluetooth" module "hci_uart"
 
card "Socket Bluetooth Card"
  version "Socket", "CF+ Personal Network Card Rev 2.5"
  manfid 0x0104, 0x0096
  bind "hci_uart"

include port 0x100-0x4ff, port 0x800-0x8ff, port 0xc00-0xcff
include memory 0x80080000-0x8008ffff
-------------------------------------

When I insert the card this is what I get in the log:

----------------------------------------------------
Jan 19 21:24:34 [cardmgr] initializing socket 0
Jan 19 21:24:34 [cardmgr] socket 0: Socket Bluetooth Card
Jan 19 21:24:34 [cardmgr] product info: "Socket", "CF+ Personal Network
Card Rev 2.5"
Jan 19 21:24:34 [cardmgr] manfid: 0x0104, 0x0096  function: 2 (serial)
Jan 19 21:24:34 [cardmgr] executing: 'modprobe hci_uart'
Jan 19 21:24:34 [kernel] Bluetooth: HCI UART driver ver 2.1
Jan 19 21:24:34 [kernel] Bluetooth: HCI H4 protocol initialized
Jan 19 21:24:34 [cardmgr] bind 'hci_uart' to socket 0 failed: Invalid
argument
------------------------------------------------------------


Any help, or directions to where I can find it, would be greatly
appreciated.

Thanks,

digger






-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
