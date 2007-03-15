Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45F92629.4070207@endian.se>
References: <45F92629.4070207@endian.se>
Date: Thu, 15 Mar 2007 14:01:41 +0100
Message-Id: <1173963701.6941.53.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Inquiry response containing RSSI
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Richard,

> I want to do inquiries that contains rssi in the response. (I know it
> requires bluetooth >= 1.2).
> I have a such dongle from CSR. I bluez from 2.6.20.1 and bluez-libs 3.9
> btw. I set the inquiry mode to 1 using the bluez-libs function
> hci_write_inquiry_mode.
> 
> The interesting thing is that the RSSI makes it up to the inquiry cache
> inside the hci_module, but the interface (hci_inquiry, called by ioctl)
> only uses the struct inquiry_info, which does not contain RSSI.
> 
> So I was thinking of a way to support this, could be to introduce
> another more generic IOCTL. Which returns the struct
> inquiry_info_with_rssi, or rather a struct of a new type which is the
> combination of struct inquiry_info_with_rssi and struct inquiry_info.

use the new D-Bus based API. It takes care of everything for you.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
