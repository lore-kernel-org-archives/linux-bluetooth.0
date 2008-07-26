Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU117-W424BD43283F81BA6D5CF67DF810@phx.gbl>
From: thanit sara <sara200t@uregina.ca>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 26 Jul 2008 16:35:02 -0500
In-Reply-To: <4885E395.8090109@wurmsdobler.org>
References: <4885B849.7040201@wurmsdobler.org>
	<1216730752.31819.28.camel@californication>
	<4885E395.8090109@wurmsdobler.org>
MIME-Version: 1.0
Subject: [Bluez-users] compile error: bluetooth/bluetooth.h: No such file or
	directory
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





 From: ta_peng_mootoo@hotmail.com
To: bluez-users@lists.sourceforge.net
Subject: compile error: bluetooth/bluetooth.h: No such file or directory
Date: Sat, 26 Jul 2008 16:30:48 -0500
 

Dear all,
  
         I am very new to linux and BlueZ. I started by reading the introduction doc and text book created by Alebert S. Huang. However, I stuck in the step of compilling of his very first c-programming example. The file name is "simplescan.c" and my command is " (on the file directory) $ gcc -g -o simplescan simplescan.c -lblutooth "
As result, below is what I got.
 
simplescan.c:5:33: error: bluetooth/bluetooth.h: No such file or directory
simplescan.c:6:27: error: bluetooth/hci.h: No such file or directory
simplescan.c:7:31: error: bluetooth/hci_lib.h: No such file or directory

Note, I am using fedora 9, 86x64 version. And I think I have all the Bluez package with all header files installed with gcc complier. 
The weird thing is the Bluetooth header files (ie. bluetooth.h, hci.h ,....) are located in "/usr/src/kernels/2.6.25.10-86.fc9.x86_64/include/net ", instead of "/usr/include" where I thought they would be.

I have been searching on google for days now and no answer to myself yet. Anyone have a valuable suggestion please kindly let me know. Or if anyone know the exact proper way how to compile c-code file for BlueZ on linux pls kindly let me know

Your kindness is greatly appreciated.
 
 Thanit


_________________________________________________________________
Find hidden words, unscramble celebrity names, or try the ultimate crossword puzzle with Live Search Games. Play now!
http://g.msn.ca/ca55/212
-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
