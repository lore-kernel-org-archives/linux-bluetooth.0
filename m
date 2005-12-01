Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [DBUS Patch] Device Property
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
References: <3013cac80511040603k52c40da2gae5249abcba426d9@mail.gmail.com>
	 <1132805822.5982.15.camel@blade>
	 <3013cac80511241050o2f3d67aele639b2c69de41360@mail.gmail.com>
	 <1132872886.3170.3.camel@blade>
	 <e1effdeb0511250547o16e60b21y5c3a81a5639102cc@mail.gmail.com>
	 <1132942092.5577.21.camel@blade>
	 <3013cac80511251034s23d549cbs8a951d64562627b1@mail.gmail.com>
	 <1132944074.5577.28.camel@blade>
	 <e1effdeb0511251152k3bafca4n21125fd1c9f9179@mail.gmail.com>
	 <1132949177.10237.5.camel@blade>
	 <3013cac80512010855v46eeb99dk3a53094238800621@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1133471112.18554.8.camel@blade>
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
Date: Thu, 01 Dec 2005 22:05:12 +0100

Hi Eduardo,

> Johan said on an early email that would be nice to have each changed
> property to send a "PropertyChanged" signal with "Property name" and
> "property specific info" params. But for "discoverable" and
> "connectable" properties, how can we know what changed as both of them
> trigger a command_complete event with HCI_write_scan_enable OCF?  Or
> should we trigger a unique signal for pscan and iscan, sending the new
> scan status?

you need to track the HCI write scan enable command. You issue it with
specific values and you need to keep this transition state until you
receive the HCI command complete event. This is how the kernel is doing
it for some of the commands.

And I like the idea of a PropertyChanged signal.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
