Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: bluez and dbus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43EBF81F.5000600@gmail.com>
References: <43EBF81F.5000600@gmail.com>
Content-Type: text/plain
Message-Id: <1139538729.16938.3.camel@localhost>
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
Date: Fri, 10 Feb 2006 03:32:09 +0100

Hi Doug,
 
> the same thing happen's whether I have anything in /etc/bluetooth/pin or 
> not.

since you are creating the connection the value in /etc/bluetooth/pin is
never used. It is for incoming connection that request an authentication
and if security is set to auto.

And btw. I just removed the support for /etc/bluetooth/pin for the next
bluez-utils release.

> this successful connection you see above, is after having to remove the 
> battery, and hitting the connect button before it could be found.

As I said, you connect to a HID device only once. After that you let the
HID connect back to you. This is a normal behavior.

If you really want an encrypted connection with your keyboard then run
hidd with --encrypt as parameter. However the initial setup of the
pairing can be quite tricky. You have to enter the PIN with the numeric
keys on your keyboard.

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
