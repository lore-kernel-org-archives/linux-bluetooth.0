Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-Id: <44F3F9A9.8070802@arcor.de>
Date: Tue, 29 Aug 2006 10:24:09 +0200
From: Simon Siemens <Simon.Siemens@arcor.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44F33232.8030505@arcor.de>
	<1156799590.5613.45.camel@aeonflux.holtmann.net>
In-Reply-To: <1156799590.5613.45.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-devel] Asynchronous inquiry
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Sounds very good. Could you please announce this, if it is ready? Or
will there simply be a new bluez-gnome package on your website?

Do I need a new BlueZ version to use this? I currently have Ubuntu 6.06
LTS with BlueZ 2.24. This seems (compared to your website) very
outdated. Does anyone know why? Will I have trouble installing
bluez-libs-3.4 and bluez-utils-3.4?

Thanks very much for your help.

Simon



Marcel Holtmann schrieb:
> Hi Simon,
>
>   
>> Is there a way, to do an asynchronous inquiry. I only know the
>> hci_inquiry function, which gives you a complete list of the found
>> devices. For two projects (a GUI and a research project) I would like to
>> present each device as soon as it has been found. Is it possible to have
>> some kind of notification each time a device sends the inquiry response
>> message? (Something like multi-processing / multi-threading)?
>>     
>
> you can either use the HCI raw socket directly or use the new D-Bus
> based API. I would propose you use the D-Bus API. An example might
> follow in the next couple of days in the bluez-gnome CVS repository.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>   

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
