Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Andreas Merkle <merkle@newtec.de>
Date: Tue, 28 Nov 2006 22:32:46 +0000 (UTC)
Message-ID: <loom.20061128T231453-686@post.gmane.org>
References: <20061128071440.25196.qmail@bux.stollmann.net>
	<1164736384.13955.24.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] BECI
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Marcel,

> 
> Hi Juergen,
> 
> > BECI is designeated as a Profile orientated Interface situated on top of 
profiles and protocols
> > to interact with aplications.
> > So its not a question of hardware.
> > However since a working group has not been established yet no specs exist.
> 
> I heard about BECI and actually my understanding is that stuff like
> L2CAP and RFCOMM can run on the Bluetooth chip itself and doesn't needed
> to be implemented in the actual host OS. However my tip is that someone
> might simply have a look at our D-Bus based API, because we designed all
> methods and signals from the viewpoint of the applications. It has
> become one of the easiest to use abstractions, I have seen so far.
> 

the BECI functionality will include all Bluetooth features and 
support both multi-profile and Multilink application. 
Its just like the HCI interface but on a higher level.
One of the advantage is that you can implement L2CAP, RFCOMM etc.
into a chip ... thats right.

How fast it will be a working group is a political issue at the
moment. But if its a working group we can suggest the D-Bus API.

Regards
Andreas



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
