Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help me! hciattach have no error msg, but
	hciconfig have no device msg.
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <f64f4e8a0602280751l642cf100p5fdd6bd1a7413626@mail.gmail.com>
References: <f64f4e8a0602280751l642cf100p5fdd6bd1a7413626@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1141142725.26020.178.camel@justakiss>
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
Date: Tue, 28 Feb 2006 17:05:25 +0100

Hi,
is it the AT91M40800 that you are using? Which version of hcitools do
you use? There are a few patches required for non-mmu systems. How does
your startup script look like? 

Regards,
Erwin

Am Dienstag, den 28.02.2006, 23:51 +0800 schrieb zhu yong:
> Hi, everyone
>   I use one uare bluetooth device on my arm board. operation system is
> uclinux, kernel is linux-2.4.24.
>   I use hciattach cmd. There have no error msg.but I use hciconfig to
> display devices, there have no devices info.
>   I don't know why don't find device, any advice will help me!
>  
>   In addition, I use the same hciattach cmd on my pc, hciconfig can
> find the device.
>  



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
