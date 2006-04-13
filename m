Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <443E0A32.7060701@sacet.com>
From: Laurent DANIEL <laurent.daniel@sacet.com>
MIME-Version: 1.0
To: Bluez-users@lists.sourceforge.net
Subject: [bluez-users] Broadcast Packets
References: <443E0664.50904@sacet.com> <443E08C5.7010307@sacet.com>
In-Reply-To: <443E08C5.7010307@sacet.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 13 Apr 2006 10:22:10 +0200

Hi,


I have 4 Broadcom USB bluetooth dongles and I want to send broadcast 
packet from the master's device to slave's device.
How could I realise this ? ( I use linux with Bluez 2.25)

At the moment I know that first I must create ACL links with each slave. 
Secondly, I must use the L2CAP level and not HCI level.

Moreover, I saw that I must change in a programm the BC flag. I must put 
it in ACL_ACTIVE_BCAST but how can I do?

Regards


Laurent


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
