Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 1 Dec 2017 11:46:42 -0800
From: Kevin Snow <Kevin@MynaBay.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <etPan.5a21b1a2.4bcf8189.3551@mynabay.com>
Subject: BlueZ Help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 
We have a product using BlueZ. The device has both BLE and BR/EDR (for Audio). When attempting to make a BLE connection from some Android devices, the connection establishes as BR/EDR. Thus, our service UUID isn’t visible and can’t be accessed. I’ve been told this is per the Bluetooth Spec, although I’ve been unable to find it in the spec. Additionally,I don’t understand why the spec would do this as it effectively makes dual mode (both BLE and BR/EDR) worthless if the connection will be BR/EDR. This problem does not happen with Apple devices. They always connect as BLE. Many Android are fine too, just not all.  

One workaround would be to expose the BLE service via BR/EDR. Has anyone done this?  

We’re very eager to wrap this up. Is there a BlueZ expert out there open to a short term contract to help us through this? Any modifications made to BlueZ would of course become part of the open source. We don’t want anything custom, just for our product to be completed.  

Thanks  

Kevin Snow  
kevin@mynabay.com


