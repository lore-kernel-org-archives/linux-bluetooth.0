Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Troy A. Griffitts" <scribe@crosswire.org>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1102374899.3513.10.camel@charis.crosswire.org>
Mime-Version: 1.0
Subject: [Bluez-users] AmbiCom BT2000E
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 06 Dec 2004 16:14:59 -0700

Hey guys.  Has anyone has success using and AmbiCom BT card with kernel
2.6.9?  I just upgraded to FC3 from FC1, which was a 2.4.x to 2.6.x
kernel upgrade.  I used to use the bt950 driver with this card just
fine.  Now I can't seem to get anything to work.


card "AmbiCom BT2000E Bluetooth Card"
  version "AmbiCom,Inc", "BT2000E"
  bind "serial_cs" class "bluetooth"
#  bind "btuart_cs"
#  bind "bt950_cs"

Here is the output with the serial_cs driver:

Dec  6 16:14:23 charis cardmgr[4396]: socket 0: AmbiCom BT2000E
Bluetooth Card
Dec  6 16:14:23 charis kernel: ttyS1 at I/O 0x2f8 (irq = 11) is a
16C950/954
Dec  6 16:14:28 charis cardmgr[4396]: executing: './bluetooth start
ttyS1 2>&1'
Dec  6 16:14:28 charis cardmgr[4396]: + Initialization timed out.




Here is the output with the btuart_cs driver:

Dec  6 16:05:54 charis cardmgr[4036]: socket 0: AmbiCom BT2000E
Bluetooth Card
Dec  6 16:05:56 charis hcid[3455]: HCI dev 0 registered
Dec  6 16:05:56 charis kernel: btuart_interrupt: RLSI
Dec  6 16:05:56 charis kernel: btuart_receive: Unknown HCI packet with
type 0x00 received
Dec  6 16:05:56 charis last message repeated 3 times
Dec  6 16:05:56 charis kernel: btuart_receive: Unknown HCI packet with
type 0x80 received
Dec  6 16:05:56 charis kernel: btuart_receive: Unknown HCI packet with
type 0x00 received
Dec  6 16:05:56 charis last message repeated 2 times
Dec  6 16:05:56 charis cardmgr[4036]: executing: './bluetooth start hci0
2>&1'
Dec  6 16:05:56 charis cardmgr[4036]: + /dev/hci0: No such file or
directory
Dec  6 16:05:56 charis last message repeated 2 times
Dec  6 16:05:56 charis cardmgr[4036]: + Can't open serial port: No such
file or directory
Dec  6 16:05:56 charis cardmgr[4036]: + Can't initialize device: Invalid
argument
Dec  6 16:06:06 charis hcid[4213]: Can't init device hci0. Connection
timed out(110)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
