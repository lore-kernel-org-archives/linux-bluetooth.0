Return-Path: <cyrus@holtmann.org>
Message-Id: <A0B79457-4255-49EB-BDA5-A3D2B903B75C@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <d89ddf300803262043qba89bb8r1a24ce91b04b5e45@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 27 Mar 2008 16:10:32 +0100
References: <8f5c4ad0803250501x51e5cac8m7c21a6e41460c644@mail.gmail.com>
	<d89ddf300803250516j6cf27fdbjf0740759b823435a@mail.gmail.com>
	<8f5c4ad0803250600q4b36a962w27e57fc3210ebd09@mail.gmail.com>
	<d89ddf300803250739ga372a9fy6d1aa4eff033be0e@mail.gmail.com>
	<6F34AFC6-0E93-4CDD-BDFB-376BD964FCFB@holtmann.org>
	<d89ddf300803262043qba89bb8r1a24ce91b04b5e45@mail.gmail.com>
Subject: Re: [Bluez-users] ACL connection handle
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Brad,

>> shouldn't be a big problem, but in general this belongs into the
>> kernel since userspace is not dealing with ACL and SCO/eSCO  
>> connection
>> handling.
>
> I'll agree it would be cleaner in kernel. If it's to be handled in the
> kernel then I think we need some way like an ioctl so the userspace
> app can tell the kernel, before opening the sco connection, whether it
> should happen on pcm or hci. It would be handy to have a way for the
> app to ask the kernel where sco is going, in case the preferred
> transport wasn't available.

we would need to push the actual code into the drivers since the core  
has to stay vendor free. For selecting the routing we could use a  
socket option.

Regards

Marcel


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
