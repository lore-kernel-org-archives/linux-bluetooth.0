Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] conceptronic CBT100U with scala-500 headset
	pairing problem!
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060205071057.GA11171@163.com>
References: <1139079892.13219.11.camel@localhost>
	 <20060205071057.GA11171@163.com>
Content-Type: text/plain
Message-Id: <1139310335.15160.1.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 07 Feb 2006 12:05:35 +0100

Hi,

> > Requesting information ...
> > Can't create connection: Input/output error
> You must enable authenticate in /etc/bluetooth/hcid.conf, restart hcid
> whereafter. The default PIN code of your headset could be 0000, which
> you must put into /etc/bluetooth/pin, or enter manually. The
> communication between your computer and headset is encrypted enforced
> by the headset.

don't give the advice to set a device into security mode 3. This is
never the solution to a problem. Run "hcidump -X -V" to analyze the real
problem.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
