Return-Path: <cyrus@holtmann.org>
Message-Id: <8AE6C0B8-481C-4388-B089-B78050E7E6E2@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47EB9D01.6090400@idlum.be>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 27 Mar 2008 16:06:15 +0100
References: <47EA8056.8090500@idlum.be>
	<39C940F5-0157-43EB-9841-D5B7D35CCBF9@holtmann.org>
	<47EB9D01.6090400@idlum.be>
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

>>> It seems that once a friendly name has been cached to /var/lib/
>>> bluetooth/*/names, RemoteNameUpdated signals contain this cached
>>> name forever, and user is never informed of a name change unless
>>> those "names" files are deleted.
>>
>> the names are never updated once retrieved. At least not via an
>> inquiry run. If you connect to a remote device, it will update the
>> name. Another option is Extended Inquiry support if you have the
>> hardware for it.
>>
>> The reason behind this is that the remote name operation is too
>> expensive if you don't have an ACL link between two devices. And a  
>> lot
>> of times the name doesn't change so often or it is unimportant  
>> anyway.
>
> It makes a lot of sense, at least for the python example I submitted,
> which was only performing calls to "DiscoverDevices".
>
> But I've encountered another situation, where bluez' caching behaviour
> produces some nonsense. I have no simple test application to provide,
> but it is quite simple to explain and understand.
>
> I've an application which performs a continuous inquiry (eg when it  
> gets
> DiscoveryCompleted, it calls DiscoverDevices() and so on). In the
> meantime, this application does also perform sdp extraction and rfcomm
> connections to the detected devices. Here is a record of all
> RemoteNameUpdated signals from a particular device:
>
> I delete /var/lib/bluetooth/*/names, set my device's name to "Name 1",
> and start my application
>
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
>
> So far so good. At this point I set my device's name to "Name2": I  
> start
> to get mixed values (I understand that "Name1" are sent out from the
> discovery, and thus use the cached value as you explainded above, and
> "Name2" are from the other operations, which are actually getting the
> current name, because they do connect to the device)
>
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name1
>
> At this point I delete /var/lib/bluetooth/*/names. As cache is  
> recreated
> with the current value (Name2) everything looks good again
>
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
>
> At this point, I change my device's name to "Name3". Things get  
> mixed up
> again.
>
> RemoteNameUpdated signal received: 006057BB4D92 - Name3
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name3
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name3
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
> RemoteNameUpdated signal received: 006057BB4D92 - Name3
> RemoteNameUpdated signal received: 006057BB4D92 - Name2
>
> So, shouldn't the cached value get updated when bluez gets a different
> name later on?

this indeed looks like a bug. Seems like the new name is not written  
to disk. Can you re-produce this with bluez-utils-3.29?

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
