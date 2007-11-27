Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <5c1c70820711271426ga2b58aasc7c721d2e30b4aa4@mail.gmail.com>
Date: Wed, 28 Nov 2007 08:56:58 +1030
From: "Pooyan McSporran" <duckfreezone@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e1effdeb0711270618w5e1b6fck4ce0484ea124a155@mail.gmail.com>
MIME-Version: 1.0
References: <5c1c70820711141825g6c9e27ecm51c00272bad6d7fd@mail.gmail.com>
	<e1effdeb0711270618w5e1b6fck4ce0484ea124a155@mail.gmail.com>
Subject: Re: [Bluez-devel] Serial server problems
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

On 28/11/2007, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
> The address is wrong. Here are some examples:
> TTY proxy: "/dev/ttyS0"
> Unix socket: "/tmp/gps-data"
> Unix socket(abstract namespace): "x00/org/bluez/echo"
>
> I will try update the BlueZ wiki with some unix socket proxy examples.

Thanks, I'd appreciate that.

For now I'm using DBus to do everything else (eg setting the name of
the adapter, making it visible, advertising the service via SDP, etc),
but using sockets for the serial aspects, but in the longer term I'd
like to use DBus for everything, so that wiki information would be
helpful.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
