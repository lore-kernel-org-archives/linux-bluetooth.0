Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <460D3FAE.6040901@access-company.com>
Date: Fri, 30 Mar 2007 18:49:50 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45F16630.9000606@access-company.com>	<460D363F.9010709@access-company.com>
	<1175271188.5815.225.camel@violet>
In-Reply-To: <1175271188.5815.225.camel@violet>
Subject: Re: [Bluez-devel] RemoteNameRequested signal during discovery patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello Marcel,

This allows discovery applications to inform user when a device name is bei=
ng retrieved (changing icon or displaying something like "getting name ..."=
 in front =

of the remote device icon). This offers a better user experience because us=
er is informed of discovery process.

Regards

Fred

Marcel Holtmann a =E9crit :
> Hi Frederic,
> =

>> A new version of the patch.
>> Are you okay with it ?
> =

> the patch looks okay to me. However I prefer if Claudio or Johan can
> have an additional look.
> =

> My question is why this signal is actually needed. Please elaborate on
> the use cases of this signal.
> =

> Regards
> =

> Marcel
> =

> =

> =

> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
