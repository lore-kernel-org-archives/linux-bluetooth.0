Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <422BA06E.6020700@debiancolombia.org>
From: "Fredy P." <digitalfredy@debiancolombia.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] DBT-120 and Siemens S65
References: <6ae1569005030604105d08a56e@mail.gmail.com>
In-Reply-To: <6ae1569005030604105d08a56e@mail.gmail.com>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
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
Date: Sun, 06 Mar 2005 19:29:34 -0500

Adis Beglerovic escribi=F3:
> Hi
> Trying to connect my mobile phone and PC using blue tooth.
>=20
> 1.Added needed stuff in my kernel 2.6.11 on gentoo box.
> When I plug inn my Dlink DBT-120 lights are ON and hcitools scan report=
s
> this:
> Scanning ...
>        00:01:E3:3C:79:45       Bash
> where bash is my mobile phone.
> and link quality is -->hcitool lq 00:01:E3:3C:79:45
> Link quality: 255
>=20
> Does this means that blue tooth works?
> 2.How do I connect to devices?
> 3. What tools can use for file transfer ?

see this link [http://el-directorio.org/index.php?title=3DT610:Transferen=
cia_de_Archivos] (is in=20
spanish but can help you) and you can compare your hcid.conf whit it:

options {
         autoinit yes;
         security auto;
         pairing multi;
         pin_helper /usr/bin/bluez-pin;
}
device {
         name "%h-%d";
         class 0x100;
         iscan enable;
         pscan enable;
         lm accept;
         lp rswitch,hold,sniff,park;
         #encrypt enable;
}






> Thanks
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users=
.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20


--=20
Suerte and F.S.Fv.

ATT: Fredy P.
___________________________________________________
F.S.Fv. es acr=F3nimo de Free Software Forever
http://www.fsf.org/philosophy/free-sw.es.html

Normas b=E1sicas de comportamiento en el ciberespacio
http://www.netiqueta.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
