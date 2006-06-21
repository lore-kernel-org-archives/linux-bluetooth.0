Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Mingfan lu <lucharse@yahoo.com.cn>
In-Reply-To: <20060621080938.23246.qmail@web15801.mail.cnb.yahoo.com>
References: <20060621080938.23246.qmail@web15801.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 10:21:28 +0200
Message-Id: <1150878088.3950.22.camel@localhost>
Mime-Version: 1.0
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel]
	=?utf-8?b?5Zue5aSN77yaIFJlOiAgUkXvvJogUkU6IEZXRA==?=
	=?utf-8?q?=EF=BC=9A_Re=3A_Re=3ARequest_with=09RSSI?=
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

Hi,

> mylinux:/home/lucharse/ContentPushing # hciconfig hci0 version
> hci0:   Type: USB
>         BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP
> Subver: 0x1f4
>         Manufacturer: Integrated System Solution Corp. (57)

this chips firmware is totally broken. I just checked mine and I am
seeing the same. No Inquiry with RSSI Result events.

However their support for Inquiry with RSSI is simply not there. See my
tested inquiry mode settings:

# hciconfig hci0 inqmode 5
# sudo hciconfig hci0 inqmode
hci0:   Type: USB
        BD Address: 22:22:22:22:22:22 ACL MTU: 678:8 SCO MTU: 48:10
        Inquiry mode: Unknown (0x05)

So they store the value somewhere, but that's it.

If you wanna really use Inquiry with RSSI, then you might wanna make
sure you get a CSR BlueCore4 based dongle. They simply work.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
