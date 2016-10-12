Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Hieu Le <hieu.le@veriksystems.com>
Date: Wed, 12 Oct 2016 23:36:31 +0700
Message-ID: <CADEmUHPSkO7bsM=FCiv2XPL0s9QEZzYyH8132FZxqpgjdiR7ew@mail.gmail.com>
Subject: BlueZ: How to collect disconnect reason
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Currently, I can capture the disconnect event by listening to a
property_changed signal of "Connected" properties under
org.bluez.Device1 interface.

However, I need to find to way to distinguish disconnection due to
various reason which is similar to the output of bluetoothd daemon
(unknown, local_host, timeout,..).

I searched all the documents. Unfortunately, I cannot find any D-Bus
API to accomplish it.

Could you please suggest me some hint?

Many thanks for your valuable input.

Regards,
Hieu.
