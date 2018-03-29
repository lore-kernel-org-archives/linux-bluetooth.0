Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: ken Clark <kenidevices@gmail.com>
Date: Thu, 29 Mar 2018 08:43:29 -0400
Message-ID: <CANB6vTuaGyc1Jjok_TfKF7PU2ymviBFEd9y1V6nOT+TRw64zxQ@mail.gmail.com>
Subject: BlueZ Peripheral & central Application
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We are attempting to create a BlueZ application for an embedded linux
device that performs the following tasks:

Advertises as a peripheral
Declared a peripheral GATT database
Accepts connections as a peripheral.
Scans and connections to other peripherals as the central devices

I've been working with the BlueZ code for a while now, and see all the
pieces in various codebases, but I have failed in attempting to
understand how the combine them.

client/bluetoothclt  allows for setting advertising data
It see options for declaring services & characteristics, but have no
idea how and what order to use them in to successfully declare the
gatt database.

tools/btgatt-server allows for declaring the GATT Database and
accepting connections as a peripheral.


Can someone provide tips, examples or documentation on how to combine
these functions into a single application.

Thanks
Ken
