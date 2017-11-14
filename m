Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Tue, 14 Nov 2017 17:48:02 +0100
Message-ID: <CAOT_U5bHPVAfQsuNqsgD-i=UnNAXp5n981FTqWmuDgC-escT+A@mail.gmail.com>
Subject: Self qualification of BlueZ with LaunchStudio and Profile Tuning
 Suite (PTS)
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It seems like PTS can do the testing automatically with the DUT, a
dongle from BTSIG (https://bluetoothstore.org/) and the right test
description from Launch Studio
(https://www.bluetooth.com/develop-with-bluetooth/test-tools/profile-tuning-suite).

If anyone self qualified the BlueZ host on a product using this
method, could she/he please share the steps and experiences?

How does one work out what elements of the BT standards are required
in the product?
(to know what to include in the ICS)

Is it sufficient to say:

"We want to be a Central device that connects to Peripherals, and
interprets GATT commands" and based on that select "Central" and
"GATT" in the Launch Studio project, and fix all
conflicts/dependencies in the ICS generation step?

Be Well,
Alan
