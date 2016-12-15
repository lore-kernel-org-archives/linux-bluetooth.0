Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Timothy Barnes <timothy@veratekdesign.com>
Date: Thu, 15 Dec 2016 11:12:52 -0800
Message-ID: <CAJdzENOO89+4=XqPFQ8yuZnL0TYJ_mkm+k6xBdME7tcXQP8axA@mail.gmail.com>
Subject: Question about Bluez /peripheral code
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am trying to write a simple C language HID peripheral device with
NoInputNoOutput style authentication.

1. Are the files in bluez /peripheral all that is necessary (in user
space) to run a Bluetooth peripheral devices? Does /peripheral support
the HID profile?

2. Is there any C example code of using either the /peripheral code or
src/shared to create a HID peripheral device?

A little bit more background:
I have been working with a version of hidclient.c, which is a GPL
licensed project for a virtual Bluetooth keyboard and mouse. This
program was originally written in 2006.

My problem with hidclient.c is that it does not handling re-connection
correctly, such as a laptop being powered off and on again and still
retaining the connection to the Bluetooth HID device. It also requires
bluetoothd to be running in compatibility mode.

I am looking for a modern C language HID peripheral server that is
known to work well with re-connection.

I am using an ARM processor running Debian Jesse with BlueZ 5.23.

Thanks for your time.
