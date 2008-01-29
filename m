Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1201630090.2389.132.camel@cookie.hadess.net>
References: <1201227720.2389.17.camel@cookie.hadess.net>
	<1201626119.6218.15.camel@violet>
	<1201627446.2389.121.camel@cookie.hadess.net>
	<1201628148.6218.23.camel@violet>
	<1201630090.2389.132.camel@cookie.hadess.net>
Date: Tue, 29 Jan 2008 19:14:00 +0100
Message-Id: <1201630440.6218.31.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] client.c cleanup
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

> > > I think for most of those it would mean clearing the children of the
> > > adapters (removing them from the tree). Not sure what's wrong about the
> > > bdaddr not appearing for newly inserted devices though, probably just a
> > > missing call.
> > 
> > that is a bug or missing signal. Keeping the adapter allows us to keep
> > the D-Bus proxy object and will prevent from duplicate signals. Removing
> > the adapter would mean to also remove the signal handles etc. Seemed why
> > to ugly for me.
> 
> I'm talking about removing the children (ie. the devices), not the
> adapter itself. Which makes sense, as they shouldn't be associated with
> a non-existant adapter.

we can do that. Makes sense to me. Purge all children on adapter
removal.

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
