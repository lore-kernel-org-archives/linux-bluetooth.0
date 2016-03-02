Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Wed, 2 Mar 2016 08:31:58 +0100
Message-ID: <CAEZxfGPvzMVj++anQKY_6RREvmyT-vBnWqYpRiHJVvKKKb3YsQ@mail.gmail.com>
Subject: Write should return error if device is disconnected while expecting a response
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When writing to a characteristic and that a disconnection happens
before getting a write (error) response, BlueZ should inform that
write operation failed.
See my real example logs below:

[DFU_Test:/service000c/char000d]# write 01 04
Attempting to write /org/bluez/hci0/dev_F1_6F_DE_EC_F1_D6/service000c/char000d



< ACL Data TX: Handle 32 flags 0x00 dlen 9
                                                   [hci0] 5.066808
      ATT: Write Request (0x12) len 4
        Handle: 0x000e
          Data: 0104
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                    [hci0] 5.106370
        Num handles: 1
        Handle: 32
        Count: 1
> HCI Event: Vendor (0xff) plen 7                                                                                         [hci0] 5.579396
        82 12 95 40 10 36 59                             ...@.6Y
> HCI Event: Disconnect Complete (0x05) plen 4                                                                            [hci0] 5.580376
        Status: Success (0x00)
        Handle: 32
        Reason: Connection Timeout (0x08)
@ Device Disconnected: F1:6F:DE:EC:F1:D6 (2) reason 1
