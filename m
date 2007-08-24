Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
References: <2EB6297382462046A9427D7324788A480217D35A@MCLNEXVS06.resource.ds.bah.com>
Date: Fri, 24 Aug 2007 14:14:52 +0200
Message-Id: <1187957692.15402.149.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Multiple Bluetooth Dongles
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Richard,

> I have a system that uses multiple Bluetooth dongles and works just
> fine. I've had my system running with several USB hubs and up to the
> 16 maximum devices that Bluez supports. Now I have a changing
> requirement from my customer to handle more than 16 Bluetooth devices.
> They want support for up to 30 Bluetooth devices.
>  
> I changed the HCI_MAX_DEV in bluez_libs/include/hci.h from 16 to
> 30, recompiled and installed bluez_libs and bluez_utils. No problem.
>  
> My program works fine with up to 16 Bluetooth devices, but the 17th
> device is not recognized and sometimes the entire USB will no longer
> work.

we might broke something here since I haven't tested this in quite a
while. Mainly because I don't care so much anymore. Having these kind of
test setups are nasty.

The USB part can be an issue if you use the SCO support of the hci_usb
driver. Load the driver with isoc=0 to disable it. The ISOC frames for
the SCO support consume to much USB bandwidth.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
