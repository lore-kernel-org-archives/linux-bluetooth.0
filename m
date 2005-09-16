Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <6.2.3.4.0.20050916111745.02ae0008@mail.impulsesoft.com>
To: bluez-users@lists.sourceforge.net
From: Pragya Gupta <pragya@impulsesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [Bluez-users] Failed to send data over a writable l2cap socket
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
Date: Fri, 16 Sep 2005 11:36:41 +0530


Hi,

I am trying to establish more than one l2cap channel over same hci 
link between a pair of devices. I am using "select" to find out when 
a socket becomes writable. When I say "connect" for first two l2cap 
sockets , I come out of select when it becomes writable and I am able 
to send data to it. But when I repeat the same for the third l2cap 
socket, the socket is writable but I am unable to send data on it . 
The data goes out successfully only after few attempts.

Any suggestions ? Am I doing something wrong ?

Thanks and Regds
Pragya




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
