Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] l2ping acts like ping
Message-ID: <20040417131246.GA2461@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Sat, 17 Apr 2004 15:12:46 +0200

On  0, Marcel Holtmann <marcel@holtmann.org> wrote:
> > we should possibly ping from 0 not 200 like normal ping :)
> 
> I don't know why it is from 200, so I applied your patch. Thanks.

snip l2cap.c 
...
	/* Get next available identificator.
	*    1 - 199 are used by kernel.
	*  200 - 254 are used by utilities like l2ping,
	*  etc
	*/
...

So probably a ident under 200 could interfere with kernel packets, but
as far as i can see kernel don't enforces using higher ids. So it seems
there is some more digging in the code necessary, to see whether there
is a problem in 
Reading the specs it seems that id doesn't matter at all, because it is
intended for an connection oriented ping. And doing some field research,
i found that this modified l2ping works with the stack of my T610 but it
can't ping other bluez stacks, propabably because :

" ... The null identifier (0x0000) is defined as an illegal
identifier and must never be used as a destination end-point. ..."
BT 1.1 spec - page 261

so ident should be at least >= 1.

just my humble opinion
nicholas

p.s. sorry marcel for this dumbass mail copy, just too stupid for my MUA


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
