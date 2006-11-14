Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4559E223.6060200@palmsource.com>
Date: Tue, 14 Nov 2006 16:34:59 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <135557.8815.qm@web31006.mail.mud.yahoo.com>
In-Reply-To: <135557.8815.qm@web31006.mail.mud.yahoo.com>
Subject: Re: [Bluez-devel] python a2dp
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

Got the same error for c_uint16 and c_uint32
Now, I'm stuck with that one :

Traceback (most recent call last):
  File "./avdtp.py", line 50, in ?
    import bluetooth
ImportError: No module named bluetooth

I fear this one won't be solved the same way : where to find the module?

Frederic.


Sergey Krivov a =E9crit :
> Hi, Fr=E9d=E9ric,
>
>   =

>> I just installed the ctypes my ubuntu provides
>> (0.9.6) but I get the =

>> following error :
>>
>> Traceback (most recent call last):
>>   File "./avdtp.py", line 49, in ?
>>     from ctypes import
>> Structure,c_uint8,c_uint16,c_ulong,c_uint32,c_void_p
>> ImportError: cannot import name c_uint8
>>     =

>
> i am using ctypes 1.0.0-1 on fedora core 6.
> c_uint8 is an alias for c_byte
> to avoid replacing c_uint8 with c_byte in the code
> import c_byte instead c_uint8 and put afterwords
> c_uint8=3Dc_byte
>
>
>
>  =

> _________________________________________________________________________=
___________
> Do you Yahoo!?
> Everyone is raving about the all-new Yahoo! Mail beta.
> http://new.mail.yahoo.com
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
>   =



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
