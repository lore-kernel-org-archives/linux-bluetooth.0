Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <B7DDE0E9-17B7-4980-9405-906ED5F56900@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <a8e1da0711282343v4397e754qbcedf9f67c94499a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Date: Thu, 29 Nov 2007 21:19:50 +0100
References: <4745D9EE.4020101@uni-koeln.de> <4749FAD6.6080403@uni-koeln.de>
	<1196055526.4217.44.camel@aeonflux> <474AA430.6010307@uni-koeln.de>
	<1196080043.17196.4.camel@aeonflux> <474B110A.7000804@uni-koeln.de>
	<a8e1da0711282343v4397e754qbcedf9f67c94499a@mail.gmail.com>
Subject: Re: [Bluez-users] hcitool scan returns wrong bdaddr
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Dave,

>> I found the 3.21 tarball, thanks. Unfortunately the error still  
>> occurs
>> with the resulting  libbluetooth.so.2.9.1. Because of the output from
>> ldd, I'm sure that hcitool is linked against the "right" lib. So  
>> the Bug
>> must be in 3.21 too, or there is an completely different Problem as I
>> assume, because of the same behavior with libbluetooth.so.2.9.0 from
>> debian lenny, and because you told me that it should work with an D- 
>> Bus
>> API, which is installed.
>> So perhaps the Problem is rooted in my D-Bus setup. I installed it  
>> from
>> the debian repository and thought it should work without any further
>> configurations.
>> I'll search for it,
>> thank you very much for your time and help,
>
> Maybe the Dbus api works for you, but the problem with hcitool is  
> still there.
>
> If you could build the bluez-utils/lib with -g and debug the hcitool,
> you might get the answer then.

don't worry. I fixed that already. It was a stupid thinko on my side.

Regards

Marcel


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
