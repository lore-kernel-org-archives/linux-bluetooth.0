Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080121.031417.171098597.davem@davemloft.net>
References: <20080121044913.GA4162@darkstar.te-china.tietoenator.com>
	<20080121045401.GB4162@darkstar.te-china.tietoenator.com>
	<20080121.031417.171098597.davem@davemloft.net>
Date: Tue, 22 Jan 2008 07:18:16 +0100
Message-Id: <1200982696.7978.148.camel@aeonflux>
Mime-Version: 1.0
Cc: gombasg@sztaki.hu, htejun@gmail.com, netdev@vger.kernel.org,
	kay.sievers@vrfy.org, linux-kernel@vger.kernel.org,
	bluez-devel@lists.sourceforge.net, viro@zeniv.linux.org.uk,
	greg@kroah.com, cornelia.huck@de.ibm.com
Subject: Re: [Bluez-devel] [PATCH] bluetooth : move children of connection
	device to NULL	before connection down
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

Hi Dave,

> > Add people missed in cc-list.
> 
> Thanks Dave for your continued efforts on Bluetooth bugs like this.
> 
> Marcel, are you going to review/ACK/integrate/push-upstream/whatever
> any of these Bluetooth patches?
> 
> It hasn't been getting much love from you as of late, you are one of
> the listed maintainers, and I don't want to lose any of Dave's
> valuable bug fixing work.

I will be fully back in business next week. Just got stuck in a project
that needed 200% of my time to get it going.

> Or should I just handle it all directly?

I followed the list only a little bit, but from what I have seen is that
Dave is doing a great job in tracking all issues down to the real cause.

I had a look at his last patch and after review, I agree that this is a
possible solution. I only have two nitpicks about the coding style. So
in del_conn the struct device declaration should be made after the
struct hci_conn assignment from the container and I would put an extra
empty line before the devel_del, put_device block. Nitpicks only.

Right now I can't think of any side effects by this patch. Actually I
only see an improvement with this patch. So please take it directly and
starting with next week, I gonna make sure that they are handled again
properly by me.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
