Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAO9gXySJQqGYsy7rNvWp=BZkiS21Ue0kqrnx_g7ibMXNcsiYrg@mail.gmail.com>
References: <CAO9gXySJQqGYsy7rNvWp=BZkiS21Ue0kqrnx_g7ibMXNcsiYrg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 19 Sep 2018 14:58:54 +0300
Message-ID: <CABBYNZLjFLBt3XdLHuWnaqvznVJt+M3po3t0EEZwym3TKZEmQQ@mail.gmail.com>
Subject: Re: PTS test (GATT/SR/UNS/BI-01-C) failed with bluez5.4.1 stack
To: Calvin Yoo <choongbeom@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Calvin,

On Wed, Sep 19, 2018 at 9:18 AM, Calvin Yoo <choongbeom@gmail.com> wrote:
> Hello,
>
> I'm testing my device with PTS tool for bluetooth sig certification.
> And the case "GATT/SR/UNS/BI-01-C" failed.
> My device has QT application and bluez5.4.1 stack on linux.
> Does anyone know the solution?
>
> [PTS Log]
> Test case : GATT/SR/UNS/BI-01-C started
> - Running test case with ATT bearer setup over LE
> - Connection setup successfully.
> - LE Security not initiated due to TSPX_security_enabled value.
> - Sending an ATT request with an unsupported opcode.
> - Received data 010C-0000-04
> - Invalid Error Code received. Expected=0x06 Received =0x4
> - Connection terminated successfully.
>  -Final Verdict: FAIL
> GATT/SR/UNS/BI-01-C finished

This has been fixed upstream for a while:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/shared/att.c#n770

Either backport the fixes or upgrade BlueZ, which I strongly
recommend, to more recent version.

-- 
Luiz Augusto von Dentz
