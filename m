Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Seulki Shin <sskcorea@gmail.com>
Date: Tue, 28 Jun 2016 17:38:01 +0900
Message-ID: <CA+ZaN38pJ-2FM9t8c+sOT+ViXvYA79YgUe=ispYKVQwZiQW0ZQ@mail.gmail.com>
Subject: Configure supervision timeout
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bluez,

Recently, I have noticed supervision timeout is not enough to pair devices.

How can I configure supervision timeout? Is there any configuration file?

First, I have checked "main.conf" but I couldn't find any related properties.
I also found /sys/kernel/debug/bluetooth/hci0 has a bunch of system settings.
But I am not sure editing those files is a right approach.

Any help would be appreciated.

Thanks,
Seulki.
