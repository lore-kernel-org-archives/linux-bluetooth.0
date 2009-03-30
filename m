Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 30 Mar 2009 12:54:09 +0530
Message-ID: <6887eb5d0903300024m11c46c14w36ab195567453989@mail.gmail.com>
Subject: Cross compiling bluez for ARM
From: Kartikey Parmar <kartikey2781@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I have ronelix-arm-linux-4.3.3 toolchain installed on Suse 10.3
I am configuring bluez-4.30 by writing:
-----------------------------
./configure --host=arm-linux --prefix=PREFIX CC=arm-linux-gcc
CPP=arm-linux-cpp AR=arm-linux-ar STRIP=arm-linux-strip
LD=arm-linux-ld --disable-test
----------------------------
it successfully configures. but when I run "make" it shows error that
could not read libglib-2.0.so - unrecognized symbols in "src" folder
of bluez-4.30

can someone guide me how to overcome this problem?
if there is another method to cross compile bluez protocol stack for
arm pls guid me thorugh.

awaiting for reply...
Regards,

-- 
Kartikey Parmar
R&D Software Engg
Matrix Telecom Pvt Ltd
Baroda, Gujarat (India)
09879095390 (M)
