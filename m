Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Setting up an hotplug connection with USB dongles
References: <200411282132.37941.rdorsch@web.de> <200501021837.34836.rdorsch@web.de> <1104687680.8894.17.camel@pegasus>
In-Reply-To: <1104687680.8894.17.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200501031114.37391.rdorsch@web.de>
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
Date: Mon, 3 Jan 2005 11:14:37 +0100

Hi Marcel,

Am Sonntag, 2. Januar 2005 18:41 schrieb Marcel Holtmann:
> Hi Rainer,
>
> > > if you use "auto bnep0" and hotplug is configured to deal also with the
> > > network interface then bnep0 will be brought up at the time the kernel
> > > created it. No need to run ifup/ifdown manually.
> >
> > Hmm....do I enable that with in /etc/default/hotplug
> >
> > # NET_AGENT_POLICY
> > # - how to manage network interfaces with ifupdown? 'all', 'auto' or
> > 'hotplug' NET_AGENT_POLICY=hotplug
>
> I had no problem with 'hotplug', but you can also try to use 'auto'.
>

yes, with auto it works out of the box. Setting it back to hotplug made it 
stopping working, because in my /etc/network/interfaces

mapping hotplug
  script echo
  map bnep0

was missing.

Now the interfaces come up without the ifup.

Many thanks,
Rainer

-- 
Rainer Dorsch
Alzentalstr. 28
D-71083 Herrenberg
07032-919495
Icq: 32550367


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
