Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <c004c40d0712050146v41168091v3d5191b3b276f40b@mail.gmail.com>
Date: Wed, 5 Dec 2007 10:46:23 +0100
From: "Raul Siles" <raul.siles@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <c004c40d0711020918x6753c75bheaa76d84b469d93@mail.gmail.com>
MIME-Version: 1.0
References: <c004c40d0710311812u50795ca4wa3a8f3a6b2848ec0@mail.gmail.com>
	<1193893450.32459.114.camel@violet>
	<c004c40d0711020918x6753c75bheaa76d84b469d93@mail.gmail.com>
Subject: Re: [Bluez-devel] How to confirm if a device has DFU support
	(dfutool)?
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

Hi everyone,
The previous issue I reported back about "dfutool" not capable of
backing up the firmware for a USB Bluetooth dongle (see below) is
solved.

It seems "dfutool" doesn't like VMware (v5.5.X). The native VMware USB
port emulation (or USB pass through) interferes with the raw USB
access required by dfutool. From a native OS (without any
virtualization SW) everything works as expected.

Cheers,
--
Raul Siles
GSE
www.raulsiles.com

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

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
