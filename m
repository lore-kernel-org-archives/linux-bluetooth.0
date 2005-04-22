Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec05042123566efacaad@mail.gmail.com>
From: Albert Huang <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Documentation for development
In-Reply-To: <200504201931.06626.alan@mizrahi.com.ve>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200504192237.53314.alan-bluez@mizrahi.com.ve>
	 <1113989398.2469.95.camel@pegasus>
	 <200504201931.06626.alan@mizrahi.com.ve>
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
Date: Fri, 22 Apr 2005 02:56:02 -0400

If all you want is simple communication, then you may want to look at
the various JSR-82 implementations that are written for Linux.
rococosoft impronto, avetana, and javabluetooth.org are three
implementations you could try.

If you like python, you might be interested in pybluez

>From what you're describing, it's unlikely that you actually need to
code in C.  However, if you insist on doing so, you're not going to
find official documentation or APIs.  I've written some introductory
material that you might find helpful.

http://csail.mit.edu/~albert/misc/chap4.pdf

It's a work in progress, and I welcome feedback.

Regards,
Albert

On 4/20/05, Alan Mizrahi <alan@mizrahi.com.ve> wrote:
> El Wed 20 Apr 2005 5:29 am, Marcel Holtmann escribi=F3:
> > Hi Alan,
> >
> > > I want to make a program that communicates with my cellphone through
> > > bluetooth.
> > >
> > > I already installed and configured the bluez packages, but I can't fi=
nd
> > > the developers documentation, can anybody point me to the right place=
?
> >
> > the question is what kind of communication do you mean?
> >
>=20
> Just basic synchronous communication.  I don't intend to transfer files, =
my
> project is to be able to control a program from the cellphone (something =
like
> RPC).  Maybe the cellphone will get some feedback from the commands too.
>=20
> The cellphone program will be written in java-midp and the computer part =
in C.
>=20
> So what do you suggest?
> Is there any documentation I can read about bluetooth development?
>=20
> Regards,
>=20
> Alan
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: New Crystal Reports XI.
> Version 11 adds new functionality designed to reduce time involved in
> creating, integrating, and deploying reporting solutions. Free runtime in=
fo,
> new features, or free trial, at: http://www.businessobjects.com/devxi/728
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
