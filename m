Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309220408.04569.justin-qt@affinix.com>
From: Justin Karneges <justin-qt@affinix.com>
Subject: [Bluez-devel] dtl1_cs suspend bug
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Sep 2003 04:08:04 -0700

Hi,

I've started to try solving this one, but it is not easy for me since I know 
nothing about CardServices and what it does before/after issuing CS_EVENT_* 
events.

I compared the dtl1_cs code to that of the orinoco_cs (wifi) driver, and I 
guess the handling is about the same.  What could be wrong in dtl1_cs ?

The fact that 'cardctl suspend' breaks the driver and 'cardctl eject ; cardctl 
insert' fixes it, I'm certain this can be solved in software.  Surely there 
is a way that the driver can fully reset itself without it having to be done 
externally by cardmgr.  I know that suspend/resume actions are supposed to be 
optimized versions of eject/insert, but since the current suspend/resume 
functions _don't_ work, we may as well do a full and slow reset instead.  No 
sense in leaving it broken.  Once someone comes along who understands how 
suspend/resume works, the driver can be optimized.

Unfortunately, this isn't as easy as it appears on the surface.  I tried a 
simple and dirty hack of making suspend perform the eject code and resume to 
perform the insert code (a cut and paste of just a few lines), but was 
unsuccessful.

Clues please!

-Justin


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
