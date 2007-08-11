Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <5307d89f0708051338w35288418x915abd247233c324@mail.gmail.com>
References: <5307d89f0708051338w35288418x915abd247233c324@mail.gmail.com>
Date: Sat, 11 Aug 2007 20:25:13 +0200
Message-Id: <1186856713.6698.44.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Info Dinovo LCD driver
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Patrick,

> I patched bluez-utils succesfully for the Dinovo MEDIA Pad LCD driver.
> The example program supplied with it works!

I don't see any patch or example program.

> But it won't work automaticaly at startup.
> This is the example of /etc/default/bluetooth:
> 
> HIDD_ENABLED=1
> HIDD_OPTIONS="-i 00:07:61:45:5F:0D --connect 00:07:61:3E:15:1A --server"
>                                   [_ this is my dongle
> [_this is the Media Pad
> 
> So, when I startup my computer, I have to press one the keyboard Pad
> buttons to activate the Media Pad,
> then it's connected , the keyboard buttons works but the lcd won't work.
> To get he lcd to work I have to do manually:
> sudo hidd -i 00:07:61:45:5F:0D --connect 00:07:61:3E:15:1A, then the
> lcd gets also activated.
> I don't have to use the "--connect" option in /etc/default/bleutooth
> for my keyoard and mouse! They work automatically.

We don't focus on hidd anymore and everybody that keeps using these
crappy --connect stuff in the init script and complains that something
is not working should ask himself if you are actually understand how HID
within Bluetooth is working. All HID will re-connect to the host. That
is a fact and it works this way. No excuses. Everything else is a bug
and all workarounds are wrong. Period.

Anyway. We are pushing the Bluetooth input service and this one should
be used and issues should be fixed there. Actually the latest
bluez-gnome from CVS can even connect HID via bluetooth-properties.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
