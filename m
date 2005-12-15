Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "zio tom" <zio.tom@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] A blue chamaleon to be
References: <op.s1tgc9j9xabado@portatilegio> <1134636788.5198.42.camel@localhost> <op.s1tiptlkxabado@portatilegio> <1134638529.11856.1.camel@localhost> <op.s1tj7dd6xabado@portatilegio> <1134642179.11856.30.camel@localhost> <op.s1t0xmg8xabado@portatilegio>
Message-ID: <op.s1t2ws0rxabado@portatilegio>
In-Reply-To: <op.s1t0xmg8xabado@portatilegio>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 15 Dec 2005 18:29:17 +0100

In data Thu, 15 Dec 2005 16:50:00 +0100, zio tom <zio.tom@gmail.com> ha  
scritto:

> In data Thu, 15 Dec 2005 11:22:59 +0100, Marcel Holtmann  
> <marcel@holtmann.org> ha scritto:
>
>> Hi Giovanni,
>>
>>> 2.19-5 is the number of the version installed.
>>
>> it would be better to upgrade to bluez-utils-2.23, because it fixed some
>> stuff with the PIN helper handling and even the error reporting was
>> improved.

Marcel seems there is upgrade there,
now mobile and Linux are paired. I can view contents and archives, using  
the kbluepin interface seconds after having dialed the pin in the mobile  
display.
Now, when I'm trying to connect via GPRS through wvdial (after having  
configured wvdial.conf to fit to my provider's profile) here what I get:

giovanni@linux:~> su
Password:
linux:/home/giovanni # wvdial
--> WvDial: Internet dialer version 1.54.0
--> Cannot open /dev/rfcomm0: Cannot get information for serial port.
--> Cannot open /dev/rfcomm0: Input/output error

What's the problem here?
bye, Giovanni.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
