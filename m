Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jikos@jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0710261526020.18815@twin.jikos.cz>
References: <1193350427.11632.8.camel@simo-desktop>
	<Pine.LNX.4.64.0710261526020.18815@twin.jikos.cz>
Date: Wed, 31 Oct 2007 17:33:06 +0100
Message-Id: <1193848386.32459.62.camel@violet>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net,
        Simone Malacarne <s.malacarne@gmail.com>
Subject: Re: [Bluez-devel] [linux-usb-devel] dmesg warning on hid core
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

Hi Jiri,

> the problem is that some userspace utility (I guess hid2hci from 
> bluez-utils) issues hiddev ioctl() with inappropriate out-of-bounds value.
> 
> As far as I know Logitech bluetooth keyboards are problematic, as Marcel 
> doesn't have any specification for them, so switching between HID and HCI 
> modes is reverse engineering and guessing.

there exists a patch that might make this work again. Didn't have the
time to properly test it, but it can't make it worse.

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
