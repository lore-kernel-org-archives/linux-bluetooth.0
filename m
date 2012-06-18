Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 18 Jun 2012 16:42:03 +0800
Message-ID: <CABM3H8CqhH_qFmpSdm5rKpRPS9P-dHGpq39zUXdWkv7syOxfRQ@mail.gmail.com>
Subject: LE Start Encryption connection timeout
From: ye janboe <janboe.ye@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

hi, All

I am developing BLE for our production, but a issue blocks me:

< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x08 handle 64 encrypt 0x00
    Error: Connection Timeout
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 64 reason 0x08
    Reason: Connection Timeout
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 64 packets 1

Does anyone have some clue why this happen?

Thanks a lot!

Yuanbo

-- 
Janboe Ye
