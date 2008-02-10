Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202608952.7664.35.camel@violet>
References: <1201887887.2389.346.camel@cookie.hadess.net>
	<1202305613.3491.36.camel@cookie.hadess.net>
	<1202346828.3491.47.camel@cookie.hadess.net>
	<1202606464.7664.27.camel@violet>  <1202608952.7664.35.camel@violet>
Date: Sun, 10 Feb 2008 05:00:42 +0100
Message-Id: <1202616043.7664.44.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Split agents
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

Hi Bastien,

> > > > > First draft patch to split the agents away from the main program. Seems
> > > > > to work fine for me.
> > > > > 
> > > > > This is mostly moving functions around though.
> > > > 
> > > > Updated patch following the comments from Marcel.
> > > 
> > > Patch that compiles again.
> > 
> > I like the split of the notifications. Can we do that first in a
> > separate patch. Looks simple enough and makes the history a lot cleaner
> > compared to a big one.
> 
> actually just did it by myself. Care to update the split agents patch.

and did the agent split by myself, too. Ended up in bluez-gnome-0.18
release. Please test :)

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
