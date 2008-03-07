Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Mar 2008 16:06:55 +0100
From: Stefan Seyfried <seife@suse.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080307150655.GB11011@suse.de>
References: <47D03C82.9060009@suse.de>
	<1204899369.28006.2.camel@californication>
MIME-Version: 1.0
In-Reply-To: <1204899369.28006.2.camel@californication>
Subject: Re: [Bluez-devel] [patch]  make apitest more useful
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

Hi Marcel,

On Fri, Mar 07, 2008 at 03:16:09PM +0100, Marcel Holtmann wrote:

> the apitest is really only a test program,

I know :-)
It is still useful to hand out to people for debugging their setup.
As it is much more low level than bluez-gnome and kdebluetooth, it
is easier to tell a bug reporter *exactly* what to do with apitest
than with the grapical tools. That's why i bothered fixing that issue.

> but I applied the patch neverless.

Thanks. It now actually allows to test "DiscoverDevices" which is much
more useful, even as testing tool only ;-)
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
