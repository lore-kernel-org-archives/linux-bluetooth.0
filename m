Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Cleaning up the D-Bus interface
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb0601251054m6ac203ceu4901dca319212d2@mail.gmail.com>
References: <1135111693.26233.11.camel@localhost>
	 <3013cac80512211216r3918594dv676e03480d83f5b3@mail.gmail.com>
	 <1135196479.3781.10.camel@localhost>
	 <3013cac80512220511u9ecac97haf7278614bfe085a@mail.gmail.com>
	 <1135271815.6002.96.camel@localhost>
	 <3013cac80512230528y5b879d2bh2dbcb4e0fe18e974@mail.gmail.com>
	 <1135350634.3985.2.camel@localhost> <1135434294.1008.3.camel@localhost>
	 <e1effdeb0601251054m6ac203ceu4901dca319212d2@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1138304710.5901.106.camel@localhost>
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
Date: Thu, 26 Jan 2006 20:45:10 +0100

Hi Claudio,

> This patch is based on your discussion, but there are some changes:
> 1. The scan enable values are based on the Bluetooth Spec in order to
> make the logic more clear:
> mode 0x00       = Off (means down or deep-sleep)
> mode 0x01       = Discoverable (NOT ALLOWED)
> mode 0x02       = Connectable
> mode 0x03       = Connectable and Discoverable

actually I didn't used the values from the specification on purpose. On
future idea is that we support discoverable for them time and the client
doesn't have to take care when to switch inquiry scan off again. As I
sometimes mentioned, it might be good to not follow the specification
for the D-Bus API. The hcid/bluetoothd will hide all implementation
details.

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
