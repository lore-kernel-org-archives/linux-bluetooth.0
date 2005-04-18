Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <d1f423d305041815331d2e6698@mail.gmail.com>
From: Anderson Rodrigues <rodrigues.anderson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Baseband Packets
In-Reply-To: <1113623792.16433.49.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12a241ad050415175936c651a1@mail.gmail.com>
	 <1113623792.16433.49.camel@pegasus>
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
Date: Mon, 18 Apr 2005 18:33:18 -0400

Hi,

The spec says that: "Quality measurements in the receiver of one
device can be used to dynamically control the packet type transmitted
from the remote device for optimization of the data throughput."

The question is, is it done automatically or not? May we assume that
LM is smart enough to measure the RF channel and based on it changes
automatically the packet type ?

If not, is there any point in bluez that we can talk with LM?

Regards,

On 4/15/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Bruno,
>=20
> > now that I know that bluez supports all types of packets,
> > i'm just wondering if it changes the packet type according to the
> > sender/receiver devices supported packets  info, and if it does, if it
> > automatically selects the best packet type according to the
> > enviroment, like in a file transfer, for example, according to the BER
> > or other error factors. (e.g: DH5 when BER < 10^(-5), or DM1 when BER
> > > 10^(-2)).
>=20
> this is the job of the link manager and it is part of the Bluetooth chip
> and not a host stack like BlueZ.
>=20
> Regards
>=20
> Marcel
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
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
