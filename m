Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cleaning up the D-Bus interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0602021311l50c9cfb5o7ceab3e80a131f54@mail.gmail.com>
References: <1135111693.26233.11.camel@localhost>
	 <3013cac80512220511u9ecac97haf7278614bfe085a@mail.gmail.com>
	 <1135271815.6002.96.camel@localhost>
	 <3013cac80512230528y5b879d2bh2dbcb4e0fe18e974@mail.gmail.com>
	 <1135350634.3985.2.camel@localhost> <1135434294.1008.3.camel@localhost>
	 <e1effdeb0601251054m6ac203ceu4901dca319212d2@mail.gmail.com>
	 <1138304710.5901.106.camel@localhost>
	 <e1effdeb0601300944i45664a73v999c155298825117@mail.gmail.com>
	 <1138902761.3750.7.camel@localhost.localdomain>
	 <e1effdeb0602021311l50c9cfb5o7ceab3e80a131f54@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1139308823.7633.0.camel@localhost>
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
Date: Tue, 07 Feb 2006 11:40:23 +0100

Hi Claudio,

> here is the new patch!
> 
> You can use the command below or the dbus-test script to test this feature.
> $dbus-send --system --print-reply --type=method_call --dest=org.bluez
> /org/bluez/Device/hci0 org.bluez.Device.SetMode byte:0
> 
> $dbus-send --system --print-reply --type=method_call --dest=org.bluez
> /org/bluez/Device/hci0 org.bluez.Device.GetMode

the patch has been applied to the CVS now.

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
