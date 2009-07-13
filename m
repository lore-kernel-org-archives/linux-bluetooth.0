Return-Path: <cyrus@holtmann.org>
From: Marcel Witte <wittemar@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Subject: How does BlueZ work?
Date: Tue, 14 Jul 2009 00:49:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200907140049.04920.wittemar@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

at the moment I'm writing my dissertation for B.Sc. A big part contains using 
bluetooth in Linux. As I understand the layer-architecture of bluetooth all 
layers up to the HCI are implemented in the firmware of the bluetooth-device. 
The kernel-module for the device forwards the hci-commands from the 
applications to the device, this application is the bluetoothd. In bluetoothd 
the profiles as A2DP are implemented. But how does bluetoothd communicate with 
the module? Is there any device-file in /dev ? Or is there another system for 
hci?

I hope you can help me, so I don't need to read in the source-code of 
bluetoothd ;)

Greets,
Marcel Witte
