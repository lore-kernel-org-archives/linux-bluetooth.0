Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Catalin Drula <Catalin.Drula@imag.fr>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SOCK_STREAM behaving like SOCK_SEQPACKET?
In-Reply-To: <1100600455.7208.111.camel@pegasus>
Message-ID: <Pine.GSO.4.33.0411161415330.22188-100000@horus.imag.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 16 Nov 2004 14:16:21 +0100 (CET)



On Tue, 16 Nov 2004, Marcel Holtmann wrote:

> Hi Catalin,
>
> > I have a small application that communicates over an L2CAP channel
> > (thus through a SOCK_SEQPACKET socket). The thread that does the
> > L2CAP communication has also some UNIX domain sockets open (AF_UNIX,
> > SOCK_STREAM) through which it communicates to other threads.
> >
> > The trouble is that these latter sockets (UNIX domain, SOCK_STREAM) behave
> > like SOCK_SEQPACKET sockets, in that if I do not need read all the
> > available data at once, it is gone (a second call to read() blocks). As
> > far as I know this is not expected behavior for SOCK_STREAM sockets so I
> > have a couple of possible explanations:
> >
> > 1. Linux kernel bug
> > 2. Bluez bug
> >
> > which causes a SOCK_STREAM socket to act like a SOCK_SEQPACKET.
> >
> > The system is a Fedora Core 2 with kernel 2.6.8-1.521. I have tried the
> > kernel 2.6.9-mh3 now and the problem still occurs.
>
> may you wanna try the AF_UNIX without the L2CAP socket and see if you
> can reproduce it without any Bluetooth involved. If yes, then it is
> definitiv a bug in the AF_UNIX implementation.
>
> Regards
>
> Marcel

I did try that and I could not reproduce it which led me to believe that
it's somehow related to Bluez.

Catalin



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
