Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <122301c699f1$69c27ec0$072d650a@virgo.atlantico.net.br>
From: "Wagner Bezerra" <wagner@atlantico.com.br>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <4497CE54.5080305@ibmt.fraunhofer.de>	<4498EB58.3090200@ibmt.fraunhofer.de>	<1150883159.3950.34.camel@localhost>	<44991DF2.2000409@ibmt.fraunhofer.de>	<1150886307.3950.36.camel@localhost>	<44992C04.2030600@ibmt.fraunhofer.de><op.tbjz37bnn4ff4t@yang.mshome.net>
	<44A13398.7060305@ibmt.fraunhofer.de>
Date: Tue, 27 Jun 2006 10:55:56 -0300
MIME-Version: 1.0
Subject: Re: [Bluez-devel] [Fwd: Re:  Problem connecting Bluetooth device]
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

Falou, Z=E9. A gente se fala mais tarde.

----- Original Message ----- =

From: "Harald Niederl=E4nder" <harald.niederlaender@ibmt.fraunhofer.de>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Tuesday, June 27, 2006 10:33 AM
Subject: Re: [Bluez-devel] [Fwd: Re: Problem connecting Bluetooth device]


> Hi Yang,
>
> I try the connect with different channel parameters, but it was all times =

> the same result.
> What's the matter of channels? (I'm not so familiar with Bluetooth and =

> rfcomm)
> What could be the cause why the bt device send the DISC signal after =

> connecting?
> Exists any other way to exchange data with the remote device?
>
> Regards
>
> Harald
>
>
> yang.guangxiang schrieb:
>
>> Hi Harald,
>>
>> According as hcidump's output, your bt device have connect the remote
>> bt  device (00:11:B1:A2:01:C9), and you have gotten l2cap link and
>> rfcomm  link. But I don't know why your bt device send rfcomm DISC after
>> connected  . This is a signal to disconnect rfcomm link.
>>
>> I suggest that you can try to append channel param at command. e.g.
>>
>>  rfcomm conn /dev/rfcomm0 00:11:B1:A2:01:C9 1
>>
>>
>>
>> Regards
>>
>> yang
>>
>
>
>
>
>
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job =

> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel =



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
