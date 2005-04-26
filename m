Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] implementing security mode 2 or 3
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <426E5CCC.2030108@gmx.ch>
References: <426E0C5A.8060203@gmx.ch>
	 <200504261153.08434.bluez-user@schaettgen.de>  <426E5CCC.2030108@gmx.ch>
Content-Type: text/plain
Message-Id: <1114530540.10706.301.camel@pegasus>
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
Date: Tue, 26 Apr 2005 17:49:00 +0200

Hi Marco,

> this works great with a 2.6.11 kernel.
> Unfortunately I'm bound to kernel 2.4.26 or 2.6.7.
> 2.4.26 doesn't work. It just let's remote devices connect...
> Do you know if 2.6.7 will?

the 2.6.7 will fail. The needed security hooks are introduced with
2.6.10 and the RFCOMM service level security with 2.6.11 according to my
patch logs.

> If not, which part of the kernel has to be fixed? Is it a part of bluez?

It is inside the BlueZ core and the RFCOMM layer.

> Can this encryption be reached in another way?

In general yes. You must call the HCI functions, but it is impossible to
call them at the correct time (after the SABM).

> Where are the link keys saved? I'm unable to find them.

Starting with bluez-utils-2.16 under /var/lib/bluetooth/*/linkkeys.

> Is there something that has to be paid attention to if I do encryption like 
> this? Does the password/Dongle/... influence the encryption strength?

The encryption key size is the only thing that may vary. For CSR chips
it can be between 56 bits and 128 bits depending on the firmware.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
