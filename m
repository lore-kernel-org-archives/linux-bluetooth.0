Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200407210941.07765.pavouk@pavouk.org>
Subject: [Bluez-users] Suspend BT Socket card on Zaurus
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
Date: Wed, 21 Jul 2004 09:41:07 +0200

Hello,

I have old Socket BT CF card (Nokia based) on Sharp Zaurus SL-C860.
This card use module dtl1_cs on 2.4.18-rmk7-pxa3-embedix kernel.
On every suspend/resume Zaurus makes cardctl eject/insert
action, which takes many of time. I was tried to remove these actions
from apm.d scripts and leave only cardctl suspend/resume.
But after this modification card doesn't work ;-)

It's possible to do something for working card without cardctl eject/insert
commands?

It's a problem of controller, card or kernel module?

Best regards,

Pavel Ruzicka


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
