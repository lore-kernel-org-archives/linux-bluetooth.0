Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problem with SDP.
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <020001c63867$97faa290$0300a8c0@akira>
References: <001a01c637fa$8affa800$c800a8c0@kazama>
	 <1140649027.4519.53.camel@localhost> <007301c6384c$bf92b290$0300a8c0@akira>
	 <1140691067.24721.6.camel@localhost> <020001c63867$97faa290$0300a8c0@akira>
Content-Type: text/plain
Message-Id: <1140692361.24721.24.camel@localhost>
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
Date: Thu, 23 Feb 2006 11:59:21 +0100

Hi,

> Thanks for you answer....
> 
> 1)   The sdpd is working... I test it.
> 
> # ps -ae | grep sdpd
> 1614  ?        00:03:15 sdpd
> 
> However I Load it and try and the same result...
> 
> 
> 
> 2)   I disable the hcid.conf  (auth and encrypt) and the result is the 
> same...
> 
> I use Fedora Core 4....

install the latest bluez-libs and bluez-utils from the BlueZ website.
The Fedora Core 4 packages are quite old.

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
