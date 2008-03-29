Return-Path: <cyrus@holtmann.org>
Message-Id: <FC207646-9302-4A18-85DF-E054BE10A81D@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <019401c8912b$e1876ff0$6701a8c0@freqonedev>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sat, 29 Mar 2008 02:03:52 +0100
References: <019401c8912b$e1876ff0$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] Experimental Mode: org.bluez.Adapter
	Methods/Signals
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

> In the adapter.c code (bluez-utils-3.29), there are a number of 4.x  
> methods and signals, which are enabled when hcid is run in  
> experimental mode (-x in startup).
>
> There are a whole lot of others that are labeled as "deprecated",  
> but which are currently available when hcid is in experimental mode,  
> as well as when it is not.  Are these in fact going to be dropped  
> when 4.x is released?

yes, with 4.0 all old ones will be dropped.

> On a similar topic:
>
> When the 4.x methods are registered, they register on bus  
> "org.bluez", with interface "org.bluez.Adapter", but unlike 3.x, the  
> path they use is not "/org/bluez/hci0" but just "/hci0" (for the  
> default case).  Is this intentional and the future direction of  
> bluez-dbus?

Yes. However use DefaultAdapter() or FindAdapter() to get the path.  
Hardcoded paths will fail in the future.

> I ask because when I tried calling DiscoverDevices, it would fail  
> when I called with path "/org/bluez/hci0", but would run when I  
> called it with path "/hci0".  But, the funny thing is that because  
> the RemoteDeviceFound signal is registered to both the old path and  
> the new path, the signals come back on "/org/bluez/hci0".

That is a bug in the 3.29 release and is already fixed in CVS.

> Interestingly enough, when I register callbacks for  
> DiscoveryStarted, RemoteDeviceFound, and DiscoveryCompleted against  
> proxies that reference both the old and new path, I find that  
> signals for DiscoveryStarted and DiscoveryCompleted come back  
> against both paths, but the actual RemoteDeviceFound (and  
> RemoteNameUpdated) comes back only against the 3.x path.

The RemoteDeviceFound will be a DeviceFound within 4.x and it will be  
a dictionary that can include the name if available.

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
