Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez HID story?
From: Marcel Holtmann <marcel@holtmann.org>
To: John McCorquodale <mcq@cacr.caltech.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040309212125.GA27173@viz.cacr.caltech.edu>
References: <20040309212125.GA27173@viz.cacr.caltech.edu>
Content-Type: text/plain
Message-Id: <1078871875.10671.86.camel@pegasus>
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
Date: Tue, 09 Mar 2004 23:37:55 +0100

Hi John,

> So I'm trying to get my spiffy new Logitech BT keyboard working with my CF
> BT card.
> 
> I found Peter Klausler's 'bthid' which seems to sortof work with the uinput
> driver in 2.4.25.  However, when typing very fast, it repeats substrings of
> my input more than once (e.g. 'ls -lsa' -> 'ls -ls-lsa') which is a problem
> that typing more slowly eliminates.  I've also had my kernel panic once or
> twice when trying this stuff out.
> 
> I also found Marcel's page:
> 
>   http://www.holtmann.org/linux/bluetooth/hid.html
> 
> Which starts off great talking about how "this reimplementation" reuses the HID
> parser from USB and is morally superior to Peter's work.  However, the page
> then goes on to talk about all sorts of USB dongles, which is irrelevant (the
> whole point of a BT keyboard is to throw the dongle in the trash and use my
> laptop's builtin BT), and further doesn't seem to talk about any exiting code
> at all past the mention of "this reiplementation" in the first paragraph.
> 
> My question is:
> 
>   What is the best currently working way to handle bluetooth HI devices?  The
>   device itself, not the dongle.  How does one configure host-initiated
>   disconnection on idle detection (since I'm a Logitech KB, I guess I need to
>   do that)?  Am I just totally missing the important message on Marcel's
>   HID page?  By the way: what's doing the layout on hortmann.org? -- I really
>   respect and admire the minimalism and good design sense of those pages.
> 
> If there is such a thing, can you give me a quick breakdown of the steps one
> would take to get it working?  For example, for bthid, the steps I use go:
> 
>   1. Get HCI working (cardmgr loads serial_cs, hciattach ttyS0 bcsp 2300400)
>   2. Compile bthid from http://www.visi.com/~pmk/bthid-0.10.tar.gz
>   3. hcitool scan, hit connect button, to deduce BT address of keyboard
>   4. bthid -n -v -v <address>
>   5. hit connect on KB
> 
> If there is no existing HID implementation other than Peter's, please let me
> know this so I know it's worth the time to debug the substring repeat problem
> and figure out why it panics me.

actually there is a new implementation. The code is only present in the
CVS, because it makes use of the new Bluetooth library and this is not
fully ready for mainstream. A installation HOWTO can be found here

	http://www.bueche.ch/comp/mx900/mx900.html

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
