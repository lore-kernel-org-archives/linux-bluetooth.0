Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: sudeepta bhuyan <sudeepta.bhuyan@gmail.com>
Date: Mon, 12 Feb 2018 16:52:16 +0530
Message-ID: <CA+TC0NqnhXH=jxSoV-XhkDJ05S7evYJhW28peD4LPAnSRn3spw@mail.gmail.com>
Subject: hciattach alternative to change default address after upgrading to
 BlueZ 5.47
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

Prior to upgrading BlueZ to 5.47 in my project, I was using hciattach
to set the UART device's address before starting bluetoothd.

hciattach /dev/ttyS2 bcm43xx flow nosleep xx:xx:xx:xx:xx

However since hciattach is deprecated in newer BlueZ, I am now using
btattach instead to do the same. But btattach does not provide an
option to set the bluetooth address of the device.

What is the standard procedure to set the bluetooth address of the
UART device using newer BlueZ tools?

Thanks,
Sudeepta
