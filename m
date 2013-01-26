Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sat, 26 Jan 2013 00:21:10 +0000
Message-ID: <CAJ+AEyM4aZY80+Eo7g5=z+3t2fZB+n0rW6a02p8G2CJZ9JvAQQ@mail.gmail.com>
Subject: What is involved in supporting SCO packets in HCI_RAW mode?
From: Eponymous - <the.epon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

After the patch was added to btusb.c to allow ACL packets to be
sent/received in HCI_RAW mode I was wondering what would be involved
in allowing raw SCO packets to be sent/received?

This would be a useful feature for someone like me who works with
Bluetooth firmware at this level on a daily basis.

However, I can understand there may be some limitations.

Is this something that can be realistically done?

Thanks.
