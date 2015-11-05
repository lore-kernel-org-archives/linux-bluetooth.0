Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: tony <tony.makkiel@convergeddevices.net>
Subject: BlueZ 5 : Tool recommendation for scripts
Message-ID: <563B6FFF.90703@convergeddevices.net>
Date: Thu, 5 Nov 2015 15:04:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,
	What is the recommended BlueZ 5 tool to connect a device from scripts?

'bluetoothctl' is very good in interactive mode. I tried using 'hcitool' 
+ 'simple-agent'. But they do not seem to detect device unless a scan is 
initiated from 'bluetoothctl' first.

hcitool scan does scan and find devices. But simple-agent returns

Exception: Bluetooth device not found.

bluetoothctl commands which does not take much time could be run from 
scripts.

eg:
#!/bin/bash
bluetoothctl << EOF
power on
EOF

But starting a scan does not work, because it exits before the scan is 
complete.

Many Thanks,
Tony
