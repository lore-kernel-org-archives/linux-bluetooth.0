Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Link quality measurement
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1140563120.11852.7.camel@localhost.localdomain>
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>
	 <200512021834.19314.mgorbach@yahoo.com>
	 <1140563120.11852.7.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1140564484.22767.27.camel@localhost>
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
Date: Wed, 22 Feb 2006 00:28:04 +0100

Hi Agustin,

> I'm using 'hcitool lq bdaddr' to obtain the link quality of an rfcomm
> connection. I wanted to know how this 'quality' is measured, i.e., what
> does the number (raging from 0 to 255) mean?
> Does anybody has any idea about this? What would be the typical or
> optimal link quality measurement?

in case of a CSR chip it is well defined. In case of other chips I have
no idea, because the link quality is manufacturer specific. Look at my
CSR page at www.holtmann.org/linux/bluetooth/csr.html for more details.

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
