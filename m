Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44995C7E.1090108@mail.utexas.edu>
Date: Wed, 21 Jun 2006 07:49:34 -0700
From: Philip Langdale <philipl@mail.utexas.edu>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
References: <448D88EE.3030902@mail.utexas.edu>	
	<1150540883.17539.38.camel@aeonflux.holtmann.net>	
	<4498AA79.3060709@mail.utexas.edu>
	<1150874123.3950.11.camel@localhost>
In-Reply-To: <1150874123.3950.11.camel@localhost>
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

Marcel Holtmann wrote:
> 
> are you sure that we should replace 0xc70a - 0xc70e with 0x0b02? Is this
> the hub and it is accepting HID reports now?

Ah. The diff is the wrong way round. :-)

0x0b02 is the hub and it is not accepting HID reports, which is why
you can't switch the mx-5000/dinovo adapter with hid2hci today.

--phil


_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
