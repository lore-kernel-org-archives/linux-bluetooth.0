Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Keeping keyboards alive
From: Marcel Holtmann <marcel@holtmann.org>
To: Bernard Mentink <Bernard.Mentink@trimble.co.nz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8285CB7241FCFC4BB721A6F953F9B35EFB30EB@nzc-ap-xch-01.ap.trimblecorp.net>
References: 
	 <8285CB7241FCFC4BB721A6F953F9B35EFB30EB@nzc-ap-xch-01.ap.trimblecorp.net>
Content-Type: text/plain
Message-Id: <1079350163.3405.6.camel@pegasus>
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
Date: Mon, 15 Mar 2004 12:29:24 +0100

Hi Bernard,

> I have been using my Apple Bluetooth keyboard sucessfully for some weeks now with the stack and am very happy with it.
> 
> My only niggle is the lack of support for regular polling of the keyboard to keep it awake.
> (The keyboard goes into deep sleep after about 10mins of inactivity, I then have to cycle the power to reconnect)

there is a similar problem with the Microsoft devices, but I thought I
fixed it. Keeping the device connected is bad for battery. For example
my Apple mouse never disconnects. My only missing Bluetooth HID device
is the Apple keyboard and so I think that I can't tell you anything
useful.

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
