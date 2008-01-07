Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 Jan 2008 10:03:45 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080107150345.GC6027@cathedrallabs.org>
References: <2bab7e280801061151s221838ccy9913e62ad4480706@mail.gmail.com>
	<1199706716.6584.4.camel@cookie.hadess.net>
	<2bab7e280801070449h3786dc47jb7811016f71af8e@mail.gmail.com>
	<1199711199.6584.13.camel@cookie.hadess.net>
	<2bab7e280801070640s76089762v208061db0fce57f7@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <2bab7e280801070640s76089762v208061db0fce57f7@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

> > I don't understand what you mean by multiple key presses there.
> When you press triangle and left together, this can be recognised, but
> only for the playstation (middle) keys.
it's not supported. does your application recognize both keys being
pressed at same time? I noticed that ps key + other keys generates a
different code but I didn't implemented support for that.

> > > Also, some keys are bound really weird (cross to KEY_ENTER while the
> > > enter key already is KEY_ENTER? how does the sixaxis do this?).
> >
> > I don't understand the problem here either...
> The way I see it, the enter and cross keys are really different keys,
> but maybe there is some reason for this?
where did you find that the cross button is mapped to KEY_ENTER?

-- 
Aristeu


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
