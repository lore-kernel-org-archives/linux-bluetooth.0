Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 1 Jun 2009 14:03:01 -0700
Message-ID: <d4029b2f0906011403u5f09b71ds79a5aaafe4538791@mail.gmail.com>
Subject: no reply from my cellphone to AT commands
From: BlueZ Newbie <blueznewbie@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I connected my cell phone Samsung Blackjack to my PC on Linux (Fedora
10) using bluez stack.

The steps I am following are:
1. rfcomm connect 0 xx:xx:xx:.. 4
    I used channel 4 because my SDP (service discovery using sdptool)
("sdptool search SP") shows serial port profile to be available on
channel 4.
2. rfcomm succeeds in connecting
3. Then, I launch cutecom or minicom serial terminal using
/dev/rfcomm0. cutecom connects to my cell phone.
4. I send AT commands and my cell phone "blinks" in acknowledgment.

But, no response from the cell phone. I verified that RFCOMM TTY is
configured on my system.

Any hints?

Thanks
