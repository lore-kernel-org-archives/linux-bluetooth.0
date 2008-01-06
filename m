Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jan 2008 02:18:26 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Message-ID: <20080106021826.GR27894@ZenIV.linux.org.uk>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
	<20080105075039.GF27894@ZenIV.linux.org.uk>
	<477F9481.2040505@gmail.com>
	<20080105194510.GK27894@ZenIV.linux.org.uk>
	<478037F8.8020103@gmail.com>
Mime-Version: 1.0
In-Reply-To: <478037F8.8020103@gmail.com>
Cc: Gabor Gombas <gombasg@sztaki.hu>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, ebiederm@xmission.com,
	bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] Oops involving RFCOMM and sysfs
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

On Sun, Jan 06, 2008 at 11:07:52AM +0900, Tejun Heo wrote:

> Right, I haven't thought about that.  When sysfs_get_dentry() is called,
> @sd is always valid so unless there was existing negative dentry, lookup
> is guaranteed to return positive dentry, but by populating dcache with
> negative dentry before a node is created, things can go wrong.  I don't
> think that's what's going on here tho.  If that was the case, the
> while() loop looking up the next sd to lookup (@cur) should have blown
> up as negative dentry will have NULL d_fsdata which doesn't match any sd.

No.  What happens if sd gets unlinked while we are on the way to
sysfs_get_dentry() and so does its parent?  The parent is off the
sibling list, we get negative dentry from lookup.  It's not hashed,
so won't stick around in dcache (which is apparently what you are
thinking about).  However, _THIS_ lookup has returned you a dentry
with NULL ->d_inode and you are well and truly buggered.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
