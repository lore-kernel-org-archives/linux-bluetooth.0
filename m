Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Announce : BlueZ-based implemantation of JSR82
From: Marcel Holtmann <marcel@holtmann.org>
To: Julien Campana <juliencampana@yahoo.fr>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085489942.900.89.camel@fischer>
References: <1085393268.892.40.camel@fischer>
	 <1085487245.9779.89.camel@pegasus>  <1085489942.900.89.camel@fischer>
Content-Type: text/plain
Message-Id: <1085492205.9779.119.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 25 May 2004 15:36:45 +0200

Hi Julien,

> > I would never use Java for Bluetooth programming, but it seems that some
> > companies wants this, especially mobile phone manufacturers. So I think
> > we should build up a clean implementation of the JSR-82 standard that
> > uses BlueZ as underlying Bluetooth stack.
> 
> This is exactly what I did, or at least I have implemented a big part of
> the JSR-82 Standard with BlueZ as underlying Bluetooth stack. (I suppose
> but do not really know if the implementation is clean:)). If you want
> this implementation to be part of the BlueZ project, I (and especially
> my boss:) agree.

it is not, because as you mention later that you have to copy or rewrite
some of the BlueZ functions to fulfil the need for JSR-82. We should
talk about that and see what we can fixup in BlueZ.

What I also don't wanna use is somekind of "de.avetana.bluetooth" vendor
extensions. If something is not possible in pure Java JSR-82, sorry not
my bad ;)

And another important point for me is the coding style. The use of tabs
(8 spaces) is a must, because it makes the code easier to read and keep
developers from over-nesting.

> To better understand the way I have interfaced BlueZ <->JSR-82 and if
> you have enough time for this, I invite you to have a quick look at the
> file sources/c/BlueZ.cpp contained in the tgz archive downloadable at
> http://www.avetana-gmbh.de/avetana-gmbh/jsr82.xml
> 
> This c file mostly re-write some BlueZ method and has surely to be
> cleaned and documented. 
> This will be the next step of my work. This version is still a
> beta-version but is stable and robust enough to be used in a project.
> especially if the project uses RFCOMM connections. (there is still some
> work to do with L2CAP).

The native interface should only be a wrapper. Let's talk about the
stuff and put some of it back to the Bluetooth library where it should
belong.

> > Give me some comments if there is really interest in doing
> > this.
> 
> I will continue to work on this project until I reach a clean and really
> stable implementation. If you have any comment about the implementation
> do not hesitate to mail me. 

I know Java and I did a lot of programming with Java in the past, but I
haven't done anything in the last 5 years. May you write a small howto
for getting your stuff run. For me preferable with Debian Sid.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
