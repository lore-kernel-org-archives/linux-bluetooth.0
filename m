Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070819T201223-639@post.gmane.org>
References: <loom.20070819T201223-639@post.gmane.org>
Date: Sun, 19 Aug 2007 21:19:01 +0200
Message-Id: <1187551141.11068.55.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] stale connections with input
	service	(bluez-libs-3.14)
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

Hi Dick,

> I'm using the latest bluez utils and bluez libs but the input service is still
> unstable. When I'm not using my dinovo desktop (keyboard/pointing) they
> disconnect but the input service doesn't seem to handle it well.
> 
> $ hcitool con
> keep telling me:
> 
> Connections:
>         ACL 00:07:61:69:XX:XX handle 51 state 1 lm MASTER 
>         ACL 00:07:61:68:XX:XX handle 48 state 1 lm MASTER AUTH ENCRYPT 

which kernel version is this. This is not suppose to happen. Have you
tried a 2.6.23-rc3 kernel?

> When I reset the hci:
> 
> # hciconfig hci0 reset
> The mouse reconnects but the keyboard is still not working, I can only get it
> back online by either pressing the connect button or dis-/connect the batteries.
> 
> In the stale situation I see still data coming from the devices (with hcidump);
> that's kinda weird. (Why isn't it handled by the input service?)

Does the mouse always works? Maybe this is an issue with the
authentication and encryption that are mandatory for keyboard. Which
keyboard are you using? Which Bluetooth chip is inside it.

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
