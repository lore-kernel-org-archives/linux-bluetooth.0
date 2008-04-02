Return-Path: <cyrus@holtmann.org>
Message-Id: <2218E26D-54B0-47BF-AC87-7DFE9927EFE2@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <89b6ba3a0804021244q2bd22bdeo5d774a6901426032@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 2 Apr 2008 21:50:28 +0200
References: <89b6ba3a0803231540t258807bdk703d843a18a63a3e@mail.gmail.com>
	<81E635B3-43C3-4956-B5ED-D9C4BFE8E235@holtmann.org>
	<89b6ba3a0803260937i21870643xa2207770239d469a@mail.gmail.com>
	<77B64B1C-EB7C-4543-898D-BDE66C48BBD7@holtmann.org>
	<89b6ba3a0803271229r239c74b9od9d3c28132886921@mail.gmail.com>
	<A6101457-EB18-4E68-ADF9-903DC957C013@holtmann.org>
	<89b6ba3a0804021244q2bd22bdeo5d774a6901426032@mail.gmail.com>
Subject: Re: [Bluez-users] Recent bluez-gnome problems
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

Hi Patryk,

>> it is actually our fault within bluez-utils-3.29. We accidently
>> removed the device discover calls from the API. Expect a new release
>> soon.
>
> Hi guys, any news on this front? Is there an already planned release?
> If not, what is the safe version to revert to in the distro?

I am doing the release today. Using 3.28 will be good. Or you grab  
that one patch from the CVS. It is something like changing two or  
three lines of code.

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
