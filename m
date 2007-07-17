Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 17 Jul 2007 23:12:53 +0300
From: Mikko Rapeli <mikko.rapeli@iki.fi>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070717201253.GH1376@nalle>
References: <20070717191609.GG1376@nalle>
	<1184702133.28210.38.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
In-Reply-To: <1184702133.28210.38.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] apply rfcomm oops fix?
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

On Tue, Jul 17, 2007 at 09:55:33PM +0200, Marcel Holtmann wrote:
> Hi Mikko,
> 
> > This bugzilla entry http://bugzilla.kernel.org/show_bug.cgi?id=7509 has
> > been open for a while and my fix proposal this. I think it makes sence
> > for rfcomm socket ioctl, which releases the device, to gracefully
> > (tty_v)hangup the tty layer too. Could this be applied or is there some
> > problem with this one liner?
> 
> check the upstream kernel source. Your patch has already been applied.

Eh, I did and saw a latest patch to net/bluetooth dated in May, but now
a browser reload shows the latest changes made in July. Must be a
gitweb thing...

-Mikko

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
