Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Calvin Yoo <choongbeom@gmail.com>
Date: Wed, 19 Sep 2018 15:18:06 +0900
Message-ID: <CAO9gXySJQqGYsy7rNvWp=BZkiS21Ue0kqrnx_g7ibMXNcsiYrg@mail.gmail.com>
Subject: PTS test (GATT/SR/UNS/BI-01-C) failed with bluez5.4.1 stack
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm testing my device with PTS tool for bluetooth sig certification.
And the case "GATT/SR/UNS/BI-01-C" failed.
My device has QT application and bluez5.4.1 stack on linux.
Does anyone know the solution?

[PTS Log]
Test case : GATT/SR/UNS/BI-01-C started
- Running test case with ATT bearer setup over LE
- Connection setup successfully.
- LE Security not initiated due to TSPX_security_enabled value.
- Sending an ATT request with an unsupported opcode.
- Received data 010C-0000-04
- Invalid Error Code received. Expected=0x06 Received =0x4
- Connection terminated successfully.
 -Final Verdict: FAIL
GATT/SR/UNS/BI-01-C finished


Thanks,
Calvin
