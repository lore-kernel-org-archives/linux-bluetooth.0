Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20071120161611.GA22301@cathedrallabs.org>
References: <1277734668.20071120170636@casema.nl>
	<20071120161611.GA22301@cathedrallabs.org>
Date: Tue, 20 Nov 2007 16:26:03 +0000
Message-Id: <1195575963.10878.208.camel@cookie.hadess.net>
Mime-Version: 1.0
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


On Tue, 2007-11-20 at 11:16 -0500, Aristeu Rozanski wrote:
> Hi Robert,
> > Maybe it have been lost in the chatter but Aristeu Sergio Rozanski
> > Filho did send in a fakeinput patch for the Playstation 3 sixaxis
> > controller a month ago.
> actually, the sixaxis controller already works. the patches I've
> submitted are for supporting the blu-ray remote.

The Sixaxis only works with the old hidd, it doesn't with the new input
service though, as the input service expects to be able to connect to
the device to get its info.

See my attempts at fixing that in the archives.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
