Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Jan 2008 04:22:16 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Message-ID: <20080117042216.GB27894@ZenIV.linux.org.uk>
References: <478D74A6.7000206@gmail.com> <478D75BD.1010805@gmail.com>
	<alpine.LFD.1.00.0801151928380.2806@woody.linux-foundation.org>
	<20080116035224.GW27894@ZenIV.linux.org.uk>
	<478DB0E1.7090401@gmail.com>
Mime-Version: 1.0
In-Reply-To: <478DB0E1.7090401@gmail.com>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	bluez-devel@lists.sourceforge.net,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Bluez-devel] [PATCH 2.6.24-rc7 2/2] sysfs: fix bugs in
	sysfs_rename/move_dir()
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Wed, Jan 16, 2008 at 04:23:13PM +0900, Tejun Heo wrote:

> The two posted patches are bug fixes for apparent bugs which can be
> triggered by the current two users of the interface.  AFAICS, locking
> there is weird but correct for the current two users.  If you can find
> any problem there, please lemme know.

How about "what happens after that move-to-NULL if you have a cwd inside
the subtree", for starters?

>  We shouldn't hold this type of
> fixes for future clean ups.

No, but I'd rather see the rules for callers of sysfs/kobject primitives
spelled out - before cleanups or review become even possible.
 
> > As it is, I'm more than inclined
> > to propose ripping kobject_move() out, especially since it has only two
> > users - something s390-specific and rfcomm, with its shitloads of problems
> > beyond just sysfs interaction.
> 
> Can you please elaborate?  All sysfs problems discovered by the rfcomm
> are fixed by the posted patches.  Dave Young has a patch waiting for
> verification by the tester.

Umm...  IIRC, there'd been a lot of fun with tty and procfs sides of that;
will check.

> Furthermore, even if we rip out
> kobject_move() in the future, I don't think -rc7 is the right time to do it.

OK...  You do have a point, but at this stage I'm not convinced that this
thing is safe and usable.  I agree that patches do not make things worse,
but I suspect that the real problem with kobject_move() is that it's a
fundamentally broken interface.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
