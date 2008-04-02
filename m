Return-Path: <cyrus@holtmann.org>
Message-Id: <D9DBA8CC-0F30-4B95-8B94-A0DEC4F73674@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <014c01c894ca$6cfbe010$6701a8c0@freqonedev>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 2 Apr 2008 17:50:49 +0300
References: <014c01c894ca$6cfbe010$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] Bug in audio/AVRCP
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

Hi David,

On Apr 2, 2008, at 17:04, David Stockwell wrote:
> There appears to be a bug in 3.29/audio/control.c, lines 1050-1051.   
> In avrcp_exit, the code removes the ct_record_id twice, and does  
> nothing to remove the tg_record_id.

Thanks for the info, however it had already been fixed in the CVS.

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
