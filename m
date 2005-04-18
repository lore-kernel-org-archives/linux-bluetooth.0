Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <d1f423d30504181634cdd0a46@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Baseband Packets
In-Reply-To: <1113864236.16233.148.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12a241ad050415175936c651a1@mail.gmail.com>
	 <1113623792.16433.49.camel@pegasus>
	 <d1f423d305041815331d2e6698@mail.gmail.com>
	 <1113864236.16233.148.camel@pegasus>
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
Date: Mon, 18 Apr 2005 19:34:49 -0400

Marcel,

I understand your arguments. But is It possible to interact with the
LM by software? I mean, send PDUs ... Probably you have faced many
many problems in order to build Bluez, and probably you have gained a
huge experience and even you dont intend to implement it you have an
idea of how i could start of doing it for academic porposes. Any help
would be very welcome.

all the best,

On 4/18/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Anderson,
>=20
> > The spec says that: "Quality measurements in the receiver of one
> > device can be used to dynamically control the packet type transmitted
> > from the remote device for optimization of the data throughput."
> >
> > The question is, is it done automatically or not? May we assume that
> > LM is smart enough to measure the RF channel and based on it changes
> > automatically the packet type ?
>=20
> the link manager should be smart enough, but choosing the right packet
> type is a science by itself.
>=20
> > If not, is there any point in bluez that we can talk with LM?
>=20
> We can only limit available packet types, but this makes no sense at all
> and should never be done.
>=20
> Regards
>=20
> Marcel
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
>=20


--=20
Anderson Clayton B. Rodrigues
Eng. de Software
Instituto Nokia de Tecnologia - INdT


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
