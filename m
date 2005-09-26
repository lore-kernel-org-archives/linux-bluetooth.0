Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43384BEF.3070808@scananza.net>
From: Lorenzo Scano <scananza@scananza.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] bluez and Motorola V535
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
Date: Mon, 26 Sep 2005 21:28:47 +0200

Hi all,
I'm wondering if anyone knows if this phone could work on Linux/bluez 
just to transfer files.
I have a 2.6.12 vanilla kernel on a debian testing machine, tried to 
connect, got the adapter correctly found by the phone but then it hangs:

solid-snake:/etc/bluetooth# obexftp -b -l
Scanning ...
Using   00:14:9A:20:A3:62       Scananzofono
Browsing 00:14:9A:20:A3:62 ...
Channel: 9
No custom transport
Connecting...bt: 1
done
Receiving (null)... failed: (null)
Disconnecting...failed: disconnect

I'm really a newbie on bluetooth stuff so I will appreciate any help or 
clue about a possible support for my phone.

Thank you a lot, later

-- 
Lorenzo Scano
scananza@scananza.net
http://www.scananza.net
Debian Etch amd64


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
