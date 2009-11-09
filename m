Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 9 Nov 2009 14:36:53 +0530
Message-ID: <912bb79a0911090106o6704e144y72fb9150865bc50d@mail.gmail.com>
Subject: Pair device list query
From: nirav rabara <niravrabara@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am newbie to Bluez-bluetooth and using bluetooth v2.0 dongle with my
custom board.

I want to access this paired device list frequently and some time need
to delete any of the paired device of list.
According to my understanding bluetoothd will create folder (MAC
address as name), in that folder one file name linkkeys having the
detail of all the paired device address with link keys.
Is this the only way to get paired device list? OR Is there any
specific data structure in bluez stack code??

Or if somebody can guide me what should I read for above.

Thanks in advance.

-- 
With Regards,
Nirav Rabara
