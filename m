Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <3e890f530605161349s305b64c9ve35134ad9f5f99c7@mail.gmail.com>
References: <3e890f530605131204w2980dee2v586468fed3fe16ed@mail.gmail.com>
	<1147789208.24761.73.camel@localhost>
	<3e890f530605161349s305b64c9ve35134ad9f5f99c7@mail.gmail.com>
Date: Mon, 29 May 2006 15:35:27 +0200
Message-Id: <1148909727.31689.64.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Inquiry with RSSI on Broadcom BCM2035 -
	not	supported ?
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

Hi Javier,

>         
>         simply try "hciconfig hci0 inqmode 1" and monitor with
>         "hcidump -X -V"
>         what happens if you call "hcitool scan". I've seen some
>         Broadcom chips 
>         that don't set the feature bit for inquiry with RSSI, but they
>         do
>         support it.
>         
>         Regards
>         
>         Marcel
> 
> I try the following (as root) with my D-Link DBT-122 dongle (BCM2035
> chipset):
> 
> # hciconfig hci0 inqmode
> Can't read inquiry mode on hci0: Input/output error (5)
> # hciconfig hci0 inqmode 1
> Can't set inquiry mode on hci0: Input/output error (5)

so this chip doesn't support "Inquiry with RSSI".

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
