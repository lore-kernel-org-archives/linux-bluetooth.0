Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <a96155200711181327tce91b18w5bd842ee88611db4@mail.gmail.com>
References: <a96155200711150615q38dcf09g140d2386830e9e23@mail.gmail.com>
	<a96155200711181327tce91b18w5bd842ee88611db4@mail.gmail.com>
Date: Mon, 26 Nov 2007 10:14:50 +0100
Message-Id: <1196068490.4217.101.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] select(2) or read(2) on bluetooth sockets
	not	working correctly?
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

Hi Pawel,

> I have put simple program demonstrating the problem at
> http://tfuj.pl/gnokii/bt.c with compilation hints and usage.
> The testing I did was on Ubuntu kernels, so that's for sure not the
> recent one, but I think it is really easy to reproduce if the problem
> still persists.

this from the select() manual page:

Those listed in readfds will be watched to see if characters  become
available  for reading  (more  precisely, to see if a read will not
block; in particular, a file descriptor is also ready on end-of-file)

If a device disconnects or gets out of range, it is considered to be an
end of file situation. It might help to also watch the exceptfds for the
hangup signal. The read() should return an error if the connection has
been terminated. So that part is strange.

It means that if you connect, then poweroff and then call read() you
would see the same effect. The read() command will block. Can you
confirm this?

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
