Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <d74d42b2ef26ceaed73c0959c81f4867.squirrel@iwavesystems.com>
Date: Fri, 15 Jul 2016 03:41:54 -0400
Subject: Bluetooth pairing failing with timeout in linux 3.10.53
From: krishnaks@iwavesystems.com
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am using TI’s Wilink8 chipset based BT module interfaced with i.Mx6
based platform over UART.
Platform is running with Linux 3.10.53 kernel and bluez 4.101 stack
Bluetooth is up and scan is working.
We are trying to pair and file transfer to the nearby bluetooth
device(Phone) with obexftp utility.

Phone is getting pairing request with PIN dialog. After entering default
PIN (i.e 0000), getting the error notice of “invalid PIN request” after
some time.

Platform side But pairing is timing out  with below log
------------------------------Log---------------------
#obexftp -b 3C:C2:43:88:4F:04 -p example.txt
Browsing 3C:C2:43:88:4F:04 ...
Connecting...failed: connect
Tried to connect for 2ms
error on connect(): Software caused connection abort
Still trying to connect
Connecting...failed: connect
Tried to connect for 526ms
The device may be out of range or turned off: Host is down
Still trying to connect
-------------------------------------------------------------------

In Platform, I did not find passkey-agent utility to bypass the Password PIN.
I did not find hci.conf. Looks like hcid.conf renamed to main.conf.

Please provide your feedback.

Regards,
Krishna

