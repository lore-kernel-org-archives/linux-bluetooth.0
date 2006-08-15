Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 15 Aug 2006 16:42:04 -0500
From: digitalfredy <digitalfredy@debiancolombia.org>
In-reply-to: <44E237D5.50202@zubrowka.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-id: <1155678126.9855.32.camel@YODA>
MIME-version: 1.0
References: <44E237D5.50202@zubrowka.org>
Subject: Re: [Bluez-users] Problem transferring file to a Sony
	T630	cellular	phone
Reply-To: digitalfredy@debiancolombia.org,
        BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello, review this link
http://es.wikibooks.org/wiki/Hacks_para_sistemas_operativos_Unix-like/Redes=
/Bluetooth/Linux

and try use the obexftp from debian repository, some time ago i use
ubuntu but the obexftp of ubuntu don't work

El mar, 15-08-2006 a las 23:08 +0200, Emmanuel Lesouef escribi=F3:
> Hello bluez-users list,
> =

> I'm currently trying to setup the communication between my laptop and my
> cell phone (Sony Ericsson T630)
> =

> elesouef@lothlorien:~$ hcitool scan
> Scanning ...
>         00:0F:DE:CB:D4:04       Manu-T630
> elesouef@lothlorien:~$ sdptool browse 00:0F:DE:CB:D4:04 |grep "Service Na=
me"
> Service Name: Dial-up Networking
> Service Name: Voice gateway
> Service Name: Serial Port 1
> Service Name: Serial Port 2
> Service Name: OBEX Object Push
> Service Name: IrMC Synchronization
> Service Name: HF Voice gateway
> Service Name: OBEX Basic Imaging
> Service Name: OBEX File Transfer
> =

> Everything seems to be OK for now.
> =

> I tried the simple way (gnome-bluetooth, "Send file to..." etc...) but
> that didn't work and I didn't saw any messages on the cellular.
> =

> I then tried obexftp :
> =

> elesouef@lothlorien:~$ obexftp -b -l
> Scanning ...
> Using   00:0F:DE:CB:D4:04       Manu-T630
> Failed to connect to SDP server: Operation already in progress
> =

> I suppose there's something wrong in my setup.
> =

> Anyone got an idea ?
> =

> TIA
> =

> Emmanuel
> =

> PS : Using Ubuntu 6.06 :
> =

> elesouef@lothlorien:~$ dpkg -l \*bluez\* |grep ii
> ii  bluez-cups           2.24-0ubuntu6  Bluetooth printer driver for CUPS
> ii  bluez-pcmcia-support 2.24-0ubuntu6  PCMCIA support files for BlueZ
> 2.0 Bluetooth
> ii  bluez-pin            0.25-1ubuntu2  Bluetooth PIN helper with D-BUS
> support
> ii  bluez-utils          2.24-0ubuntu6  Bluetooth tools and daemons
> =

> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

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
