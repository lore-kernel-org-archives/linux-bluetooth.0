Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Accessing HCI on Windows
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Mischke <survivor@uni-paderborn.de>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <405FFCB9.5050507@uni-paderborn.de>
References: <405FFCB9.5050507@uni-paderborn.de>
Content-Type: text/plain
Message-Id: <1080040266.2663.317.camel@pegasus>
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
Date: Tue, 23 Mar 2004 12:11:06 +0100

Hi Stefan,

> I'm writing a little "Location Awareness using Bluetooth"-thing for my 
> Bachelor of CS degree. On Linux, everything is fine and I just have to 
> look into the  BlueZ code. But it would be nice if there was a 
> possibility to port my work to Windows. Unfortunately I have found no 
> documentation about how to access the HCI on Windows. All I need would 
> be a simple "SendHCICommand()" or something. My Question: Does anyone 
> know how to do this? Do I have to deal with the Widcomm drivers (seem to 
> be monopolists) or is there a common way?

as I know there is no Windows stack that provides full access to the HCI
layer as BlueZ do. Actually it must be possible in some kind of way, but
in most cases you have to pay for their development kit.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
