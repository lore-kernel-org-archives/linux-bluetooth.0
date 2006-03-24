Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Daniel Hertrich" <daniel.hertrich@gmx.de>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
References: <1143199077.6863.4.camel@bnocera.surrey.redhat.com>
Subject: Re: [Bluez-devel] "Can't connect RFCOMM socket"
Message-ID: <20282.1143212154@www019.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 24 Mar 2006 15:55:54 +0100 (MET)

Hello Bastien,

addition:

> On Fri, 2006-03-24 at 11:55 +0100, Daniel Hertrich wrote:
> > Dear bluez developers,
> <snip>
> > * rfcomm bind /dev/rfcomm0 00:02:EE:0D:71:96 1
> 
> Did you check that the device you're connecting to has RFCOMM on channel
> 1?


Now I checked (with sdptool search --bdaddr ... DUN): It is indeed channel
1.

So what possible causes remain?

What is a bit unclear to me is which steps are actually really needed to
connect.
Different Internet pages mention different steps.

e.g. is an "rfcomm bind" needed before the rfcomm connect?
Which modules must be loaded? Could it be that here some modules are
missing?
Where can I find a summary of what conditions have to be met in order to be
able to connect?


Thanks
daniel


-- 
Dipl.-Ing. Daniel Hertrich
Reichertshofen, Germany
http://www.hermocom.com
http://www.daniel-hertrich.de

Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
