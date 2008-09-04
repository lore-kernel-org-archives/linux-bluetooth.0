Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fabien Chevalier <fabchevalier@free.fr>
In-Reply-To: <48BFBBED.5010504@free.fr>
References: <48BEE75C.9050008@free.fr>
	<1220471377.6714.52.camel@californication> <48BFBBED.5010504@free.fr>
Date: Thu, 04 Sep 2008 15:49:37 +0200
Message-Id: <1220536177.6714.68.camel@californication>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sniff mode issues regarding
	Sony	Ericsson	headsets: kernel	patch proposal.
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

Hi Fabien,

> > Also this is not BlueZ screwing anything up. Where is written that we
> > have to get out of sniff mode before we can disconnect a link. What kind
> > of hardware are you using? Does BlueZ always have to cleanup after
> > broken hardware and f*cked up stacks?
> 
> Lol :-)
> I never said that Bluez was screwing up anything.
> But as usual, there are compromises to make between sticking close to 
> the standard and having good interoperability, which usually involves 
> some level of workaround :-)

I am seriously sick of this f*cked up hardware. What is it? My guess
would be a TI chip.

> > Make it two separate patches. We can send the exit sniff mode command
> > that is not a problem. I still don't like it, because it is the job of
> > the Link Manager to do this.
> 
> Will do.
> 
> You didn't answer to question 2: what's your choice ? (btw to question 1 
> neither, but i guess that means a 'yes' :-)

I would first have to know which host controller it is, before I
actually think about adding something like this.

> > For the sniff mode setting you have to use SOL_BLUETOOTH since I will
> > remove all the other SOL_* and consolidate them.
> 
> hmmm... not sure i really see what you mean. :-(

Don't use SOL_L2CAP or SOL_RFCOMM anymore. They will be all
SOL_BLUETOOTH since there are no different between the socket options
itself.

Regards

Marcel



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
