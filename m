Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b050909012577fcb19c@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus
In-Reply-To: <1126220839.5286.57.camel@blade>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_179_2491298.1126254316119"
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126220839.5286.57.camel@blade>
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
Date: Fri, 9 Sep 2005 09:25:16 +0100

------=_Part_179_2491298.1126254316119
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>=20
> > 1. Develop a common code addressing all D-Bus versions
>=20
> not needed, because my plan is to drop support for anything below D-Bus
> version 0.5 (which should be compatible with D-Bus 0.3x) starting with
> bluez-utils-0.22. My original plan was to do it in next release, but
> there are some memory leak fixes and I want to get out a new version as
> soon as possible. However maybe it is a good idea to drop support for
> older D-Bus versions now.


I think 0.5 is compatible with >0.35. The current FC4 only uses 0.33 and I=
=20
don't think its compatible with >0.35. I think this is similar for a number=
=20
of the current releases (I think most with gnome 2.10) but obviously isn't=
=20
the case for the development streams that aren't releases yet.

Pete

------=_Part_179_2491298.1126254316119
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; 1. Deve=
lop a common code addressing all D-Bus versions<br><br>not needed, because =
my plan is to drop support for anything below D-Bus
<br>version 0.5 (which should be compatible with D-Bus 0.3x) starting with<=
br>bluez-utils-0.22. My original plan was to do it in next release, but<br>=
there are some memory leak fixes and I want to get out a new version as
<br>soon as possible. However maybe it is a good idea to drop support for<b=
r>older D-Bus versions now.</blockquote><div><br>I think 0.5 is compatible =
with &gt;0.35. The current FC4 only uses&nbsp; 0.33 and I don't think its c=
ompatible with &gt;
0.35. I think this is similar for a number of the current releases (I think=
 most with gnome 2.10) but obviously isn't the case for the development str=
eams that aren't releases yet.<br><br>Pete<br>&nbsp;</div><br></div>

------=_Part_179_2491298.1126254316119--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
