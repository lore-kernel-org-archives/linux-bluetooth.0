Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <01e101c69eb9$50f41670$2800a8c0@Desarrollo>
From: "Victor Andres" <victor@cymonline.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <003e01c69e8c$c0717970$2800a8c0@Desarrollo><Pine.LNX.4.63.0607031426320.28132@redbean.intranet.gw-instruments.de>
	<e1effdeb0607030546w38382e5ct4bb6bed8c0271da8@mail.gmail.com>
Date: Mon, 3 Jul 2006 17:56:53 +0200
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Serial comunication RFCOMM
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

Thanks!

But I can't find the dbus-api.txt, and I really don't know what's d-bus. I 
have done some examples using rfcomm from the shell. I actually use Ubuntu, 
and I have installed bluez from apt-get. Is this the correct way?


Thanks. Very pleased.



----- Original Message ----- 
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Sent: Monday, July 03, 2006 2:46 PM
Subject: Re: [Bluez-devel] Serial comunication RFCOMM


> Hi Victor,
>
> The BlueZ D-Bus API provides an easy way to handle multiple local
> adapters based on D-Bus paths. eg:
> /org/bluez/hci0
> /org/bluez/hci1
> ....
>
>
> Check the dbus-api.txt file and the dbus-test python script for more
> information.
>
> BR,
> Claudio.
>
> On 7/3/06, Peter Wippich <pewi@gw-instruments.de> wrote:
>>
>> Hi Victor,
>>
>> On Mon, 3 Jul 2006, Victor Andres wrote:
>>
>> > Hi. I'm a new developer of bluez API. I would like that someone say if
>> > is posible to do I want.
>> >
>> > Is it posible to link (bluetooth) multiple devices to mi PC using Linux
>> > and Bluez stack (using multple usb-bluetooth adapter if it's necesary)?
>> >
>> > I want link my PC with multiples (more than 7) GPS bluetooth (so I
>> > can't do it with windows stack), to receive the NMEA sentences and
>> > manipulate then (get the latitud, longitud, speed ...).
>>
>> I don't see anything which should prevent you from doing so.
>> And as far as I know BlueZ currently is the only Bluetooth Stack which
>> supports multiple HCI devices.
>>
>> Ciao,
>>
>> Peter
>>
>>
>>
>> |       Peter Wippich                   Voice: +49 30 46776411          |
>> |       G&W Instruments GmbH            fax:   +49 30 46776419          |
>> |       Gustav-Meyer-Allee 25, Geb. 12  Email: pewi@gw-instruments.de   |
>> |       D-13355 Berlin  / Germany                                       |
>>
>>
>> Using Tomcat but need to do more? Need to support web services, security?
>> Get stuff done quickly with pre-integrated technology to make your job 
>> easier
>> Download IBM WebSphere Application Server v.1.0.1 based on Apache 
>> Geronimo
>> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>> _______________________________________________
>> Bluez-devel mailing list
>> Bluez-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>>
>
>
> -- 
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
>
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job 
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel 



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
