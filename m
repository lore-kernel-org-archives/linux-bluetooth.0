Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Matthew Hazley <lists@matthazley.com>
Date: Wed, 18 Oct 2017 16:00:34 +0100
Message-ID: <CAPeBu71a96x2ciRKRqGis7SOeKvxEVTpRejhv+W64YONANC+2w@mail.gmail.com>
Subject: BlueZ Peripheral: Detect Connection from Remote Device and Read RSSI
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

I have a simple, BLE peripheral using BlueZ 5.47, its written in Python.

My question is this - when using BlueZ and operating as a peripheral,
is there a way to detect that a central has connected to me? Is there
a way to read the RSSI of the connection between us?

Regarding the RSSI, I did try executing the following:

"hcitool rssi <central-bdaddr>"

when I knew the central was connected to me but this failed and
replied "Get connection info failed: No such file or directory."

Any help appreciated.

Regards,
Matt
