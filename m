Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Deepesh S Gujarathi <d_gujarathi@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LAW11-OE14JMxg22Civ0001db81@hotmail.com>
References: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com>
	 <1073314449.2508.1.camel@pegasus> <LAW11-OE14JMxg22Civ0001db81@hotmail.com>
Content-Type: text/plain
Message-Id: <1073394980.2508.59.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: blueZ-bthid testing
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
Date: Tue, 06 Jan 2004 14:16:20 +0100

Hi Deepesh,

> I tried to create the device node using the following commands but I still
> get the same error ( > bthid[2040]: can't open input device: no such file or
> directory (2)) .
> I created a device node using the command
> # mknod /dev/misc/uinput c 10 101
> I hope I an not feeding the wrong MAJOR device number.

yes you do. According to Documentation/devices.txt it is "c 10 223". And
of course the kernel module "uinput" must be loaded.

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
