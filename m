Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Jay Aurabind <jay.aurabind@gmail.com>
Date: Tue, 13 Jun 2017 22:57:04 +0530
Message-ID: <CAOsEZogeJC0rfMEiyr18pFoR2-=ixcaMuFNb_n8+fuDu3eAbYQ@mail.gmail.com>
Subject: RFCOMM socket receive timeout with Bluez 5, but not on Bluedroid
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am connecting to a custom bluetooth device (uses RN-42 module). I am
using SPP which I connect from Android (BlueTerm app). The device
continuously sends data through the serial port, and I keep receiving
it in the android app.

I have  pybluez based application (on Arch Linux, Bluez 5) that
connect to RFCOMM socket. This stops receiving data after few seconds,
and I get a timeout error:

Traceback (most recent call last):
  File "Launch.py", line 434, in run
    Data = self.sockRF.recv(1)
  File "<string>", line 5, in recv
bluetooth.btcommon.BluetoothError: (110, 'Connection timed out')

What could possible be the reasons?

Are there any other methods I can programmatically connect to the data
stream though Bluez 5 ?


-- 

Thanks and Regards,
Aurabindo J
