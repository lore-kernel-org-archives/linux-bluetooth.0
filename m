Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Mark Murphy <mjmrphy1@uiuc.edu>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <5456d52c.be23bf0c.81cb300@expms5.cites.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Bluetooth 2.6.12-2.6.13 Patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 25 May 2006 16:36:56 -0500


Hello,

I believe that I am encountering the race condition caused by
the session reference counting fix mentioned in
ChangeLog-2.6.13 . Does there exist a Bluetooth-specific diff
or patch for the changes made between 2.6.12 and 2.6.13 ?


-- Mark


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
