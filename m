Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: After bluetoothd disconnects a LE device only restart of kernel modules allows it to reconnect
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <562BBBFF.9000805@steev.me.uk>
Date: Mon, 26 Oct 2015 05:09:55 +0900
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <1E7A740C-DA0A-45F0-8F03-BA21BC5F37B2@holtmann.org>
References: <562BBBFF.9000805@steev.me.uk>
To: Steven Davies <linux-bluetooth-list@steev.me.uk>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

> I'm using bluez-5.35 with kernel 4.2 and am seeing that after a while (could be minutes, hours or days, I don't know what the trigger is) a BLE device will disconnect and the only way to reconnect to it is to rmmod the bluetooth  modules and re-modprobe them. Obviously this shouldn't happen. I'm seeing the following output from bluetoothd (sorry for the huge log, let me know if a full pastebin would be better). Can anyone offer any insight into why once this happens, I can't talk to the device through Bluetooth?

can you also show the btmon for this situation. And any chance to test 4.2.x stable kernel. A few patches went into stable kernel that might fix this. I would be also great if you can do a quick test with 4.3-rc7 and bluetooth-next kernels to see if this might be something that we already fixed.

Regards

Marcel

