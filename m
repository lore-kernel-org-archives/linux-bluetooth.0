Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dinovo multimedia keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Oli Ellis <oliver.ellis@ntlworld.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40605F5C.30902@ntlworld.com>
References: <406005DB.2090109@ntlworld.com>
	 <1080051605.2515.20.camel@pegasus>  <40605F5C.30902@ntlworld.com>
Content-Type: text/plain
Message-Id: <1080075308.2515.41.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 23 Mar 2004 21:55:09 +0100

Hi Oli,

> It does not seem to be an error with the parser - I checked the USB HID 
> usage tables, and they tally up with the parser code. However, the 
> consumer buttons on the dinovo all seem to be out by one. For example:
> 
> Key label	keyboard reports (hex)	Should be (hex)
> -------------------------------------------------------
> My Pictures	1b7			1b6
> My Music	1b8			1b7
> Volume+		ea			e9
> Volume-		eb			ea
> Mute		e3			e2
> &c
> 
> Now the question is whether this is a problem in hardware (and if so how
> widespread it is), or the kernel bluetooth bit, or the parser. I can't see
> anything wrong with parser.c, and am inclined towards a bodge job by
> Logitech (and I was so pleased with my new keyboard...) However the
> DiNovo is widespread, so if it is a HID implementation error, any ideas on
> how it can be elegantly worked around?

acutally it can be the parser. Check how the report descriptors of the
Logitech diNovo and the Microsoft keyboard differs. I think our parser
is wrong and shifts a bit with the Logitech descriptor. All information
can be found here

	http://www.holtmann.org/linux/bluetooth/hid.html

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
