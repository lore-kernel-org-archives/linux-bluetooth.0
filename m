Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Success: switching the Logitech-Hub
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <Olivier.Bornet@puck.ch>
Cc: Alexander Holler <holler@ahsoftware.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040106171510.GE15149@smartdata.ch>
References: <9810000.1073197538@[192.168.207.2]>
	 <1073267036.3804.4.camel@pegasus>  <20040106171510.GE15149@smartdata.ch>
Content-Type: text/plain
Message-Id: <1073411335.2508.96.camel@pegasus>
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
Date: Tue, 06 Jan 2004 18:48:55 +0100

Hi Olivier,

> one of our device has an ID of 0x046d:0xc703. Can you add it to the
> hid2hci.c file in the CVS ? I have tested it, and it works OK.

done.

> One question: I can't switch back to USB mode. Is this not supported at
> this time ?

No. I think it is possible, but at the moment we don't understand how
the Logitech protocol works. I have some written notes about it on my
desktop, because they also use the same protocol framework for driving
the display of the mediapad. But I haven't found the time to setup a
webpage about it.

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
