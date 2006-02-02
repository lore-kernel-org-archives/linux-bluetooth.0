Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cleaning up the D-Bus interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0601300944i45664a73v999c155298825117@mail.gmail.com>
References: <1135111693.26233.11.camel@localhost>
	 <3013cac80512211216r3918594dv676e03480d83f5b3@mail.gmail.com>
	 <1135196479.3781.10.camel@localhost>
	 <3013cac80512220511u9ecac97haf7278614bfe085a@mail.gmail.com>
	 <1135271815.6002.96.camel@localhost>
	 <3013cac80512230528y5b879d2bh2dbcb4e0fe18e974@mail.gmail.com>
	 <1135350634.3985.2.camel@localhost> <1135434294.1008.3.camel@localhost>
	 <e1effdeb0601251054m6ac203ceu4901dca319212d2@mail.gmail.com>
	 <1138304710.5901.106.camel@localhost>
	 <e1effdeb0601300944i45664a73v999c155298825117@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1138902761.3750.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 02 Feb 2006 18:52:41 +0100

Hi Claudio,

> Here is the patch following your suggestion.

cool, but the patch has some issues.

Don't refer to the Bluetooth specification for the mode values, because
we define our own.

Please name the modes like following:

#define MODE_OFF           0x00
#define MODE_CONNECTABLE   0x01
#define MODE_DISCOVERABLE  0x02

The discoverable mode of course includes connectable mode.

In the handle_device_get_mode_req(), the switch statement always sets
the mode to 0xff. Please add the breaks and if you write a fall through
statement, then comment it.

> Now, we introduced a problem. How handle scenarios where other
> application/or hciconfig changes the scan mode, enabling the Inquiry
> Scan only? :) In the current patch, I am ignoring the HCI command
> complete event for this case.

We need to track the scan mode command complete event and if the mode
changes, we need to send out a mode change signal.

> When we close this discussion I can start play with the discoverable time stuff.

That would be really great, because this feature could come in handy for
any graphical application.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
