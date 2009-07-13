Return-Path: <cyrus@holtmann.org>
Message-ID: <4A5B5E40.2070700@gmail.com>
Date: Mon, 13 Jul 2009 18:18:08 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: bluetooth_cs: schedule in atomic?
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

can (bt_cb(skb)->pkt_type & 0x80) test in bluecard_write_wakeup() be
true while called from interrupt (either directly or through
bluecard_receive()?

Thanks.
