Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] rfcomm patch
From: Marcel Holtmann <marcel@holtmann.org>
To: Alan Huang <alanh@tuks.co.za>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <004101c3a3b4$81f42dd0$dc01a8c0@alan>
References: <200311050945.34166.sybren@thirdtower.com>
	 <004101c3a3b4$81f42dd0$dc01a8c0@alan>
Content-Type: text/plain
Message-Id: <1068107961.1284.123.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 06 Nov 2003 09:39:21 +0100

Hi Alan,

>   Regarding this topic that rfcomm doesn't flush. I just want to ask that,
> I'm using an USB Bluetooth dongle that's connected to another Bluetooth
> device using the rfcomm program. This other Bluetooth device is connected to
> a Windows PC's COM1 port (RS-232) and connected/displayed by
> hyperterminal... For some unknown reason, what ever the hyperterminal sends
> on the Windows side can be shown
> "cat /dev/rfcomm0". But what ever the USB Bluetooth dongle sends (using
> "echo hello > /dev/rfcomm0") it can't be shown on the Windows
> hyperterminal...

try to use the --raw switch to set the terminal into RAW mode after
connect (this works not for "bind").

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
