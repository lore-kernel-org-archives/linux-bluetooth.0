Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050331163323.btemcytgys0c0kkg@webmail.tugraz.at>
From: Hans Juergen Gamauf <gamauf@sbox.tugraz.at>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Subject: [Bluez-users] Configuring HCId for logging everything
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
Date: Thu, 31 Mar 2005 16:33:23 +0200

Hello!

How can I configuring hcid, so that it would log everything (i.e. 
logging every attempt of another bluetooth-device establishing a 
connection)?

I've changed my Bluetooth-Class to class 0x200404; so that my Nokia 
6230 would try to connect to the PC (Fedora Core 3), because it only 
can connect to a headset.

This connection cannot - of course - be established because there is no 
service behind, I just want to see that there is an attempt, but 
nothing is written into /var/log/messages (only things like HCI dev 0 
or shutting down), or is there another log file? (neither dmesg is 
printing something useful)


Thank you in advance!

Sincerely
Hans Juergen Gamauf

-- 





-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
