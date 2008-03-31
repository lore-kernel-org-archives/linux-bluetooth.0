Return-Path: <cyrus@holtmann.org>
Message-Id: <B234BE21-AF5C-42F9-9D04-CC003C70E78B@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: dstockwell@frequency-one.com,
	BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200803290830.16736.dstockwell@frequency-one.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Mon, 31 Mar 2008 05:19:09 +0200
References: <200803290830.16736.dstockwell@frequency-one.com>
Subject: Re: [Bluez-devel] Proposed API for org.bluez.audio.control (AVRCP)
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

> As promised, I have laid out a first draft interface for .control,  
> which is
> largely based on AVRCP support provided by CSR.

I think it is a little bit too complex. Lets make this easier and put  
the logic and intelligence into the daemon. Please write down what you  
really do need by this API and don't try to export everything.

> It appears that the *-api.txt documents are created with groff (or  
> something
> like that); this document I just quickly hacked together in KWrite  
> (similar
> to MS Notepad).

It is free from :)

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
