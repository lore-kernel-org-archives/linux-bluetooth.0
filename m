Return-Path: <nicolasiooss@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Gustavo Padovan <gustavo@padovan.org>, linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: Bluetooth: always-true condition in dtl1_confcheck
Message-ID: <7ce36049-55f9-c540-6f63-f513f3d7201a@m4x.org>
Date: Sun, 15 Jan 2017 12:04:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Since commit 00990e7ce0b0 ("pcmcia: use autoconfiguration feature for
ioports and iomem") function dtl1_confcheck() starts with the following
statements (in drivers/bluetooth/dtl1_cs.c):

    static int dtl1_confcheck(struct pcmcia_device *p_dev, void *priv_data)
    {
        if ((p_dev->resource[1]->end) || (p_dev->resource[1]->end < 8))
            return -ENODEV;

The condition in the if statement is always true and the compiler
reports an issue when building with -Wlogical-op. What was the condition
supposed to be?

Thanks,
Nicolas
