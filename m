Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] SCO syncronization taking down USB dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <bd72c4b0602141948w3bacbf30q49f933551f56b40a@mail.gmail.com>
References: <bd72c4b0602141948w3bacbf30q49f933551f56b40a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139992509.26072.16.camel@localhost>
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
Date: Wed, 15 Feb 2006 09:35:09 +0100

Hi Gareth,

> Hello. I am currently writing code for voice connections using a
> Motorla HS850 headset and the BlueZ stack on a Intrinsyc Cerf 255PXA
> board (a small form mobile PC). I can currently make successful SCO
> connections to the headset, but they sometimes crash, and take the
> whole USB dongle with it. (Running 'hciconfig hci0 up' fixes it).
> 
> Here is the crash printout:
> usb.c: USB disconnect on device 2
> Receive failed: Broken pipe
> hub.c: USB new device connect on bus1/2, assigned device number 3

the dongle gets disconnected from the USB bus. What kind of dongle is
this? Maybe you need to get yourself a better one, because a disconnect
from the USB is nothing we can really work around.

> I notice that flow (and error) control appear on the Todo list, but is
> there some way to guard against the whole dongle being taken down?

It only protects the host stack and not the dongle. The flow control
towards the HCI of the dongle is always used.

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
