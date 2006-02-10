Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: bluez and dbus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43EC3341.6010100@gmail.com>
References: <43EC3341.6010100@gmail.com>
Content-Type: text/plain
Message-Id: <1139555572.22066.4.camel@localhost>
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
Date: Fri, 10 Feb 2006 08:12:52 +0100

Hi Doug,

> >since you are creating the connection the value in /etc/bluetooth/pin is
> >never used. It is for incoming connection that request an authentication
> >and if security is set to auto.
> 
> The way this is working right now, I need a second keyboard attached. When I reboot
> I can not get a connection with the bt keyboard without doing a hidd --search? 
> 
> you stated in your previous reply to run hidd --server
> it is started from my rc.local, so should I not have a connection once I get to my login
> prompt?

it should be started from /etc/init.d/bluetooth depending on your Linux
distribution. You get a connection once you press a key on your
keyboard.

> If thing's were setup to require a key, and this key was stored on the chip, would this
> not allow me to have a connection bt_kb<---->dongle as soon as there is power at the dongle
> on a reboot, so perhap's I could have a keyboard available at my grub prompt? Or am I right
> out to lunch on this one. :)

To have a keyboard at BIOS time you need a HID proxy dongle. Check the
various mailing list archives for details on it.

> Here's probably a more retarded question. If it was working like I mention above, would my
> bios know there was a keyboard connected to the dongle, so it didn't spit "no keyboard found"
> at me. My desk has one to many keyboard's on it, 

The HID proxy dongle will also take care of this.

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
