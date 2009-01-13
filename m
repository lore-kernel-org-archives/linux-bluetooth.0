Return-Path: <cyrus@holtmann.org>
Message-ID: <8db1092f0901131034i62780d1fu37459186619e74ee@mail.gmail.com>
Date: Tue, 13 Jan 2009 19:34:33 +0100
From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
To: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [2.6.29-rc1] Problem with using bluetooth adaper connected to usb port
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until 2.6.28 I use hci_usb driver to bluetooth adapter. In 2.6.29-rc1
it doesn't exists, so I switch to btusb module, and I have problem
connect with another machine, dmesg shows this message:
[  101.468638] hci_cmd_task: hci0 command tx timeout
[  699.328112] hci_cmd_task: hci0 command tx timeout

How to check what cause problems with communication?

Contents /proc/bus/usb/devicec, dmesg, lsusb, config:
http://www.unixy.pl/maciek/download/kernel/2.6.29-rc1/bluetooth/

-- 
Maciej Rutecki
http://www.maciek.unixy.pl
