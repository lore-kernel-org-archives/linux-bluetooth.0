Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Keeping keyboards alive
From: Marcel Holtmann <marcel@holtmann.org>
To: Bernard Mentink <Bernard.Mentink@trimble.co.nz>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <8285CB7241FCFC4BB721A6F953F9B35E0F38D8@nzc-ap-xch-01.ap.trimblecorp.net>
References: 
	 <8285CB7241FCFC4BB721A6F953F9B35E0F38D8@nzc-ap-xch-01.ap.trimblecorp.net>
Content-Type: text/plain
Message-Id: <1079379465.4395.7.camel@pegasus>
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
Date: Mon, 15 Mar 2004 20:37:45 +0100

Hi Bernard,

> Thanks for the reply. In my situation battery drain is not a concern. I am using the keyboard in a PVR situation, i.e I have
> a MythTV linux box in the lounge and I use the keyboard when I am surfing the net, typically I would turn the keyboard on and use
> it for an hour, having it turn off after 10 mins inactivity is only a slight niggle, not really a problem. Just thought that maybe a polling
> parameter could be passed to bthid for those situations...
> 
> (I'd offer the use of my keyboard ... but I'm in New Zealand ;-)

for the Microsoft HID devices I fixed it in my new kernel HIDP code. But
without physical access to the Apple keyboard I can't tell you what's
wrong.

Maybe you should look at the old bthid code from Peter Klausler. I think
it has some polling code.

> By the way, I have cobbed together a startup script which I have in run-level-5 to get everything going on powerup, so that I can just turn
> on the keyboard and connect. However, sometimes it does not boot up all the time .... do you have an example of a script that you use?

I have nothing special.

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
