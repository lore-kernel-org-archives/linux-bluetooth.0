Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Success: switching the Logitech-Hub
From: Marcel Holtmann <marcel@holtmann.org>
To: Alexander Holler <holler@ahsoftware.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <9810000.1073197538@[192.168.207.2]>
References: <9810000.1073197538@[192.168.207.2]>
Content-Type: text/plain
Message-Id: <1073267036.3804.4.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 05 Jan 2004 02:43:56 +0100

Hi Alexander,

> lsusb:
> 
> Bus 001 Device 004: ID 046d:c707 Logitech, Inc.
> Bus 001 Device 003: ID 046d:c704 Logitech, Inc.
> Bus 001 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
> Bus 001 Device 001: ID 0000:0000
> 
> Just be sure you have sshd up and running before switching the hub when 
> using the diNovo Keyboard. ;)

I modified the hid2hci program to support switching of the Logitech
Bluetooth wireless hub. Code is in CVS now and it should also support
the Apple devices with HID proxy out of the box.

A little bit weird is that the HID device 046d:c704 is still present
after switching.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
