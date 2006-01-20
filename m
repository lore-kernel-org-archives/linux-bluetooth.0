Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Apple mouse gives me various "Can't get
	device information" troubles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1137635164.7455.63.camel@localhost.localdomain>
References: <1137635164.7455.63.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1137719835.17336.141.camel@localhost>
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
Date: Fri, 20 Jan 2006 02:17:15 +0100

Hi Sunnan,

> The only modification to hcid.conf I can remember doing was to set the
> pin_helper to a shell script that just echoes PIN:1234 (I don't remember
> what the pin is supposed to be; I got the number from /etc/bluetooth/pin
> but isn't this resettable somehow?) regardless of it's arguments,
> because regular bluepin crashes with the familiar(? at least that's what
> I gather from various mailing lists) xserver permission problem.

the PIN of the Apple mouse is "0000", but you might have changed it.
Check its manual for a reset switch.

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
