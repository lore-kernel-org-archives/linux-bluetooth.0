Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <a96155200711181327tce91b18w5bd842ee88611db4@mail.gmail.com>
Date: Sun, 18 Nov 2007 22:27:52 +0100
From: "Pawel Kot" <gnokii@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <a96155200711150615q38dcf09g140d2386830e9e23@mail.gmail.com>
MIME-Version: 1.0
References: <a96155200711150615q38dcf09g140d2386830e9e23@mail.gmail.com>
Subject: Re: [Bluez-devel] select(2) or read(2) on bluetooth sockets not
	working correctly?
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

Hi,

I have put simple program demonstrating the problem at
http://tfuj.pl/gnokii/bt.c with compilation hints and usage.
The testing I did was on Ubuntu kernels, so that's for sure not the
recent one, but I think it is really easy to reproduce if the problem
still persists.

You may catch me on #bluez if needed.

take care,
pkot
PS. I'm really not subscribed, so please Cc on reply.
-- 
Pawel Kot

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
