Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] - BT HID message parsing framework and
	fixes for Keyboards in boot mode.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1103056217.6424.23.camel@localhost>
References: <1103056217.6424.23.camel@localhost>
Content-Type: text/plain
Message-Id: <1103112320.2143.228.camel@pegasus>
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
Date: Wed, 15 Dec 2004 13:05:20 +0100

Hi Matthew,

> I have reworked the patches as you have requested.  They are attached to
> this message.
> 
> This is the BT HID message parsing framework that I wrote, based on the
> Bluetooth HID specs. The kernel versions the patches are against are
> mentioned in their names.  The one against 2.6.10-rc3-bk6 is the one for
> the standard BT HID code in the stock kernel, then other contains fixes
> for report mode processing where the BT device is stuck in Boot mode due
> to being first of all configured by the computer BIOS.
> 
> The devices I tested this with are Apple BT keyboard, and Logitech Mx900
> mouse.  the changes are all conservative, and should work with all
> devices.  
> 
> I have left the debug work I did as is in the patches as I need it to
> debug the work I am doing.  It fixes various compile problems with the
> debug code, as well as adding output of data that I found useful in
> diagnosing my keyboard problems.  I am planning to continue my work on
> the BT HID as I am able, and hope to do phase 2 (SET_ and GET_) HID
> state machines over the Christmas holidays.  The Debug stuff has to stay
> there.  Basically if you want me to significant work in the BT HID area,
> I need a free hand to do things.  I already have to spend quite a bit of
> time making a patch for the standard kernel, as well as against the
> 2.6.x-mhx patches which I do my development against.  We need to discuss
> how we are going to work this so that it does not take too much of your
> time.

I only looked at the -rc3-bk6 patch, because as I said, this is what we
gonna do first. I don't wanna see any debug specific changes in there. I
will remove them anyway and this takes me only longer to merge this
patch into my tree. The rest of this patch looks fine and there is only
one coding style issues that I might not mentioned last time. In a
"switch" construct we normally add an empty line between "break" and the
next "case".

And another thing. What is the difference between ...ctrl_message()
and ...ctrl_byte()? We don't need that. If data is NULL then both is the
same.

> I am hoping to get a Web site up shortly with these patches and further
> work, as well as a version control system for a BT HID project!

I don't see any advantage of it, but if it helps you, do it. I only
accept plain patches with a description like you sent.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
