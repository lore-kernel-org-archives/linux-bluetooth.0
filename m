Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCID D-Bus (Seg Fault)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05091409061f00ea01@mail.gmail.com>
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126273252.5227.119.camel@blade>
	 <e1effdeb050912140719fc9d3b@mail.gmail.com>
	 <1126561206.24935.1.camel@localhost.localdomain>
	 <e1effdeb050912160979b5ba49@mail.gmail.com>
	 <1126567316.5518.9.camel@localhost.localdomain>
	 <e1effdeb05091306033c7476a@mail.gmail.com>
	 <1126637659.9456.0.camel@localhost.localdomain>
	 <e1effdeb0509140500650ec0c0@mail.gmail.com>
	 <1126710977.16166.62.camel@station6.example.com>
	 <e1effdeb05091409061f00ea01@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1126771915.28510.18.camel@station6.example.com>
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
Date: Thu, 15 Sep 2005 10:11:55 +0200

Hi Claudio,

> sorry. It's done!

patch is in, but next time also use tabs for the second line of this:

	hci_send_cmd(req->dev, OGF_LINK_CTL,
	             OCF_PIN_CODE_NEG_REPLY, 6, &req->bda);

No spaces for indentation at all.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
