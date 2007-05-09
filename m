Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <464192EC.6090604@a1.net>
Date: Wed, 09 May 2007 11:22:52 +0200
From: Patrick Steiner <patrick.steiner@a1.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <463EEAA8.3080706@a1.net> <46417C35.8010906@a1.net>
In-Reply-To: <46417C35.8010906@a1.net>
Subject: Re: [Bluez-users] Bluetooth only works after restart from Windows
 (dell wireless 350 problem)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

hi,

after hours of work i finally get the bluetooth working with linux!

the problem is a defect? firmware with the preinstalled windows vista 
notebook.

i have now updated to another firmware after that bluetooth work without 
any problems. :-)

an here is a step by step howto. use this on you own risk.

- download the latest bluetooth drivers for windows XP for the d420 
currently this is R117967.exe
- extract it anywhere is used c:\dell\drivers\R117967
- run dfu.exe (from c:\dell\drivers\R117967\2kxp\dfu\ this takes some 
minutes.
- after that blutooth should work in linux but it dont work anymore in 
vista ;-)
- this can be fixed by installing the windows xp drivers 
(c:\dell\drivers\R117967\2kxp\setup.exe).
- after that you have to install the new version of the toshiba 
bluetooth stack (dell uses this one)
  from http://aps.toshiba-tro.de/bluetooth/pages/download.php

the only problem i found out is that the new software is only a 30 day 
test version.
but perhaps dell could be so nice and fix this problem. ;-)


another way could be to get the working firmware and upload it via the 
dfutool (bluez-utlils). but i don't have tested this yet.

hope this helps other users.

regards,
 patrick

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
