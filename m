Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jorge Miranda <jmiranda@dei.uminho.pt>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Continuous Bluetooth discovery 
Message-Id: <E491D5C0-CCAE-4903-8DAE-23EE302BCD3C@dei.uminho.pt>
Date: Fri, 25 May 2018 19:10:31 +0100
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everybody,

I developing daemon that executes a BLE device discovery continuously, i.e. it starts when the daemon starts and only terminates when the daemon terminates. This can last for a long time; as long as the dameon runs without crashing or being killed.

I noticed a few days ago, that after leaving the daemon running for about a day, I couldn’t discover any BLE devices, or connect to a BLE device from the daemon, although the daemon was running properly because I could access to it through its API. This also applies to bluetoothctl. The only way to make the daemon work again was to restart the bluetooth service. Before this, I tried to power the adapter down and start/stop the scan through bluetoothctl, but to no avail. But I noticed that there were some Bluetooth events occurring, through btmon, when the scan was on, although nothing would come up on bluetoothctl or on my dameon. The best way I have to describe this is as if the events were queue and then were being poped.

So, is it possible that leaving the discovery running for this long can cause some issue on the bluetooth service? I noticed that on macOS, for example, a discovery would run for some time, then it stops and starts again - I presume the same happens on other OS. Should my daemon do the same? Why? For these tests I used Ubuntu 17.10 and BlueZ 5.47 (compiled from source).

I also noticed that there were some updates on the last versions of BlueZ regarding discovery. Could updating BlueZ to a more recent version solve this?

Thank you in advance!

Jorge Miranda