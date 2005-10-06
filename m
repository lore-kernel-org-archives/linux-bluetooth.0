Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] How do I pair?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <200510060042.36966.sf.net@booths.org.uk>
References: <200510060042.36966.sf.net@booths.org.uk>
Content-Type: text/plain
Message-Id: <1128592717.5492.20.camel@localhost.localdomain>
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
Date: Thu, 06 Oct 2005 11:58:37 +0200

Hi Ken,

> I've just upgraded from the Suse 9.3 default bluez packages to:
> bluez-libs-2.21.tar.gz
> bluez-utils-2.21.tar.gz
> bluez-pin-0.26.tar.gz
> bluez-firmware-1.0.tar.gz
> bluez-hcidump-1.26.tar.gz
> bluez-hciemu-1.2.tar.gz
> 
> and my /etc/bluetooth/hcid.conf still says
>         name "Ken's PC";
> and I've editted the /etc/bluetooth/pin to have the same PIN code, yet when I 
> try to pair from my SE K750i, the PCs name is discovered as "Unknown" and the 
> PIN is rejected.

show us "hciconfig -a" and run "hcidump -X -V".

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
