Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1073041104.25261.15.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Bluetooth kernel patch for 2.6.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 02 Jan 2004 11:58:24 +0100

Hi Folks,

the second Bluetooth kernel patch for 2.6.0 is now available [1] and it
fixes some more HCI USB driver problems. But the important thing is that
it contains a kernel driver for loading the firmware into the Broadcom
Blutonium devices. Everyone who had problems with bluefw should give it
a try. Here is the changelog:

  o Convert interrupt handlers to use irqreturn_t
  o Support for Broadcom Blutonium
  o Improve blacklist handling

Regards

Marcel

[1] http://www.holtmann.org/linux/kernel/patch-2.6.0-mh2.gz




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
