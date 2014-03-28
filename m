Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC v3] Add Support for Read Remote RSSI
Date: Fri, 28 Mar 2014 10:37:46 +0100
Message-ID: <1395999467-29192-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Idea in this version is to start/stop read remote RSSI only 
when device is connected.
In this version there is possibility to read one time RSSI value.

v3: Idea is to register/unregister for RSSI Changed event any time.
Kernel to handle polling and notify userspace if given threshold has
been exceeded.

If we go with v3, then in Android case we will need to add more logic
to bluetoothd to cover case when Application calles Read Remote Rssi
only once. We just need to avoid letting kernel to poll without the reason.
However I do expect android application to call this read remote rssi in
a loop anyway.

To consider in v3: Do we need Unregister command or we can use Register
command with threshold equal to 0 as a unregister ?

Lukasz Rymanowski (1):
  mgmt-api: Add support for Read Remote RSSI

 doc/mgmt-api.txt | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

-- 
1.8.4

