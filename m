Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] Question about role switch
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A1F0D47583A2D711919F00600819B3A4028BD7@goofy.vitronics.com>
References: <A1F0D47583A2D711919F00600819B3A4028BD7@goofy.vitronics.com>
Content-Type: text/plain
Message-Id: <1103131447.8717.17.camel@pegasus>
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
Date: Wed, 15 Dec 2004 18:24:07 +0100

Hi Richard,

> But, the Windows PC and the Linux PC use the same USB Anycomm dongle. The Windows PC
> is able to communicate with the X-scale Bluez system. The Linux PC can not.
> I think this points to something that Windows is doing differently.

actually I overlooked one thing. You must activate rswitch in the link
policy, because otherwise the role switch will be rejected.

> BTW, the HCI number you quote "16.4" ....How do I get that number ?
> Is that available from hciconfig -a ? Is that one of the values in the dump below ?

You can use "hciconfig hci0 revision" or look at my CSR page.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
