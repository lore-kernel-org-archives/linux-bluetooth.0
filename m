Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576041127045238dc2264@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] HCI connection_handle
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
Date: Sat, 27 Nov 2004 18:22:38 +0530

Hi marcel,
1)
I am trying to use the "hcitool cmd" options and i have to pass the
connection_handle as a command parameter.
root:]#hcitool  con
< ACL 00:0B:0D:31:D1:BA handle 7 state 1 lm MASTER

Assuming the connection_handle to be 7, i tried to read the rssi value

root:]#hcitool cmd 0x05 0x0005 0x0007
I get the following

< HCI Command: ogf 0x05, ocf 0x0005, plen 1
  07
> HCI Event: 0x0e plen 4
  01 05 14 12

This means there is some error as i have got 12 instead of 00......

Can you tell me what the problem is??

2) I tried using the test mode commands and I am simulatameously
running the hcidump, which prints a unknown command type. I am just
presuming that the commands might be working alright , only that
hcidump doesn't decipher the test commands. Am i right??

3) I was also trying to understand the hcitool.c code , can you tell
me where the functions  "hci_for_each_device" and the like defined?

Thanks once again,
Regards,
Manjunath


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
