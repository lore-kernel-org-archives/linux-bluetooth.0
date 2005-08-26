Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec05082614021caaf9a5@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] help needed with rfcomm
In-Reply-To: <259637e050826135628159aea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <259637e0508241221e7f081b@mail.gmail.com>
	 <1124916916.8019.20.camel@pegasus>
	 <259637e05082506435fb9a5fc@mail.gmail.com>
	 <1124980168.8019.31.camel@pegasus>
	 <259637e0508260635526d51f6@mail.gmail.com>
	 <259637e050826135628159aea@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Aug 2005 17:02:31 -0400

use select() or poll()

See here for an introduction:=20
http://www.ecst.csuchico.edu/~beej/guide/net/html/

-albert

On 8/26/05, Rui Silva <rukinhas@gmail.com> wrote:
> is there as way to set a timetout to a socket??
> what i mean is, if the socket does not read anything for certain time, th=
e read
> operation would unlock and the execution of the program continues. is
> there a way to
> accomplish this??
>=20
> --
> Rui Silva
> Powered by Gentoo Linux under :
> CELERON 1000 - Stage1 install with nptl
> Pentium M 1800GHz - Stage1 install with NPTL
>=20
> http://rukinhas.no-ip.org
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
