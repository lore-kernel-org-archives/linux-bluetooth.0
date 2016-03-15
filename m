Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Mar 2016 14:55:13 +0100
Message-ID: <CADGFtMXS0+XWywLJ_=0B_xWaHLCKUKK4HC+ge+3d_G5X_v7z0A@mail.gmail.com>
Subject: device keeps being found and removed
From: Luca Dionisi <luca.dionisi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've got this problem on a bq ubuntuphone.
I've used a bluetooth keyboard with it several times. Today I pressed
a button "forget this device" on the UI of the phone. Afterwards I
cannot see the keyboard again when a scan is performed.
I connected to the phone with ssh and found that a CLI tool was
present: bluetoothctl.
>From this tool, when I press the pairing button on the bluetooth
keyboard I see a message with NEW followed immediately by a message
with CHG and one with DEL referring to the keyboard.

What's the problem?

TIA. Best regards.

--Luca
