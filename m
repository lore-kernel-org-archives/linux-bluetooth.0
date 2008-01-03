Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 3 Jan 2008 09:07:02 +0800
Message-ID: <E21A90CDB9591542899EFC7FB4ED5CC90776A695@tfmail02.TFMAIL.COM>
In-Reply-To: <d89ddf300801021040o28e16943t2c51ac0190bd4e91@mail.gmail.com>
From: "guoyun" <guoyun@techfaith.cn>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] slave - slave talk in a piconet
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1707231664=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1707231664==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi, Brad
=20
> hey
>=20
> > If there is a piconet that has 2 slave B,C, the master is A. Does B=20
> > know the existence of C? can B talk to C directly without=20
> A(master)'s intervention?
>=20
> if they did talk to each other directly, one would have to be=20
> master and you'd have a scatternet.

one bluetooth could be in two or more piconet, but it just can play as =
slave _not_ master for the bluetooth clock.

Please refer to Core SPEC. chapter 4.1. Piconet topology.

BRs
Yun


--===============1707231664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1707231664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1707231664==--
