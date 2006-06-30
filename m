Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44A501D7.3070306@infitsrl.com>
Date: Fri, 30 Jun 2006 12:49:59 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44A4E5A4.5070904@infitsrl.com>	<1151657604.20305.9.camel@localhost>	<44A4E987.1000104@infitsrl.com>
	<1151658731.20305.11.camel@localhost>	<Pine.LNX.4.63.0606301142130.18028@redbean.intranet.gw-instruments.de>	<44A4FB83.8090001@infitsrl.com>
	<Pine.LNX.4.63.0606301236091.18028@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0606301236091.18028@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] sdp_connect thread safe?
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

Ok ....the last question otherwise risk to be insulted ;-)

sdp_connect block for long time (also without SDP_RETRY_IF_BUSY flag), =

is there a ioctl on the
l2cap socket or a command to reduce this time?

Ciao
Fabrizio

Peter Wippich ha scritto:
> Hi Fabrizio, =

>
> On Fri, 30 Jun 2006, Fabrizio Guglielmino wrote:
>
>   =

>> To obtain the rfcomm channel associated to a service (opush in my case) =

>> sd_connect and the response inspection it's the only way?
>>     =

> Yes !
>
> Ciao, =

>
> Peter =

>
> |       Peter Wippich                   Voice: +49 30 46776411          |
> |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> |       D-13355 Berlin  / Germany                                       |
>
>
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job ea=
sier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>   =



-- =

______________________________
Fabrizio Guglielmino =

Infit Srl
Software Engineering
Tel. +39 11 7410915
Fax. +39 11 7410915
www.infitsrl.com
C.so Svizzera, 79/8 - Torino
______________________________

Il presente messaggio ed ogni eventuale allegato hanno natura
confidenziale e sono riservati ai destinatari indicati. La diffusione a
terzi e qualsiasi altro uso non autorizzato sono proibiti. I messaggi ed
i relativi allegati possono essere soggetti ad alterazioni. Il mittente
declina ogni responsabilit=E0 per le eventuali alterazioni, modificazioni
o falsificazioni.


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
