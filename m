Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Nokia 6230: "pairing and conn. rejected for
	security reasons"
From: Marcel Holtmann <marcel@holtmann.org>
To: Lutz Pressler <Lutz.Pressler@SerNet.DE>
Cc: Peter Stephenson <pws@csr.com>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <E1BQ1Vm-0006dh-00@intern.SerNet.DE>
References: <E1BQ1Vm-0006dh-00@intern.SerNet.DE>
Content-Type: text/plain
Message-Id: <1084875342.5833.89.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 18 May 2004 12:15:43 +0200

Hi Lutz,

> > please show us "hcidump -x" while requesting the remote information. We
> > can decode the information by hand and you don't have to install new
> > BlueZ packages.
> 
> > HCI Event: Read Remote Ver Info Complete(0x0c) plen 8
>   00 00 00 01 0A 00 80 03
> > HCI Event: Command Complete(0x0e) plen 3
>   01 00 00
> < HCI Command: Read Remote Supported Features(0x01|0x001b) plen 2
>   00 00
> > HCI Event: Command Status(0x0f) plen 4
>   00 01 1B 04
> > HCI Event: Read Remote Supported Features(0x0b) plen 11
>   00 00 00 BF EE 00 00 00 00 00 00

looks like something is really screwed up here. Please check this with
another USB dongle to make sure that your phone is not broken.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
