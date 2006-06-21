Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip Langdale <philipl@mail.utexas.edu>
In-Reply-To: <4498AA79.3060709@mail.utexas.edu>
References: <448D88EE.3030902@mail.utexas.edu>
	<1150540883.17539.38.camel@aeonflux.holtmann.net>
	<4498AA79.3060709@mail.utexas.edu>
Date: Wed, 21 Jun 2006 09:15:23 +0200
Message-Id: <1150874123.3950.11.camel@localhost>
Mime-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Observations from mx-5000 bluetooth keyboard +
	mouse combo
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

Hi Philip,

> >> 1) The patch to hid2hci.c that Trevor Joynson provided and which was
> >> incorporated is not correct - and this is consistent with the reported
> >> experience of other people with the di novo laser desktop combo.
> > 
> > I have no idea what you are talking about. If you think that something
> > is wrong, please provide a patch to fix it.
> 
> I have attached the patch against hid2hci.

are you sure that we should replace 0xc70a - 0xc70e with 0x0b02? Is this
the hub and it is accepting HID reports now?

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
