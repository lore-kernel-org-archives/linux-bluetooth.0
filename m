Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Jul 2006 18:47:06 +0200
From: "Marcus C. Gottwald" <gottwald@inf.fu-berlin.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20060714164706.GB25533@inf.fu-berlin.de>
References: <20060714161657.GA25533@inf.fu-berlin.de>
	<1152894175.25660.35.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152894175.25660.35.camel@localhost>
Subject: Re: [Bluez-users] SCO mapping, bccmd mapsco
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


Hello,

Marcel wrote (Fri 2006-Jul-14 18:22:55 +0200):

> >   coach:~# bccmd psset mapsco 0
> >   coach:~# bccmd psget mapsco
> >   Map SCO over PCM: 0x0001 (1)
> >   coach:~# bccmd psset mapsco 1
> >   coach:~# bccmd psget mapsco
> >   Map SCO over PCM: 0x0001 (1)
> =

> use "bccmd psset --stores psf mapsco 0".

Wow, that was quick. But using "--stores psf" doesn't seem to
help; and even the hciconfig output remains unchanged:

  coach:~# hciconfig hci0 revision
  hci0:   Type: USB
          BD Address: 08:00:46:EB:0E:B6 ACL MTU: 192:8 SCO MTU: 64:8
          HCI 18.1
          Chip version: BlueCore02-External
          Max key size: 56 bit
          SCO mapping:  PCM
  coach:~# bccmd psset --stores psf mapsco 0
  coach:~# bccmd psget mapsco
  Map SCO over PCM: 0x0001 (1)
  coach:~# hciconfig hci0 revision
  hci0:   Type: USB
          BD Address: 08:00:46:EB:0E:B6 ACL MTU: 192:8 SCO MTU: 64:8
          HCI 18.1
          Chip version: BlueCore02-External
          Max key size: 56 bit
          SCO mapping:  PCM

I'll be happy to try anything else. :-)


Cheers, Marcus

-- =

   Marcus C. Gottwald  =B7  http://www.inf.fu-berlin.de/~gottwald/



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
