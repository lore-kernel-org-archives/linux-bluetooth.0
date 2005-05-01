Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4275103E.3040208@citromail.hu>
From: =?ISO-8859-2?Q?Szil=E1gyi_Szilveszter?= <sszilveszter@citromail.hu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Can't connect RFCOMM socket: Resource temporarily unavailable
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
Date: Sun, 01 May 2005 19:22:06 +0200

Hi all,
i cannot connect my SonyEricsson T68 on bluetooth (i tried with a Z600 
as well, same problem)
on google there is no solution
root:~# rfcomm connect 0 00:09:D9:26:70:46 2
(((on my phone accept and enter the pin:1111)))
Can't connect RFCOMM socket: Resource temporarily unavailable
root:~# (((I tried it as rfcomm connect 0 00:09:D9:26:70:46 1 as well)))
any ideas?

more info:
the process
http://sszilveszter.uw.hu/blue/theprocess.log
logs and settings in /etc
http://sszilveszter.uw.hu/blue/1
http://sszilveszter.uw.hu/blue/2
http://sszilveszter.uw.hu/blue/hcid.conf
http://sszilveszter.uw.hu/blue/hcidump-x
http://sszilveszter.uw.hu/blue/hcidump-X.1
http://sszilveszter.uw.hu/blue/pin
http://sszilveszter.uw.hu/blue/rfcomm.conf
http://sszilveszter.uw.hu/blue/sdptool


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
