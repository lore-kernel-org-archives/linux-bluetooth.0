Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <472227FC.9000206@mercuryresearch.com>
References: <472227FC.9000206@mercuryresearch.com>
Date: Wed, 31 Oct 2007 17:32:11 +0100
Message-Id: <1193848331.32459.60.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Patch to add support for Apple Aluminum	Bluetooth
	Keyboard
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

Hi Dean,

> Here's a trivial patch to add support for Apple's aluminum
> bluetooth keyboard. The keyboard works out of the the box,
> but this enables the Fn modifier key so that a few useful
> keys (namely pageup/pagedown using Fn+arrows).
> 
> Apologies if I'm not conforming to local patch formatting
> conventions, but the needed change is pretty obvious regardless.

patch looks fine, but can you please re-send it with a proper
Signed-off-by line. Remember that this is a kernel patch and it has to
follow the guidelines of the kernel. Otherwise I simply have to ignore
your credit for this patch.

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
