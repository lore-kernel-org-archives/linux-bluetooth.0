Return-Path: <cyrus@holtmann.org>
Message-Id: <39C940F5-0157-43EB-9841-D5B7D35CCBF9@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47EA8056.8090500@idlum.be>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 26 Mar 2008 18:05:42 +0100
References: <47EA8056.8090500@idlum.be>
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

> It seems that once a friendly name has been cached to /var/lib/ 
> bluetooth/*/names, RemoteNameUpdated signals contain this cached  
> name forever, and user is never informed of a name change unless  
> those "names" files are deleted.

the names are never updated once retrieved. At least not via an  
inquiry run. If you connect to a remote device, it will update the  
name. Another option is Extended Inquiry support if you have the  
hardware for it.

The reason behind this is that the remote name operation is too  
expensive if you don't have an ACL link between two devices. And a lot  
of times the name doesn't change so often or it is unimportant anyway.

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
