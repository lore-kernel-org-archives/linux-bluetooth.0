Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Setting up an hotplug connection with USB dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200501021837.34836.rdorsch@web.de>
References: <200411282132.37941.rdorsch@web.de>
	 <200501021451.09711.rdorsch@web.de> <1104674297.8894.3.camel@pegasus>
	 <200501021837.34836.rdorsch@web.de>
Content-Type: text/plain
Message-Id: <1104687680.8894.17.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 02 Jan 2005 18:41:20 +0100

Hi Rainer,

> > if you use "auto bnep0" and hotplug is configured to deal also with the
> > network interface then bnep0 will be brought up at the time the kernel
> > created it. No need to run ifup/ifdown manually.
> 
> Hmm....do I enable that with in /etc/default/hotplug
> 
> # NET_AGENT_POLICY
> # - how to manage network interfaces with ifupdown? 'all', 'auto' or 'hotplug'
> NET_AGENT_POLICY=hotplug

I had no problem with 'hotplug', but you can also try to use 'auto'.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
