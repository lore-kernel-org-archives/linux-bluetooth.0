Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Chris Davies <c.davies@cdavies.org>
To: bluez-users@lists.sourceforge.net
Message-ID: <20031206161033.GB6573@vaughan.foofalicious.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] DBT-120 "Connection time out" troubles
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
Date: Sat, 6 Dec 2003 16:10:33 +0000

Hi,

I just brought a D-Link DBT-120 (CSR version) usb bluetooth dongle, and I'm having some trouble getting it to work reliably.

At present, I'm using a vanilla 2.4.22 kernel.

After loading the various required modules, everything appears to be going fine. I can use hcitool scan to look at my bluetooth menagerie, and sdptool browse to examine services. Even l2ping works.

Then I establish an rfcomm connection to my phone. I have previously paired the devices, and they communicate with each other OK for a while, e.g. I can talk to the phone on the tty, and even use bluexmms. But sooner or later the whole bluetooth system dies for some reason or another. 

Tools like hciconfig start reporting "Connection timed out(110)" and nothing short rebooting the machine can get the bluetooth dongle talking to bluez again.

I realise that this problem has been discussed somewhat in the archives of this list, but as far as I can see no one has presented a solution.

Can anyone help me get his working reliably?

Thanks,
C.Davies


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
