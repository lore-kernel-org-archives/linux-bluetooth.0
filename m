Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Achim Bohnet <ach@mpe.mpg.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404292230.08106.ach@mpe.mpg.de>
Subject: [Bluez-users] ciptool setuid
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Apr 2004 22:30:07 +0200

Hi,

In debian members of group dip and dialout and use modem/isdn devices.
Unfortunately it looks like that one need to be root to run ciptool
and make the isdn controler via bluetooth available.

Question: Are there other methods to enable members of group dialout
to use ciptool that making it setuid root?  If not is it safe to
install ciptool by default like

=2Drwsr-x---    1 root     dialout      8368 2004-01-26 23:22 /usr/bin/cipt=
ool

So all group member of dialout can run it.  All capi devices are
accessible by dialout members:

# l /dev/capi*
crw-rw----    1 root     dialout   68,   0 2004-03-22 14:00 /dev/capi20
crw-rw----    1 root     dialout   68,   1 2004-03-22 14:00 /dev/capi20.00
crw-rw----    1 root     dialout   68,   2 2004-03-22 14:00 /dev/capi20.01

=46rom a look at the usage/source it seem that ciptool really only allows
to 'create'/'release' a capi controlers.

Achim
=2D-=20
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
