Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA938704B0A8C6@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
Cc: "Light, John" <john.light@intel.com>
Subject: [Bluez-users] BlueZ build configuratoin
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
Date: Tue, 28 Sep 2004 15:55:40 -0700

Hello,

We are trying to cross-build the latest bluez sources on a PC for our
arm-based prototype.  We have done this successfully for a previous
version of the source, but something has changed since we last tried it.
The problem seems to be that there is one shell variable CONFIGDIR that
controls both where hcid.conf is to be installed during "make install"
and where hcid should look for hcid.conf at run time.  When we
cross-build, the place where hcid.conf is installed needs to be in our
PC build tree, but hcid should still look in /etc/bluetooth on the
target machine (after we have moved bluez across).

We can see how to make both point to /etc/bluetooth, but then the "make
install" fails because /etc/bluetooth is not accessible on the PC (nor
should it be).  I can make both point to $(prefix)/etc/bluetooth, but
then hcid wants to look there at run time.=20

It seems there should be a way to set these independently. Any
suggestions? Are we missing something from the configuration process?

Thanks,
	Trevor




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
