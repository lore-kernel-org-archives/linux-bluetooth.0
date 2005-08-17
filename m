Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000201c5a2e4$c1076e20$9301a8c0@DURAI>
From: "durai" <durai@isofttech.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
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
Date: Wed, 17 Aug 2005 10:02:55 +0530


Hi Al,
In uClinux there is no fork, only vfork is available. You have to change 
your fork to vfork in uClinux.
Please refer 
http://www.ucdot.org/article.pl?sid=03/12/12/0317219&mode=thread.
regards
durai
----- Original Message -----
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux
Date: Wed, 17 Aug 2005 10:28:54 +0800
From: "Al" <Al_chane@issc.com.tw>

Hi, durai:

     I port hcid to embedded uClinux (2.4.20). But it has problem to
fork(), fork() return -1. Did you have fork() problem in your embedded
linux?

thanks a lot,

Al

----- Original Message ----- 
From: "durai" <durai@isofttech.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Monday, August 15, 2005 3:22 PM
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux


> Hi Al,
> I recently ported bluez stack in a embedded linux running 2.4.18 kernel.
> First I downloaded the MH patch from
> http://www.holtmann.org/linux/kernel/. and
> applied it. Now both statically compiled driver as well as modules are
> working correctly.
> You can also try finding an appropriate patch and patch it with your
> kernel. But what is
> surprising for me is, though your kernel is 2.4.21 and you are not able to
> find the options in
> make menuconfig.  I guess something  is messed up in your package.
>
> Can you find "hci_usb_init" in your System.map? Is it integrated
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



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
