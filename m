Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44A4FB83.8090001@infitsrl.com>
Date: Fri, 30 Jun 2006 12:22:59 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44A4E5A4.5070904@infitsrl.com>	<1151657604.20305.9.camel@localhost>	<44A4E987.1000104@infitsrl.com>
	<1151658731.20305.11.camel@localhost>
	<Pine.LNX.4.63.0606301142130.18028@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0606301142130.18028@redbean.intranet.gw-instruments.de>
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

Thanks to all....
I'm nearly sure that the solution for me is lot more simple. It would =

like to have a tool hcidump-like for windows to verifying what happens.

To obtain the rfcomm channel associated to a service (opush in my case) =

sd_connect and the response inspection it's the only way?
My requirement in the end it's only to find all devices opush enabled in =

a determinate moment and send to all a file (a vcalendar). The problem =

is that send have to be simultaneous (or nearly). If  every opush search =

is blocking  target devices becames like a chain where every one it's =

conditioned by the previouos inquired.

Peter Wippich ha scritto:
> Hello All, =

>   =

>> Hi Fabrizio,
>>
>>     =

>>> Is there a list of bluetooth adapters supporting this feature?
>>> Doing hciconfig -a [adapter] is not possible to known if the device =

>>> support multiple simultaneus sdp_connect ?
>>>       =

>> I think my phrase was not clear. I haven't seen any adapter that is
>> capable of multiple baseband pages at the same time.
>>     =

>
> So do I. There's a simple proof: just send a HCI_Create_Connection comman=
d =

> and than try to send a second Create_Connection before you get the =

> connection complete event for the first Create_Connection. =

> If the second create connection passes, please tell me what chip it was =

> !!!
> The normal behaviour is that the chip will reply with an error event (lik=
e =

> command dissallowed) for the second connection attempt. I think there was =

> some discussion about this some time ago. The only way to come around thi=
s =

> is a complicated buffering for HCI commands inside BlueZ. It will require =

> the stack to hold a create connection command in the queue when it gets a=
n =

> error response for a create connection command and re-issue it once it =

> gets an connection complete or connection fail event.
> The real bad thing here is that different chips will behave different so =

> there is some kind of hardware dependence here. =

>
> I have not checked but as far as I know BlueZ does not support such a =

> mechanism. Feel free to implement this (the less complicated task) and  =

> make sure it always works correctly (the much more complicated task
> because you have to test with a lot of different hardware).  =

>
> You may also try something on the upper level. For example synchronize =

> your threads in such a way that there is only one outstanding sdp connect=
. =

> For example use a semaphore which must be owned by the thread to issue a =

> sdp connect. Once the sdp connect is through (even completed or failed) =

> the semaphore is freed and the next thread waiting is allowed to start a =

> sdp connection. =

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
