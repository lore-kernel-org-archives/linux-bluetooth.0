Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A91@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Wed, 17 Aug 2005 10:28:54 +0800

Hi, durai:

     I port hcid to embedded uClinux (2.4.20). But it has problem to
fork(), fork() return -1. Did you have fork() problem in your embedded
linux?

thanks a lot,

Al

----- Original Message -----=20
From: "durai" <durai@isofttech.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Monday, August 15, 2005 3:22 PM
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux


> Hi Al,
> I recently ported bluez stack in a embedded linux running 2.4.18 =
kernel.
> First I downloaded the MH patch from=20
> http://www.holtmann.org/linux/kernel/. and
> applied it. Now both statically compiled driver as well as modules are =

> working correctly.
> You can also try finding an appropriate patch and patch it with your=20
> kernel. But what is
> surprising for me is, though your kernel is 2.4.21 and you are not =
able to=20
> find the options in
> make menuconfig.  I guess something  is messed up in your package.
>
> Can you find "hci_usb_init" in your System.map? Is it integrated=20
> correctly?
> regards
> durai



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
