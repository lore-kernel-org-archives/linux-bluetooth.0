Return-Path: <cyrus@holtmann.org>
From: Guillaume Bedot <littletux@zarb.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <4795D6EB.2080209@naustech.com>
References: <4795D6EB.2080209@naustech.com>
Date: Tue, 22 Jan 2008 17:14:31 +0100
Message-Id: <1201018471.24085.4.camel@littletux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Headset half working using Bluez's ALSA plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello,

On mar, 2008-01-22 at 12:43 +0100, Ing. Gabriele Oberhammer wrote:
> What information can I post to help solving this problem?
> Can someone point me to an howto or README with best practices for 
> installing from cvs?

I guess you need the cvs version indeed.
Try in the utils directory:
$ ./configure --help
to see all options available.

( --enable-audio or --enable-all may be ok)

You would need of lot of headers installed too (packages usually named
libsomething-dev  or -devel).

Then the services should be installed...

Regards,

Guillaume B.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
