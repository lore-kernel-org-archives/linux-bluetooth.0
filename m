Return-Path: <cyrus@holtmann.org>
Message-ID: <8a8adccc0802111316u2333479ds1a125e48f9dfa35e@mail.gmail.com>
Date: Mon, 11 Feb 2008 22:16:49 +0100
From: "Jaap A. Haitsma" <jaap@haitsma.org>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202693988.3491.121.camel@cookie.hadess.net>
MIME-Version: 1.0
References: <8a8adccc0802101428j1eaa6c1by4c452adcda426687@mail.gmail.com>
	<1202693554.7664.138.camel@violet>
	<1202693988.3491.121.camel@cookie.hadess.net>
Subject: Re: [Bluez-devel] [PATCH] Simplify about dialog code
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

On Feb 11, 2008 2:39 AM, Bastien Nocera <hadess@hadess.net> wrote:
>
> On Mon, 2008-02-11 at 02:32 +0100, Marcel Holtmann wrote:
> > Hi Jaap,
> >
> > > Before you're holidays I sent you a patch which simplifies the about
> > > dialog code. We went on discussing it but didn't come to a conclusion,
> > > I think
> >
> > I am not going on holidays. At least not that I know of :)
> >
> > > In my opinion it's a good patch because:
> > >
> > > 1) The patch removes about 20 function calls
> > > 2) You don't need  to hookup signals to the about dialog
> > > 3) Eog, cheese, gnome-power-manager, nautilus, gedit to name a few all
> > > do it this way.
> >
> > Still not convinced.
>
> Using gtk_dialog_run() means that you're running the main loop from the
> about box code. Fixing this would add code. The patch Jaap sent removes
> a lot of code, and avoids things like double-about boxes, or crappy
> backtraces that show the about box callback function :)
>
Marcel,

The patch even fixes bugs. So that should be enough reason to apply it, right?
Otherwise I'm interested in hearing your arguments against it.

Regards,

Jaap

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
