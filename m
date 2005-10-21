Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] dfutool - IBM X23 refuses to update ;)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4359178E.3080408@kernelconcepts.de>
References: <43591455.7070005@kernelconcepts.de>
	 <4359178E.3080408@kernelconcepts.de>
Content-Type: text/plain
Message-Id: <1129912993.11428.20.camel@blade>
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
Date: Fri, 21 Oct 2005 18:43:13 +0200

Hi Nils,

> Hmm... I just compared the original DFU and the upgrade DFU using the
> verify option:
> 
> ./dfutool verify ITSE_00003_07_IBM_BDC_Firmware128_Rev310.dfu
> Filename        ITSE_00003_07_IBM_BDC_Firmware128_Rev310.dfu
> Filesize        338168
> Checksum        b589a143
> DFU suffix      10 03 ff ff ff ff 00 01 55 46 44 10 43 a1 89 b5
> idVendor        ffff
> idProduct       ffff
> bcdDevice       310
> bcdDFU          1.0
> ucDfuSignature  DFU
> bLength         16
> dwCRC           b589a143
> Firmware type   CSR-dfu1
> Firmware check  valid checksum
> 
> ./dfutool verify org.dfu
> Filename        org.dfu
> Filesize        320480
> Checksum        8c89a52e
> DFU suffix      15 01 10 03 bf 04 00 01 55 46 44 10 2e a5 89 8c
> idVendor        04bf
> idProduct       0310
> bcdDevice       115
> bcdDFU          1.0
> ucDfuSignature  DFU
> bLength         16
> dwCRC           8c89a52e
> Firmware type   CSR-dfu1
> Firmware check  valid checksum
> 
> 
> Might the missing product and vendor ID be the problem with upgrade
> file? Can/should I try to change those?

no, because dfutool simply ignores them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
