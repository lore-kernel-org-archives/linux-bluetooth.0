Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] cvs software issues
From: Marcel Holtmann <marcel@holtmann.org>
To: Dariusz Swiderski <sfires@sfires.net>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40680EB8.2070208@sfires.net>
References: <40675F3B.5090704@sfires.net>
	 <1080557069.2281.224.camel@pegasus>  <40680EB8.2070208@sfires.net>
Content-Type: text/plain
Message-Id: <1080561659.2281.236.camel@pegasus>
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
Date: Mon, 29 Mar 2004 14:00:59 +0200

Hi Dariusz,

> > it should create it if it is missing.
> 
> apparently it doeas not:
> sfires@snoopy:/home/storage/software/cvs/bluez/libs2$ ./bootstrap
> configure.in: installing `./install-sh'
> configure.in: installing `./mkinstalldirs'
> configure.in: installing `./missing'
> configure.in:19: installing `./config.guess'
> configure.in:19: installing `./config.sub'
> configure.in:19: required file `./ltmain.sh' not found
> compat/Makefile.am: installing `./depcomp'
> 
> im not very goot with automake and autoconf sripts, but in utils and libs
> this file, is pulled from cvs, and yes, i have seen the remark in attic ;)

it says so, but does this mean that it is not created ;)

> > There is no planned coexisting of both version and if libs2 and utils2
> > are ready for rollout it will replace the old one.
> 
> ok, i can live with this, but what about hcid? its not in utils2

I am not quite sure about the real future of hcid. We will have a
replacement for it, but I want to redesign some parts of it.

> > Every program that uses the old library must rewritten to use the new
> > one. Especially sdptool, pand and dund. The other big project is writing
> > a new sdpd.
> 
> so who is doing what, and where can i help?:)

At the moment nobody. So feel free to take the code and clean it up and
make it libs2 compatible.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
