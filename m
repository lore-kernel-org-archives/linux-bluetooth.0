Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05082904093881552a@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluez PAN (bnep) Supports IP Multicast ?
In-Reply-To: <1125308614.25073.8.camel@blade>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4dfd570904122402134ec2fd32@mail.gmail.com>
	 <BAY104-F28B10D34C6CA29EC4D37E9C1A70@phx.gbl>
	 <4dfd5709041225041648e1f356@mail.gmail.com>
	 <1103980205.8758.22.camel@pegasus>
	 <4dfd570904122505192221bf97@mail.gmail.com>
	 <001201c5ac65$73bba980$0107a8c0@heejune>
	 <1125308614.25073.8.camel@blade>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 29 Aug 2005 08:09:42 -0300

I am not sure if it can help you, but try the following command:

ifconfig bnep0 allmulti multicast
route add -net 239.0.0.0 netmask 255.0.0.0 bnep0

Maybe you have to replace the bnep0 by your bridge interface(pan0).

Regards,
Claudio.




On 8/29/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Heejune,
>=20
> > I am integrating UPNP Program on Bluez (REDHAT 9.0).
> > As you may know, UpnP uses IP multicast for M-SERACH, NOTIFY function.
> > I successfully setup PAN Profile GN, and it is confirmed by "ping".
> >
> > However, when  I try to setoption my socket to multicast, it is got err=
ored!!!!!!!!!!!!!!!!!!!!!!!!!!!
> > res =3D setsockopt(ssdpSock, IPPROTO_IP, IP_ADD_MEMBERSHIP,  (char *) &=
ssdpMcastAddr, sizeof(struct ipmreq)));
> > we got "res  <0" ^^;;;
> > From bluetooth spec, the default behavior is no filtering, i.e, any mul=
ticast packet should be broadcasted to all PANU.
> > What should I do for making my program use  multicast IP address??? IS =
it possible in BLUEZ?
> >
> > I am using REDHAT 9.0 and bluezlib-2.13 and bluexutil-2.13
>=20
> why don't you start using a 2.6 kernel and the latest bluez-libs and
> bluez-utils? Your versions are outdated.
>=20
> Regards
>=20
> Marcel
>=20
>=20
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
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
