Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <450A7871.2060608@infitsrl.com>
Date: Fri, 15 Sep 2006 11:54:57 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>	<Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>	<450940DC.5080809@infitsrl.com>	<Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>	<45094871.7010003@infitsrl.com>	<Pine.LNX.4.63.0609141423350.22339@redbean.intranet.gw-instruments.de>
	<1158313465.5233.3.camel@localhost>
In-Reply-To: <1158313465.5233.3.camel@localhost>
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

Hi,
in my attempt to understand how the microsoft stack make this possible I =

have tried to find hcidump an equivalent
on windows to visualize hci command issued to the device. I've found =

only commercial (and not cheap ) software, is
there a software can I use to dump hci commands on windows?

many thanks


Marcel Holtmann ha scritto:
> Hi Peter,
>
>   =

>>> I'm not expert in bluez kernel driver programming but I've developed an =

>>> application using socket abstraction
>>> on Windows (microsoft stack) and I can connect simultaneously to many =

>>> devices (7 max) with the same usb dongled
>>> tested with bluez on linux. So I think it can't be a hardware problem, =

>>> or better may be the hardware limitation but I think it's bypassable
>>> in software layers.
>>> bye
>>> Fabrizio
>>>       =

>> The problem is not to connect to 7 devices simultaniuous. The problem is =

>> that (on the HCI level) most (or all??) devices gives you an error =

>> response when you start a new connection while there is an outstanding =

>> connection request. Of cause you can come arround this by software on th=
e =

>> upper level. E.g. you can make sure not to send a new connect request to =

>> the device while it has not responeded to the previous one. =

>>     =

>
> my last attempt to make this work actually failed, but I didn't put much
> energy into it. Feel free to come up with a working version. The path
> how to handle this is clear.
>
>   =

>> Don't know what microsoft is doing here (don't have their source ;-). =

>>     =

>
> They will do something similar. If you get a HCI trace, then you can see
> for yourself what they are doing.
>
> Regards
>
> Marcel
>
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
