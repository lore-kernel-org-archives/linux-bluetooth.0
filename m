Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft BT Dongle and other questions
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1106236749.21181.17.camel@localhost.localdomain>
References: <1106236749.21181.17.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1106245278.13562.8.camel@pegasus>
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
Date: Thu, 20 Jan 2005 19:21:18 +0100

Hi Bryan,

>     I've been monitoring this list for about a week or two (since I got
> an internal bluetooth module installed in my iBook) and have had a few
> of my questions answered already (like why the scrollwheel on my
> Microsoft IntelliMouse Explorer for Bluetooth doesn't work), but I still
> have a few questions.
>     First of all (this isn't really a question), since I have an
> internal bluetooth module, I have a Microsoft bluetooth dongle that is
> of no use to me, so I would be able to send it to you, Marcel.  Let me
> know how to get it to you and I'll send it.

If this is the new 2.0 version then I am interested. Otherwise it is
useless, because I already have two of the older ones. What does lsusb
tell me about your dongle?

>     1. Is there a way to turn off the internal bluetooth adapter from
> apple?  I know it sounds stupid, but there is a good reason: When I'm on
> battery power, I've noticed that my battery has been draining faster
> since I got the adapter.  I don't use bluetooth all the time, so when
> I'm not using it I'd like to get the most out of my battery.

Maybe should do a "hciconfig hci0 noscan" to disable inquiry and page
scan. This should save battery power. If you don't need this dongle at
all you can load the hci_usb driver with "ignore=1" (maybe a newer
kernel is needed).

The PC notebooks have a hardware switch to physical disconnect the
device from the USB bus. I don't know if a similar thing exists on the
Apple machines.

>     2. Have the developers taken into account sleeping/resuming?  I've
> noticed that when I sleep my laptop, I have to shut down the bluetooth
> services before-hand in order to get the adapter to work after resume.
> Shouldn't this be handled internally?

I didn't had time to look at the suspend/resume support. On some
machines it work and on some it don't.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
