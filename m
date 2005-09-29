Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems with high-speed rfcomm transfers
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <433ADB96.5080100@flander.com>
References: <433ADB96.5080100@flander.com>
Content-Type: text/plain
Message-Id: <1127982671.5123.11.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Thu, 29 Sep 2005 10:31:11 +0200

Hi Simo,

> Has anyone else had problems with high-speed rfcomm transfers with 
> BlueZ?
> 
> I am using simple rfcomm test setup. The client dumps data to rfcomm 
> socket, and the server receives the data. Sometimes the data 
> transfer just freezes, without any error messages. The client has 
> sent the data, but it does not arrive at the server program.
> 
> Tested with the bluez version that comes with 2.6.12 kernel, using 
> usb bt dongle.
> 
> Anyway, I understand that more detailed error description is surely 
> needed, but I just wanted to know if anyone else has had these 
> problems.

please provide some test programs to reproduce it.

> With amd64 machine it sometimes crashes with this error message:
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000050 
> RIP:

Try the latest 2.6.14-rc2 kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
