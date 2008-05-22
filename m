Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: David Stockwell <dstockwell@frequency-one.com>
In-Reply-To: <015401c8bbb3$4de51ce0$6701a8c0@freqonedev>
References: <013e01c8bb99$b4ba5580$6701a8c0@freqonedev>
	<E0A89313-87C7-4C2B-B91E-5D4326DD27DD@holtmann.org>
	<015401c8bbb3$4de51ce0$6701a8c0@freqonedev>
Message-Id: <71A309EC-AAA0-42AF-994D-E5E9CF553682@holtmann.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 22 May 2008 09:54:02 +0200
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Issues with BlueZ v3.31 Object Path Naming
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

> Thanks for the quick response; I do appreciate it and the effort all  
> of you have expended in marshaling this migration to DBus. I
> fully appreciate the benefits!
>
> I also appreciate that prepending every path with "/org/bluez" was  
> more than a little redundant...
> So, under 4.X: the Manager's path is "/";
> the Adapter's path is "/hci<n>";
> the device's path is "/hci<n>/dev_<remote address>"

that is correct.

> Still, the audio device paths will be /org/bluez/device<n>,  
> correct?  Or will it just be /device<n>, or perhaps /hci<n>/device<n>?

We are going to re-design that part of the API during the next week.  
Once that is done, they will also be deprecated. The idea here is that  
we have a generic remote device object path now and we will use it for  
every service instead of having every service to do this all over again.

> Also, the old paths are documented in doc/xxx-api.txt.  I will be  
> happy to provide updates.

I that is so, then that is a bug on my side. It shouldn't be. At least  
not intentionally :)

> I will also proceed to dig through the code to straighten out the  
> naming per the new names (assuming "experimental" is set).
>
> One more issue: in manager.c and adapter.c, the _init functions  
> enable the new Methods and Signals if experimental is set, then
> enables the old Methods and Signals (even if they have the same  
> names) after that.
>
> If experimental is set, should we not turn off the old methods and  
> signals?  If you refer to my previous posts, you will find that
> when Discovery is completed, signals are returned against the old  
> and new paths/signals simultaneously; very confusing, but now that
> I see how things work, I understand why it has been happening.

We can't break the old API during the 3.x releases. So the new one can  
be enabled for testing. Disabling the old one at the same time will  
break to many applications.

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
