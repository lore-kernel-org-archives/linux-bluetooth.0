Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth issues with 2.4.19 kernel.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4344EF00.1000404@ncoretech.com>
References: <4344EF00.1000404@ncoretech.com>
Content-Type: text/plain
Message-Id: <1128592785.5492.22.camel@localhost.localdomain>
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
Date: Thu, 06 Oct 2005 11:59:45 +0200

Hi Zaheer,

> I am trying to integrate Bluetooth on two handheld device both running 
> on Pxa processor.
> One is running a kernel version of 2.4.19 and the other has 2.4.25.
> 
> On the handheld device which has  2.4.25 kernel(patched with 
> patch-2.4.25-mh5), 'hcitool scan' works fine and is able to detect other 
> bluetooth devices.
> 
> On another handheld device which has 2.4.19 kernel, without applying any 
> kernel patches from the bluez site, my bluetooth device  on Handheld 
> gets initialized, but i am not able to detect any other Bluetooth devices.
> However if i apply the patch 'patch-2.4.19-mh18' on the above kernel, i 
> am not able to initialize my Bluetooth device at all and it always times 
> out for the operation.
> 
> Am I missing some thing here, any suggestions to get the bluetooth 
> working on 2.4.19  kernel will be highly appreciated.

why don't you move to the latest 2.6 kernel. The 2.4 series is no longer
supported by us.

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
