Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SuSE 10.0 BlueZ and wvdial
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43F0EF07.20208@ibdcon.org.br>
References: <d6db2b820602131319u1658f2fn40823df3c623c500@mail.gmail.com>
	 <43F0EF07.20208@ibdcon.org.br>
Content-Type: text/plain
Message-Id: <1139903616.21873.5.camel@localhost>
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
Date: Tue, 14 Feb 2006 08:53:36 +0100

Hi Paulo,

> i did install SuSE 10.0, BlueZ and paired my gprs phone. Ok, it worked.
> But when i try to use wvdial to connect to the internet using the GPRS
> service, through rfcomm0 port,  i get the following message:
> --> WvDial: Internet dialer version 1.54.0
> --> Cannot open /dev/rfcomm0: Cannot get information for serial port.
> --> Cannot open /dev/rfcomm0: Input/output error
> --> Cannot open /dev/rfcomm0: Cannot get information for serial port.
> Does anyone knows what could be happening?

I've seen this before and this is specific to the wvdial package with
SuSE. Actually to make them happy we need to implement some specific TTY
ioctl() which I haven't really got around.

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
