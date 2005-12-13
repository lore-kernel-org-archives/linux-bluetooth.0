Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Cant send bluetooth using my linux and bluez
From: Fredy P <digitalfredy@debiancolombia.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051207061807.73581.qmail@web50510.mail.yahoo.com>
References: <20051207061807.73581.qmail@web50510.mail.yahoo.com>
Content-Type: text/plain;
	charset=UTF-8
Message-Id: <1134461983.10555.47.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Tue, 13 Dec 2005 03:19:41 -0500

El mar, 06-12-2005 a las 22:18 -0800, oj ravadilla escribi=C3=B3:
> Hi,
>=20
> I can not send bluetooth from my phone to my pc. I'm
> using linux kernel 2.6.0 and bluez-lib 2.22 and
> bluez-utils2.22. Can someone look at what's wrong...
>=20
For recive files you can use obexserver [1] or opd [2] more information
about how to use it in [3]

[1]http://www.frasunek.com/sources/unix/obexserver.c=20
[2]http://oss.bdit.de/opd.html
[3]http://es.wikibooks.org/wiki/Hacks_para_Bluetooth_en_Linux

> hcidump:
>=20
>  # hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.23
> device: hci0 snap_len: 1028 filter: 0xffffffff
> hci_acldata_packet: hci0 ACL packet for unknown
> connection handle 41
> > ACL data: handle 41 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0048
>=20
>=20
> thanks!
>=20
>=20
>=20
> 	=09
> __________________________________________=20
> Yahoo! DSL =E2=80=93 Something to write home about.=20
> Just $16.99/mo. or less.=20
> dsl.yahoo.com=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
