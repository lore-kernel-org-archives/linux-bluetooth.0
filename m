Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: David Wuertele <dave-gnus@bfnet.com>
Message-ID: <m3oenr9t1k.fsf@bfnet.com>
References: <m365a0b8f9.fsf@bfnet.com> <20040610101649.GA7496@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Thinkpad X31 @ fedora core 2, trying to connect to Nokia 6380i
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
Date: Thu, 10 Jun 2004 11:17:27 -0700

Nicholas> Seems that your PIN exchange doesn't work. What is your
Nicholas> "security" setting in hcid.conf?

 security auto;

Nicholas> Does appear a pin windows on the mobile display?

No, there was no change on my 6310i display.
But on my laptop display I got a dialog asking for the PIN.
Where do I get this mysterious PIN?
I tried making one up.  Then it worked!

Is this PIN stored somewhere?  I see a file

  /etc/bluetooth/pin

but it doesn't contain the PIN that I typed into the laptop dialog and
the phone dialog.

Dave



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
