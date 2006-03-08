Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't open PIN file
	/home/chenjiajing/bluez//etc/bluetooth/pin!
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <f64f4e8a0603080810v740f51fejeab23a6b86751b0@mail.gmail.com>
References: <f64f4e8a0603080810v740f51fejeab23a6b86751b0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1141835880.27904.68.camel@justakiss>
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
Date: Wed, 08 Mar 2006 17:38:00 +0100

Am Donnerstag, den 09.03.2006, 00:10 +0800 schrieb zhu yong:
> I use the cmd 'hcid', but find that hcid find the pin file from error
> directory.
> the /home/chenjiajing/bluez/ is my compile directory. 
> How can I change to the correct directory of '/etc/bluetooth/pin'?
> info as follows:
> # ./hcid -n -f /etc/bluetooth/hcid.conf
> hcid[32]: Bluetooth HCI daemon
> hcid[32]: Can't open PIN
> file /home/chenjiajing/bluez//etc/bluetooth/pin. No suc
> h file or directory(2)
> hcid[33]: Can't init device hci0. Connection timed out(110)
>  
you need to specify --prefix=\"\" for "configure" in bluez-utils and
bluez-libs for cross compiling.

-Erwin





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
