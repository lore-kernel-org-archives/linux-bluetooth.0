Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Peter K. Martin" <Peter.K.Martin@t-online.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAABI149cyoQEqKpLo4CgBvxAEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAABI149cyoQEqKpLo4CgBvxAEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1102514327.9988.73.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-users] Re: BT unter SuSE 9.2
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
Date: Wed, 08 Dec 2004 14:58:47 +0100

Hi Peter,

> now the trouble begins. I install SuSE 9.2 and wnted to start the
> bluetooth-function of my toshiba satellite pro m10, which already
> worked under 9.1 ---> but now nothing happens. When I try to start
> with dmabt the response is: unable to access /dev/toshiba, although
> the file (?) is existing. The lines in modules.conf are also o.k.
>  
> I tried to patch the toshiba_acpi, but without any result. Only a long
> time of compilation, etc.
>  
> Please give me an idea what to do to solve the problem. I have always
> to switch from Linux to Windows in order to get an internet-connection
> and this is very boring.

the SuSE 9.2 and Bluetooth is working perfect. Your problems seems to be
in activating the dongle on the hardware side . Actually this is not
really a BlueZ related problem.

Do it show up in /proc/bus/usb/devices? Can you use a hardware switch
near your keyboard to activate it?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
