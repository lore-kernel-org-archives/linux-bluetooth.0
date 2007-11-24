Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <47482E7C.9090205@frederic-blain.com>
Date: Sat, 24 Nov 2007 14:00:28 +0000
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Blain?= <bluez@frederic-blain.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
References: <47477234.9010007@free.fr>
	<1195956126.10878.444.camel@cookie.hadess.net>
In-Reply-To: <1195956126.10878.444.camel@cookie.hadess.net>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Sony PS3 sixaxis & bluez
Reply-To: bluez@frederic-blain.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1031600646=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1031600646==
Content-Type: multipart/alternative;
	boundary="------------010908000004010206030101"

This is a multi-part message in MIME format.
--------------010908000004010206030101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Hello Bastien,

Thanks for this, I've updated http://wiki.bluez.org/wiki/Input to 
reflect explicitly this information.

Do you know why device initiated connections are not supported  (Lake of 
time,
technical issues, ...) and if someone is working on this integration ?

Regarding your sixaxis patch, I can help to develop / test it if you want.

-- 
creber



Bastien Nocera wrote:
> On Sat, 2007-11-24 at 00:37 +0000, Frédéric Blain wrote:
>   
>> Hello,
>>
>> With the current bluez-utils version (3.22 or CVS), the PS3 bluetooth 
>> controller (Sixaxis) is
>> not recognized.
>>     
>
> The input service doesn't support device initiated connections. See:
> http://thread.gmane.org/gmane.linux.bluez.devel/12584/focus=12614
>
> <snip>
>   
>> ==== Workaround ====
>>
>> Basically, using the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/hidd 
>> renamed as input will help since at startup,
>> bluetoothd-service-input will scan this file and fill 'GSList *devices' 
>> accordingly.
>> Also, the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/trusts has to be 
>> updated .
>>
>> For those interested, a step by step description can be found here :
>> http://creber.free.fr/frederic-blain/index.php?n=Main.GentooOnPS3SixaxisBluetooth#Workaround.
>>     
>
> Haaa. Once I get the capabilities right in my sixaxis patch (I'll be
> able to compare the hidd generated output with the one from my patch), I
> think I'll be able to use udev to automatically add the device as
> supported via Bluetooth once connected via USB.
>
> I'll try and get to it in the week.
>
> Cheers
>
>   


--------------010908000004010206030101
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Hello Bastien,<br>
<br>
Thanks for this, I've updated <a class="moz-txt-link-freetext" href="http://wiki.bluez.org/wiki/Input">http://wiki.bluez.org/wiki/Input</a> to
reflect explicitly this information.<br>
<br>
Do you know why device initiated connections are not supported&nbsp; (Lake
of time,<br>
technical issues, ...) and if someone is working on this integration ?<br>
<br>
Regarding your sixaxis patch, I can help to develop / test it if you
want.<br>
<br>
-- <br>
creber<br>
<br>
<br>
<br>
Bastien Nocera wrote:
<blockquote cite="mid:1195956126.10878.444.camel@cookie.hadess.net"
 type="cite">
  <pre wrap="">On Sat, 2007-11-24 at 00:37 +0000, Fr&eacute;d&eacute;ric Blain wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello,

With the current bluez-utils version (3.22 or CVS), the PS3 bluetooth 
controller (Sixaxis) is
not recognized.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
The input service doesn't support device initiated connections. See:
<a class="moz-txt-link-freetext" href="http://thread.gmane.org/gmane.linux.bluez.devel/12584/focus=12614">http://thread.gmane.org/gmane.linux.bluez.devel/12584/focus=12614</a>

&lt;snip&gt;
  </pre>
  <blockquote type="cite">
    <pre wrap="">==== Workaround ====

Basically, using the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/hidd 
renamed as input will help since at startup,
bluetoothd-service-input will scan this file and fill 'GSList *devices' 
accordingly.
Also, the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/trusts has to be 
updated .

For those interested, a step by step description can be found here :
<a class="moz-txt-link-freetext" href="http://creber.free.fr/frederic-blain/index.php?n=Main.GentooOnPS3SixaxisBluetooth#Workaround">http://creber.free.fr/frederic-blain/index.php?n=Main.GentooOnPS3SixaxisBluetooth#Workaround</a>.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Haaa. Once I get the capabilities right in my sixaxis patch (I'll be
able to compare the hidd generated output with the one from my patch), I
think I'll be able to use udev to automatically add the device as
supported via Bluetooth once connected via USB.

I'll try and get to it in the week.

Cheers

  </pre>
</blockquote>
<br>
</body>
</html>

--------------010908000004010206030101--


--===============1031600646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1031600646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1031600646==--
