Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43591DD5.4090109@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] dfutool - IBM X23 refuses to update ;)
References: <43591455.7070005@kernelconcepts.de>	 <4359178E.3080408@kernelconcepts.de> <1129912993.11428.20.camel@blade>
In-Reply-To: <1129912993.11428.20.camel@blade>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Fri, 21 Oct 2005 18:56:53 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann schrieb:
> Hi Nils,
Hi!

Too bad ... so I really have to install Windows to do this!?
Too bad too bad ;)

Thanks, anyway!

Cheers
  nils


>>Hmm... I just compared the original DFU and the upgrade DFU using the
>>verify option:
>>
>>./dfutool verify ITSE_00003_07_IBM_BDC_Firmware128_Rev310.dfu
>>Filename        ITSE_00003_07_IBM_BDC_Firmware128_Rev310.dfu
>>Filesize        338168
>>Checksum        b589a143
>>DFU suffix      10 03 ff ff ff ff 00 01 55 46 44 10 43 a1 89 b5
>>idVendor        ffff
>>idProduct       ffff
>>bcdDevice       310
>>bcdDFU          1.0
>>ucDfuSignature  DFU
>>bLength         16
>>dwCRC           b589a143
>>Firmware type   CSR-dfu1
>>Firmware check  valid checksum
>>
>>./dfutool verify org.dfu
>>Filename        org.dfu
>>Filesize        320480
>>Checksum        8c89a52e
>>DFU suffix      15 01 10 03 bf 04 00 01 55 46 44 10 2e a5 89 8c
>>idVendor        04bf
>>idProduct       0310
>>bcdDevice       115
>>bcdDFU          1.0
>>ucDfuSignature  DFU
>>bLength         16
>>dwCRC           8c89a52e
>>Firmware type   CSR-dfu1
>>Firmware check  valid checksum
>>
>>
>>Might the missing product and vendor ID be the problem with upgrade
>>file? Can/should I try to change those?
> 
> 
> no, because dfutool simply ignores them.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


Viele Grüße
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDWR3VJXeIURG1qHgRAsiZAKCe50SQCTqK7N733LaAuyaOjhyG4ACeP33m
NR1erickKwba7mi0aHURGAg=
=6FB8
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
