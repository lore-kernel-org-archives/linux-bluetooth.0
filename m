Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Nokia 770 and bluetooth audio
From: Victor Shchebatyuk <victor@win.tue.nl>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1128849280.15821.7.camel@blade>
References: <4346F84D.8050004@xmission.com> <1128774836.5212.4.camel@blade>
	 <4348AF2B.4030301@xmission.com>  <1128849280.15821.7.camel@blade>
Content-Type: text/plain
Message-Id: <1128860708.8700.12.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Sun, 09 Oct 2005 14:25:08 +0200

Hi all,

It would be nice to have at least a piece of advise from those
mysterious people who tell all those things about the optimization :)

I belive that 32-bit is enough (I saw it working in some other
implementations with excellent sound quality), but it shouldn't be done
in the straight forward way as it is done now. I'm going to look at it
in the nearest future anyway...

I've looked only at the filter-bank code, what is outside probably can
me improved...

Regards,
    Victor.

On Sun, 2005-10-09 at 11:14 +0200, Marcel Holtmann wrote:
> Hi Brad,
> 
> > > if I am not mistaken, then the integration into GStreamer will solve all
> > > the problems. However we need a good SBC encoder for this first. May you
> > > wanna give an update on its current status.
> > 
> > Victor's changes to our encoder give reasonable performance on arm (<10% 
> > of cpu on an arm9 400mhz I think). It uses 64-bit integer math and we 
> > expect there is room for even more optimization using a lossier 32-bit 
> > version (the 32-bit stuff is stubbed out but disabled for now since it's 
> > incomplete)
> 
> from what other people told me about SBC, a 32-bit version will be
> enough for good quality audio.
> 
> > In addition to switching to integer ops, Victor unrolled loops and 
> > reworked some of the tables so less stuff has to be computed at runtime.
> 
> I also heard that there are a lot of possible optimizations, because the
> example code in the specification sucks totally.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
