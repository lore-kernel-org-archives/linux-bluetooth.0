Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Rainer Dorsch <rdorsch@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Setting up an hotplug connection with USB dongles
References: <200411282132.37941.rdorsch@web.de> <200501021451.09711.rdorsch@web.de> <1104674297.8894.3.camel@pegasus>
In-Reply-To: <1104674297.8894.3.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200501021837.34836.rdorsch@web.de>
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
Date: Sun, 2 Jan 2005 18:37:34 +0100

Am Sonntag, 2. Januar 2005 14:58 schrieb Marcel Holtmann:
> Hi Rainer,
>
> > > add a line with "auto bnep0" and it will bring up your interface when
> > > it is available.
> >
> > From man interfaces
> >
> > Stanzas beginning with the word "auto" are used to identify the physical
> > interfaces to be brought up when ifup is run with the -a option.  (This
> > option  is  used  by  the system boot scripts.)  Physical interface names
> > should follow the word "auto" on the same line.  There can be multiple
> > "auto" stanzas.  ifup brings the named interfaces up in the order listed.
> >
> > From the ifup manpage
> >
> >       -a, --all
> >               If given to ifup, affect all interfaces marked auto. 
> > Interfaces are brought up in the order in  which  they  are  defined  in 
> > /etc/net- work/interfaces.  If given to ifdown, affect all interfaces.
> > Interfaces are brought down in the order in which they are currently
> > listed in the state file.
>
> if you use "auto bnep0" and hotplug is configured to deal also with the
> network interface then bnep0 will be brought up at the time the kernel
> created it. No need to run ifup/ifdown manually.

Hmm....do I enable that with in /etc/default/hotplug

# NET_AGENT_POLICY
# - how to manage network interfaces with ifupdown? 'all', 'auto' or 'hotplug'
NET_AGENT_POLICY=hotplug

?

Thanks,
Rainer

>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

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
