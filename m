Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3FACBD13.6040702@zappa.cx>
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>	 <3FA8FFCE.9020708@zappa.cx> <1068041027.1287.24.camel@pegasus>
In-Reply-To: <1068041027.1287.24.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 08 Nov 2003 10:53:23 +0100

Marcel Holtmann wrote:
> Hi Andreas,
> 
> 
>>>Please test this. If the Microsoft is working all the time then your
>>>problem is part of the Silicon Wave chip or some else in the internal
>>>USB stuff of your notebook. However it works in 2.4 this must be some
>>>kind of problem in the Linux USB subsystem which only effects this kind
>>>of device.
>>
>>I just rebooted to check and it actually had the same problem as the 
>>internal device. Now I'm starting to guess it maybe is USB that is the 
>>problem, what is your opinion(s) ?
> 
> 
> please check this some more times and then report it to the USB mailing
> list. Some of them should know what is changed in 2.6. Do you have a
> desktop PC running 2.6 to verify that it is your notebook that is some
> kind of buggy?
Well I have now verified the same problem with the MS dongle on one of my
desktop computers (ASUS A7V333 mb), I tested with 2.6.0-test9-bk12.

Do you think it's time to try and report this to the USB people or what?

I get this type of error on both the notebook and desktop computer:
Nov  8 10:46:56 sunkan kernel: hci_usb: probe of 4-1.1:1.1 failed with error -5

/Andreas



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
