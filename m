Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de46576041207065023f30da@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net, pws@csr.com, steven.singer@csr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [Bluez-users] Remote Loopback
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
Date: Tue, 7 Dec 2004 20:20:45 +0530

Hi,
(Please ignore if received once under subject Test Mode)
I was able to conduct the local loopback test on DBT-120(so
CSR).........so i can
state that anycom usb-120 does not support the HCI_Write_Loopback_Mode
command.
I tried the remote loopback test as per Peter's instructions and the
spec ....but it doesn't seem to work.

I first have set my remote device(B) for Remote_loopback (Becoz
estabhlising a connection and then setting for remote loopback doesn't work).

I then use the Write command and verify that it is set using the Read
command. I now establish a HCI connection from my local device(A) to
B. The connection is established. From A, i send a command packet to
B, expecting a loopback event, instead i get a regular reply for the
command packet (as though the  remote device is not set for loopback).
What packets should i send for testing the remote loopback??

"hcitool con" on A  shows the connection.
< ACL 00:11:35:00:22:B9 handle 41 state 1 lm MASTER

"hcitool con" on B doesn't show anything.

I also tried the switch role for B to be the master....but it remains
as the slave.

Hope you can help me out. Anything I have missed out??

Thanks,
regards,
manjunath


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
