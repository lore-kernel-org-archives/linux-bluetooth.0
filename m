Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: command tx timeout and continuous inquiry.
From: Marcel Holtmann <marcel@holtmann.org>
To: Rene Mayrhofer <rene@soft.uni-linz.ac.at>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3F8A7E52.60404@soft.uni-linz.ac.at>
References: 
	<3F86784F.9050608@soft.uni-linz.ac.at>	<1065778372.14923.336.camel@baroque.r
		ococosoft.com>
		<3F86A88E.4090106@soft.uni-linz.ac.at>	<1065790691.14513.173.camel@pegasus>
	  <3F86AF96.7000904@soft.uni-linz.ac.at>
	<1065791594.14514.179.camel@pegasus>  <3F8A7E52.60404@soft.uni-linz.ac.at>
Content-Type: text/plain
Message-Id: <1066036791.14513.186.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 13 Oct 2003 11:19:45 +0200

Hi Rene,

> Unfortunately Acer does not seem to provide one, they don't even seem to 
> support the BT-500 properly anymore. Thus I am now stuck with a hardware 
> which does not seem to support what I intend to do - time to buy new 
> hardware....
> Which USB Bluetooth adapters are currently recommended for Bluez ? With 
> which do people have good experiences concerning stability ? It should 
> support inquiry and L2CAP connections at the same time and (which I'll 
> most probably need in the near future) BNEP/PAN. A RTFM-link would be 
> wonderful, if there's a list of known-good devices and revisions up 
> somewhere.

all CSR firmwares with HCI 16.x and greater are fine.

	http://www.holtmann.org/linux/bluetooth/features.html
	http://www.holtmann.org/linux/bluetooth/csr.html

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
