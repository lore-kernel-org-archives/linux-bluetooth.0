Return-Path: <cyrus@holtmann.org>
Date: Sun, 6 Jan 2008 03:35:37 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tejun Heo <htejun@gmail.com>
Message-ID: <20080106033537.GT27894@ZenIV.linux.org.uk>
References: <20071228173203.GA20690@boogie.lpds.sztaki.hu>
	<a8e1da0712290007o168a730cw923055ad2c265d84@mail.gmail.com>
	<20080102151642.GA7273@boogie.lpds.sztaki.hu>
	<20080105075039.GF27894@ZenIV.linux.org.uk>
	<477F9481.2040505@gmail.com>
	<20080105194510.GK27894@ZenIV.linux.org.uk>
	<478037F8.8020103@gmail.com>
	<20080106021826.GR27894@ZenIV.linux.org.uk>
	<478042F3.7010002@gmail.com>
Mime-Version: 1.0
In-Reply-To: <478042F3.7010002@gmail.com>
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

On Sun, Jan 06, 2008 at 11:54:43AM +0900, Tejun Heo wrote:
> That means sysfs_remove_dir() is called on parent while other operations
> are in progress on children, right?  sysfs has never allowed such things
> && AFAIK no one does that.  It's somewhat implied in the interface (such
> as recursive removing) but I fully agree it's problematic.  Things like
> these are why I think we need to unify/simplify locking as I wrote
> previously.

All it takes is kobject_rename() or kobject_move() called asynchronously 
wrt removal...  I don't see an explicit ban for that.

FWIW, what happens here *is* fishy, but I don't see an outright ban on
that in documentation - rfcomm_tty_open() does
                device_move(dev->tty_dev, rfcomm_get_device(dev));
when we get openers, rfcomm_tty_close() does
                device_move(dev->tty_dev, NULL);
when the number of openers hits zero.  Can happen repeatedly.

Note that device_move() with new parent being NULL is explicitly allowed
and handled, so...

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
