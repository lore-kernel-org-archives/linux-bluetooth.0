Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] SCO audio sync
From: Marcel Holtmann <marcel@holtmann.org>
To: ubaldo <ubaldo@eja.it>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20040727145602.30665.qmail@webmail.aruba.it>
References: <20040727145602.30665.qmail@webmail.aruba.it>
Content-Type: text/plain
Message-Id: <1090940808.4845.21.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 27 Jul 2004 17:06:48 +0200

Hi,

> I am having another strange problem, sometime when I record from a SCO 
> channel in 16bit (0x0060) to a file the first byte is missing and when I 
> play it back I listen just caos. 
> 
> But if I cut the first byte, or I add a byte in front of the file, then I 
> can listen it fine. 
> 
> Is there a way to be sure that I am reading the packet in the right way? 

check the mailing list archive, because I remember that there was a
thread about this problem.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
