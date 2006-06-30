Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44A4F25C.5000408@infitsrl.com>
Date: Fri, 30 Jun 2006 11:43:56 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44A4E5A4.5070904@infitsrl.com>	<1151657604.20305.9.camel@localhost>
	<44A4E987.1000104@infitsrl.com>
	<1151658731.20305.11.camel@localhost>
In-Reply-To: <1151658731.20305.11.camel@localhost>
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

Ok....I think my question was not so clear (I'm not english so escuse me).
I'm porting a simple application that I have made for Windows using =

Microsoft stack, in this application there is an inquiry and for every =

devices found I'm looking if it's opush capable.

In Microsoft stack I suppose sdp discovery of push service is masked in =

sense I don't have to specify the RFCOMM channel when  I made  the =

connection with device. In the SOCKADDR_BTH struct used by connect I =

simply specify -1 in port field (channel) and all works with 100% of =

opush enabled devices tested.

In conclusion I think in my windows version of this software there are =

multiple simultaneous sdp connections and I have not had problems with =

several types of adapters.

Sorry again for my english


Marcel Holtmann ha scritto:
> Hi Fabrizio,
>
>   =

>> Is there a list of bluetooth adapters supporting this feature?
>> Doing hciconfig -a [adapter] is not possible to known if the device =

>> support multiple simultaneus sdp_connect ?
>>     =

>
> I think my phrase was not clear. I haven't seen any adapter that is
> capable of multiple baseband pages at the same time.
>
> Regards
>
> Marcel
>
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
