Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 22 Feb 2011 09:43:48 -0300
Message-ID: <AANLkTin7W9jtfAmV4vo9E+YOrkUfrWpO0-B_jzkXZChm@mail.gmail.com>
Subject: Help hcitool cmd (hci to connect)
From: Thibaut L <thibaut.dvr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear all,

Please, could anyone tell me how to connect to a bluetooth device
through hcitool (BlueZ) hci command. Like this: "hcitool cmd 0x01
0x0005 [parameters]". How can I input this cmd? Is the [parameters] a
bt device MAC adress like XX:XX:XX:XX:XX:XX?

I've tryed to use "hcitool cc <MAC>", but it doesn't work for me cause
it disconnects the device a second later.

I just wanna measure RSSI.

Thanks in advance.

Best

Thibaut
