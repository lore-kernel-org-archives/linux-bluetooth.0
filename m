Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <c004c40d0710311812u50795ca4wa3a8f3a6b2848ec0@mail.gmail.com>
References: <c004c40d0710311812u50795ca4wa3a8f3a6b2848ec0@mail.gmail.com>
Date: Thu, 01 Nov 2007 06:04:10 +0100
Message-Id: <1193893450.32459.114.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] How to confirm if a device has DFU
	support	(dfutool)?
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

Hi Raul,

> I'm trying to backup the firmware from a Conceptronic CBT100U USB
> Bluetooth dongle using dfutool, and the message I get after selecting
> the device is:
> 
> # dfutool -dhci0 archive file.dfu
> ...
>  "Can't identify device with DFU mode"
> #
> 
> I understand this could mean this chip manufacturer does NOT support DFU,
> although it is a CSR-based device, and mostly all CSR based modules and dongles
> support DFU. How can I confirm if DFU is supported?

that is plain wrong. Most CSR based devices are nowadays ROM chips and
don't support DFU anymore. However check /proc/bus/usb/devices, it will
tell you exactly if it is supported or not.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
