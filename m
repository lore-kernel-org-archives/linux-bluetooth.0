Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: HID Over GATT implementation
Date: Sun, 11 Mar 2012 12:54:57 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B44D1AB@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

I have started the development of the HOGP (HID Over GATT Protocol) for the BlueZ Stack. The main idea of this adopted profile is to allow HID devices to operate over the low energy technology.

The HID Over GATT Profile includes the following services :
1. Battery Service - allows the host to gather and display information regarding the peer device battery/batteries state.
2. Device Information Service - This service contains misc identification data of a device. The HOGP will use the PNP ID field.
3. HID Service - This service contains the main logic for the HOGP, and acts as a proxy between the remote device and the local HID subsystems.
4. Scan Parameters Profile - contains information on connection parameters, recommended by the host.

The next patche set will add Battery Service and Device Information Service plugin stubs.


Chen Ganir
Texas Instruments
