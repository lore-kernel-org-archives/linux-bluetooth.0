Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4174DA39.5090206@c-s.fr>
From: "GUILLON Gabriel" <gabriel.guillon@c-s.fr>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Piconet Routing
References: <4173F86A.3050801@uni-paderborn.de>
In-Reply-To: <4173F86A.3050801@uni-paderborn.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 19 Oct 2004 11:11:21 +0200

Take a look at btchat: it does routing through bluetooth

Stefan Mischke a =E9crit :
> Hello!
>=20
> Since Bluetooth uses Time Division Duplex, a slave is not allowed to=20
> talk to another slave in the same Piconet. The logical consequence must=
=20
> be that the data is routed over the master. I've used l2test to check i=
f=20
> l2cap does this kind of routing automatically. It doesn't but rather=20
> creates a new, direct acl link to the remote slave device (scatternet).=
=20
> I don't know how it is with rfcomm, but I suppose it's the same. My=20
> question: Is there any automatic Piconet Routing inside BlueZ or does=20
> one have to implement it by oneself?
>=20
> Regards
> Stefan
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJourna=
l
> Use IT products in your business? Tell us what you think of them. Give =
us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out =
more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20

--=20
"Everything is funny, if you wait long enough"

Gab

Dieu, dans sa grande cl=E9mence, a invent=E9 l'alcool pour que les moches
aussi puissent baiser.
- Woody Allen -


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
