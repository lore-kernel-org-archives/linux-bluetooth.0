Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Using a k700i as HID-Device
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian Rossol <rossol@yola.in-berlin.de>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20041012080501.GB5702@ruessel.local>
References: <20041012080501.GB5702@ruessel.local>
Content-Type: text/plain
Message-Id: <1097569737.4165.4.camel@notepaq>
Mime-Version: 1.0
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
Date: Tue, 12 Oct 2004 10:29:48 +0200

Hi Florian,

> I've some troubles using a Sony Ericsson k700i as a
> HID-Device:
> 
> $ hcitool scan
> Scanning ...
>         00:0F:DE:15:FD:E9       K700i
> $ hidd --server
> $ hidd --connect 00:0F:DE:15:FD:E9
> HID create error 110 (Connection timed out)
> 
> After the last command (hidd --connect ...) a window on the mobile
> phone pops up: "Start remote control?". When I choose yes the remote
> control on the mobile phone starts. But when I use the remote control
> nothing happens on the pc. Also there is no message in
> /var/log/daemon.log for a new HID-Device. But there is
> Bluetooth-traffic at the moment when I use the remote control as I can
> see on the LED on the Bluetooth-Stick. After some time (perhaps a
> miniute) the "hidd --connect ..."-command exits with the error-message
> above.

the K700i has a resource limit, because it can only open two L2CAP
connections at the same time. For the HID support we need to open three
at the same time at the moment. I don't have access to this phone to
workaround that problem.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
