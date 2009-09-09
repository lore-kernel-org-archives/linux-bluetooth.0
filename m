Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 9 Sep 2009 12:42:52 +0530
Message-ID: <6887eb5d0909090012w14525861v8e9aed7e86b63b25@mail.gmail.com>
Subject: ARM Bluez run error
From: Kartikey Parmar <kartikey2781@gmail.com>
To: Linux_Arm <linux-arm@lists.arm.linux.org.uk>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear friends,

I have installed linux kernel 2.6.30 and bluez 4.30 on my board.

I have attached USB Bluetooth adapter with board and trying to get
adapter id using hci_get_route(NULL) function call.

When it executes my test program it give me error that "No such device".

If I compile same application to execute on my PC, it executes perfectly.

On the board I have copied only libbluetooth.so.2

What will be its remedie?

-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
