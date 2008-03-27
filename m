Return-Path: <cyrus@holtmann.org>
Message-Id: <EB8AE604-BA9B-4BB2-A0EA-8781FEC05CE1@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47EBBC24.50604@idlum.be>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 27 Mar 2008 16:45:31 +0100
References: <47EA8056.8090500@idlum.be>	<39C940F5-0157-43EB-9841-D5B7D35CCBF9@holtmann.org>	<47EB9D01.6090400@idlum.be>
	<8AE6C0B8-481C-4388-B089-B78050E7E6E2@holtmann.org>
	<47EBBC24.50604@idlum.be>
Subject: Re: [Bluez-devel] Cached friendly names never updated when changed
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

Hi Pierre-Yves,

>> this indeed looks like a bug. Seems like the new name is not written
>> to disk. Can you re-produce this with bluez-utils-3.29?
>
> Ok, I'll upgrade this box to 3.29 and try to reproduce it. FYI this
> output comes from a box running v3.28.

my assumption is that it still is broken then. I don't recall changes  
in that area.

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
