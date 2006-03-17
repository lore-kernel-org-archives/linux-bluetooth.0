Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] blue-utils-2.25, dbus.c: dbus_connection_close()
	not found
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <62d428280603100409j4e8318a3o890d4ba137c91991@mail.gmail.com>
References: <62d428280603100409j4e8318a3o890d4ba137c91991@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1142599736.4392.14.camel@localhost>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 17 Mar 2006 13:48:56 +0100

Hi Johan,

> I downloaded and compiled all four packages from
> http://www.bluez.org/download.html
>     * bluez-libs-2.25.tar.gz
>     * bluez-utils-2.25.tar.gz
>     * bluez-firmware-1.1.tar.gz
>     * bluez-hcidump-1.30.tar.gz
> 
> I only had problems compiling bluez-utils - all other three packages
> has been compiled and installed.
> dbus_connection_close() in dbus.c does not seem to difined nor declared.
> Where is it supposed to be? Do I need to definen some paths, or
> install something else?

you need a recent version of the D-Bus library.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
