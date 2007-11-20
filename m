Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 20 Nov 2007 11:16:12 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: Robert Winder <robertwinder@casema.nl>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20071120161611.GA22301@cathedrallabs.org>
References: <1277734668.20071120170636@casema.nl>
MIME-Version: 1.0
In-Reply-To: <1277734668.20071120170636@casema.nl>
Subject: Re: [Bluez-devel] fakeinput for PS3 sixaxis
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

Hi Robert,
> Maybe it have been lost in the chatter but Aristeu Sergio Rozanski
> Filho did send in a fakeinput patch for the Playstation 3 sixaxis
> controller a month ago.
actually, the sixaxis controller already works. the patches I've
submitted are for supporting the blu-ray remote.

> see http://sourceforge.net/mailarchive/message.php?msg_id=20071007184035.GA7430%40cathedrallabs.org
> 
> I don't see the patch in cvs so maybe it got stalled somewhere. Maybe
> someone can consider this patch again for inclusion. Can't ask
> Aristeau for a resend directly because i just subscribed and thus
> haven't got his email address to ask for a resend.
I've submitted as RFC and I'm still working with Dmitry to get the new
needed key definitions in kernel first so the key map is correct to
resubmit the patch set. I didn't got any comment about the other aspects
of the patches, so I assume they're ok (or completely wrong :P)

> As I understand it the ps3 sixaxis controller has to be defined as
> fakeinput otherwise it won't connect.
AFAIK, the sixaxis only needs a special initialization before it can be
registered as HID device. I didn't tried it, but it looks like that
reading the code.

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
