Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801071547k792a5b9fqe6e7e72e597b0e5f@mail.gmail.com>
Date: Mon, 7 Jan 2008 16:47:49 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080107230910.GA5883@ps.ms.mff.cuni.cz>
MIME-Version: 1.0
References: <20080107230910.GA5883@ps.ms.mff.cuni.cz>
Subject: Re: [Bluez-devel] patch removing one extra memset
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

Pavel

> I have found one mistake in audio/ctl_bluetooth.c . When initializing
> this plugin, 'data' is allocated and memset-ed to 0. Then socket is
> created and assigned to 'data'. And then there is another memset

ok, fixed. I also saw the first memset happened before the test to see
if the malloc worked.

-- 
Brad

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
