Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45094871.7010003@infitsrl.com>
Date: Thu, 14 Sep 2006 14:17:53 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>	<Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>	<450940DC.5080809@infitsrl.com>
	<Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] About concurrency sdp_connect
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

Hi Peter,
I'm not expert in bluez kernel driver programming but I've developed an =

application using socket abstraction
on Windows (microsoft stack) and I can connect simultaneously to many =

devices (7 max) with the same usb dongled
tested with bluez on linux. So I think it can't be a hardware problem, =

or better may be the hardware limitation but I think it's bypassable
in software layers.

bye
Fabrizio

Peter Wippich ha scritto:
> Hi Fabrizio,
>
> On Thu, 14 Sep 2006, Fabrizio Guglielmino wrote:
>
>   =

>> Are You sure it's hardware restriction?
>> sdp_connect internally use the socket abstaction to create a l2cap =

>> socket and make a
>> connection with standard connect.
>> In old threads there is a discussion about actual software limitation of =

>> l2cap layer to make simultaneous
>> connection so I think the problem in sdp_connect is the same..... =

>> bye
>>     =

>
> Well, maybe you did not went back far enough. The real problem is that =

> (all ?) Bluetooth hardware devices do not allow a second connect request =

> while another connect request is pending. I remember there was some =

> discussion to solve this in the l2cap layer by serializing connect =

> requests or reacting to the hardware responses proberly (retrying the =

> request when the hardware responds with command disallowed or similar to =

> the connect request). However, I don't know the current state . Get lost =

> somewhere .... =

>
> Ciao, =

> Peter  =

>
>
>
> |       Peter Wippich                   Voice: +49 30 46776411          |
> |       G&W Instruments GmbH            fax:   +49 30 46776419          |
> |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
> |       D-13355 Berlin  / Germany                                       |
>
>
> -------------------------------------------------------------------------
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


-------------------------------------------------------------------------
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
