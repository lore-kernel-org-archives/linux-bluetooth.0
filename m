Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Mon, 31 Aug 2015 15:51:25 +0900
Message-ID: <CAOnmHE88hWsMD2Tx99nbQTcvMWNDcMgo4UWofzjPjDgErYrXhg@mail.gmail.com>
Subject: Re: BLE Advertise and Scan at the same time?
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> Is it possible to advertise (leadv) and scan (scan on) using the same
>> ble adaper?
>> The moment that I enable scanning (scan on) with bluetoothctl, leadv
>> is disabled.

>that depends on the Bluetooth chip you are using. Inside the kernel we currently play it safe and >disable one when we start the other. It will be however re-enabled when the scan finished. You >need to use btmgmt and not hcitool. Using hcitool messes with raw HCI packets. The kernel logic >will always overwrite these as it sees fit.

>To allow simultaneous states, someone would have to work on that and figure out which chips >support what. Once that is done, there is no problem in lifting some of the restrictions we imposed.

May I know what these restrictions are? I have a CSR8510 based USB
dongle which seems to support simultaneous BLE scan/adv. My only
problem would be to get rid of these restrictions in kernel to achieve
a simultaneous BLE adv/scan operation.

Thanks,
-Arun
