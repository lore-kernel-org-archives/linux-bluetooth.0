Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300801281928t52a561bdye4f72bdb0e5dd1d7@mail.gmail.com>
Date: Mon, 28 Jan 2008 20:28:31 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300801261924t311981depb26f0c90f4bbaed9@mail.gmail.com>
MIME-Version: 1.0
References: <d89ddf300801261924t311981depb26f0c90f4bbaed9@mail.gmail.com>
Subject: Re: [Bluez-devel] gstreamer regressions
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

Hey

This isn't really a problem in the gstreamer plugin at all. It
appeared with a gstreamer change in cvs but that was linked to
changing a default encoding parameter. The real issue is our decoder
is overflowing for higher bitpool values. It shows up sooner for 4
subbands and/or mono.

The encoder seems to all be fine but I'll need help straightening this
out. There's no way we can get decent regression testing if our
decoder falls apart.

On Jan 26, 2008 8:24 PM, Brad Midgley <bmidgley@gmail.com> wrote:
> I wrote it up in the wiki (http://wiki.bluez.org/wiki/SBC)

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
