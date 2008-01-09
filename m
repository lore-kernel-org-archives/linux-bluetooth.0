Return-Path: <cyrus@holtmann.org>
Message-Id: <D2E21FE3-C4DE-484A-A593-31BD5900B83C@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Wed, 9 Jan 2008 05:03:52 +0200
References: <20080109002828.GB5883@ps.ms.mff.cuni.cz>
Subject: Re: [Bluez-devel] error in headset capture, patch included
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

Hi Pavel,

On Jan 9, 2008, at 2:28, Pavel Semerad wrote:
> I have found error in function bluetooth_hsp_read. frame_size is
> correctly set only when data->count is zero. When data->count is
> nonzero, frame_size is 0 and condition
> 'if ((data->count + size * frame_size) <= data->link_mtu)'
> is always true and frames_to_write is set incorrectly (1000 instead
> max 24 in my case). This results in capture not working for headset,
> cycling in endless loop.
>
> Following patch sets frame_size before check to data->count and
> 'arecord -D bluetooth -f S16_LE' now works.

Nice catch! Thanks! Commited to CVS now.

Johan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
