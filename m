Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth on d610
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060125165101.VOSE17690.fed1rmmtao04.cox.net@[172.18.180.8]>
References: <20060125165101.VOSE17690.fed1rmmtao04.cox.net@[172.18.180.8]>
Content-Type: text/plain
Message-Id: <1138209291.5782.89.camel@localhost>
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
Date: Wed, 25 Jan 2006 18:14:51 +0100

Hi Darryl,

> So I've done the following in a further attempt to get bluez corectly installed and working on my system:
> 
> downloaded
>     * bluez-libs-2.25.tar.gz
>     * bluez-utils-2.25.tar.gz
>     * bluez-firmware-1.1.tar.gz
>     * bluez-hcidump-1.29.tar.gz
> 
> untar, configure, make, make install...
> 
> No errors on any part of the process
> 
> Still when I  modprobe usb_hci I get "FATAL: Module usb_hci not found." and a "locate usb_hci" turns up nothing - I'm a bit at a loss here.

the usual name of the module is "hci_usb", but you maybe try "hciusb"
and if this works you should get yourself another distribution ;)

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
