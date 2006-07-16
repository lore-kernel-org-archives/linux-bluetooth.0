Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44BAC592.2010705@szift.org>
Date: Mon, 17 Jul 2006 01:02:42 +0200
From: =?UTF-8?B?xYF1a2FzeiBIZWpuYWs=?= <blue@szift.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <44BAB94E.9060905@szift.org> <1153088451.19520.1.camel@localhost>
In-Reply-To: <1153088451.19520.1.camel@localhost>
Subject: Re: [Bluez-users] BD hardware address problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


>> I've been trying to make a bluetooth link between two computers, a 
>> windows run laptop and my linux box - using two bluetooth usb dongles
>> I think the problem is quite obvious: they both have been assigned the 
>> same bd address: 11:11:11:11:11:11
>> whatever I try, both devices still have the same bd addresses leading 
>> even to a situation like this (when connected to the same PC):
> 
> this is a known problem and it is these stupid ISSC dongles where the
> manufacturer doesn't assigned unique addresses to each dongle. You can
> try to use bdaddr from CVS to set your own address.

Hi, thanks for the fast reply, but unluckily that didn't help

szift@szift:~/blue/utils/test$./bdaddr -i hci0 22:22:22:22:22:22
Manufacturer:   Integrated System Solution Corp. (57)
Device address: 11:11:11:11:11:11
New BD address: 22:22:22:22:22:22

Can't write new address

But if I could give You any debug data that could be usefull, just let 
me know

and btw. Your web-based cvs viewer is down - I had to check the cvs 
history and guess to get the right module name ;]

--
Best wishes
Lukasz 'Szift' Hejnak


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
