Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Re: Help me! hciattach have no error msg,
	but hciconfig don't find the device.
From: Erwin Authried <eauth@softsys.co.at>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
In-Reply-To: <f64f4e8a0603020708l52623141x5d77d53f90825801@mail.gmail.com>
References: <f64f4e8a0603020708l52623141x5d77d53f90825801@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1141316385.28389.31.camel@justakiss>
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
Date: Thu, 02 Mar 2006 17:19:45 +0100

Am Donnerstag, den 02.03.2006, 23:08 +0800 schrieb zhu yong:
> Hi,Erwin
> my board use Samsung 44B0x chip of ATM7TDMI. I use bluez-utils-2.24
> and bluez-libs-2.24.
> Do I need patchs for non-mmu systems?
> Is 'startup script'  /etc/hcid.conf? 
> I have no ides how to change the file, I use default config.

The default config should be ok. Some patches are necessary because of
the fork() restrictions on nommu (they may be different for 2.24!):
http://home.at/cgi-bin/viewcvs.cgi/midori/sources/bluez-utils-2.10/

My startup script works as follows:

/sbin/hcid -n &
/sbin/hciattach ttyS0 csr &

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
