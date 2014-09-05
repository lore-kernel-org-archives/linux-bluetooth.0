Return-Path: <cyrus@holtmann.org>
From: "Caleb Reinhold" <creinhold@lampreynetworks.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: BLE Delayed encryption change using 
Date: Fri, 5 Sep 2014 17:32:41 -0400
Message-ID: <001301cfc950$ecd06240$c67126c0$@lampreynetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

Summary:
I am attempting to reconnect to a BLE glucometer with gatttool after pairing
with bluetoothctl. A quick connection update seems to cause a large delay
(around a minute) in the transmission of the LL_ENC_REQ. 

Description:
Attempting to connect to an agent which after connecting immediately sends
an L2CAP update connection parameters request with minimum connection
interval set to 20 ms, and maximum connection interval set to 40 ms.
Increasing both values by 100 ms causes the problem to stop being generated.

The problem happens only if the dongle using the Broadcom BCM20702 chipset
is used, using a CSR8510 A10 dongle I cannot generate this issue. I am using
BlueZ 5.22, using Linux kernel 3.10.17. The hardware platform is a Utilite.

Caleb Reinhold

