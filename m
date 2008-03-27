Return-Path: <cyrus@holtmann.org>
Message-Id: <A6101457-EB18-4E68-ADF9-903DC957C013@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <89b6ba3a0803271229r239c74b9od9d3c28132886921@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Fri, 28 Mar 2008 00:15:29 +0100
References: <89b6ba3a0803231540t258807bdk703d843a18a63a3e@mail.gmail.com>
	<81E635B3-43C3-4956-B5ED-D9C4BFE8E235@holtmann.org>
	<89b6ba3a0803260937i21870643xa2207770239d469a@mail.gmail.com>
	<77B64B1C-EB7C-4543-898D-BDE66C48BBD7@holtmann.org>
	<89b6ba3a0803271229r239c74b9od9d3c28132886921@mail.gmail.com>
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

>>> yes, the options are there but there seems to be a problem with  
>>> device
>>> discovery somewhere in my setup. Is running hcid enough for the  
>>> device
>>> detection to work? It seems only the already paired devices show up
>>> (it worked fine at least with bluez-gnome 0.15) so I assume it only
>>> displays a memorized list of devices not doing discovery at all. How
>>> do I debug it? I'm a programmer so if you point me to the right
>>> internals I think I could fix the issues or at least provide you  
>>> with
>>> more info.
>> That should have been fixed with the latest bluez-gnome version.
>
> As mentioned eaerlier, we are already shipping bluez-gnome 0.25 and
> bluez-{libs,utils} 3.29
>
> If it works for everyone else it has to be related to our setup so
> please point me in the right direction for debugging.

it is actually our fault within bluez-utils-3.29. We accidently  
removed the device discover calls from the API. Expect a new release  
soon.

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
