Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ben Wilson <bwilson@yooser.org>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bthid,ppc,sdp
Message-ID: <20040519212124.GI15386@stag.mark-and-erika.com>
References: <878yfp4bmz.fsf@handgranat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <878yfp4bmz.fsf@handgranat.org>
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
Date: Wed, 19 May 2004 17:21:24 -0400

* On Wed, May 19, 2004 at 12:24:20AM +0200, I received from Sunnan:
> I've been away from the "under-the-cover" part of geekdom for a while,
> including bluez-user, but on whim decided to check out the new sdp
> from cvs.
> 
> I just wanted to say that my mouse (Apple Wireless Mouse) works fine
> on my iBook now, and I wanted to say thanks, and I wanted to say that
> I'm sorry that I couldn't be of more help.

What kernel and bluez-libs/utils are you using?

I am still having the same problem with bthid dying when I try and
connect my MS bluetooth mouse with a PowerBook running
2.6.6-rc2.

I did try patch-2.6.6-mh1, but get the following errors:

net/built-in.o(.text+0x71360): In function `hid_output_report':
: multiple definition of `hid_output_report'
drivers/built-in.o(.text+0xf23c0): first defined here
net/built-in.o(.text+0x715f0): In function
`hid_find_field_in_report':
: multiple definition of `hid_find_field_in_report'
drivers/built-in.o(.text+0xf2650): first defined here
net/built-in.o(.text+0x714a8): In function `hid_find_field':
: multiple definition of `hid_find_field'
...(etc.)

Any ideas?
 
> Thanks a bunch!
> 
> Sunnan

Thanks!
Ben


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
