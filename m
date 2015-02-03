Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: Unable to setup GATT
Date: Tue, 03 Feb 2015 14:03:42 +0530
Message-id: <009701d03f8c$2a2a9730$7e7fc590$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

We are trying to setup two machines, with btgatt-server and btgatt-client
running on either side.

On btgatt-server: (--index hci0 -r)
1.	hciconfig hci0 up
2.	hciconfig hci0 leadv
3.	bluetoothd is running with -ndE option.

"Started listening on ATT channel, waiting for connections"

On btgatt-client: (--index hci0 -d <server addr>)
1.	hciconfig hci0 up
2.	bluetoothd -ndE

After running btgatt-client with above options, it gets connected to
btgatt-server and returns below error message,
"GATT Discovery procedure failed - error code 0x0a"
Which means "ATTR_NOT_FOUND", and ATT is not ready.

Could anyone please help us, if we missed any steps to make the gatt
server/client up and running?

Thanks,
Best Regards,
Bharat

