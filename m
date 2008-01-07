Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2bab7e280801070449h3786dc47jb7811016f71af8e@mail.gmail.com>
References: <2bab7e280801061151s221838ccy9913e62ad4480706@mail.gmail.com>
	<1199706716.6584.4.camel@cookie.hadess.net>
	<2bab7e280801070449h3786dc47jb7811016f71af8e@mail.gmail.com>
Date: Mon, 07 Jan 2008 13:06:39 +0000
Message-Id: <1199711199.6584.13.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] PS3 BD remote
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


On Mon, 2008-01-07 at 13:49 +0100, M=F4she Van der Sterre wrote:
> > See the patch(es) sent by Aristeu on the list:
> > http://thread.gmane.org/gmane.linux.bluez.devel/13793
> > http://thread.gmane.org/gmane.linux.bluez.devel/13794
> > http://thread.gmane.org/gmane.linux.bluez.devel/13795
> > http://thread.gmane.org/gmane.linux.bluez.devel/13796
> > http://thread.gmane.org/gmane.linux.bluez.devel/13797
> >
> > Cheers
> =

> Great, This seems to be send to the list some time after I asked about
> it on IRC, and it seems to be a complete implementation of the remote.

Aristeu sent a patch weeks before that was the first draft
implementation, but we got key definitions added to the kernel to
support all the keys properly. See the archives.

> The only thing I don't see is support for multiple keys pressed (only
> the 'playstaton' keys support this), I'll try to test this code this
> week.

I don't understand what you mean by multiple key presses there.

> Also, some keys are bound really weird (cross to KEY_ENTER while the
> enter key already is KEY_ENTER? how does the sixaxis do this?).

I don't understand the problem here either...

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
