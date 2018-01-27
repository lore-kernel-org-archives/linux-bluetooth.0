Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Sriram V <vshrirama@gmail.com>
Date: Sat, 27 Jan 2018 22:56:36 +0530
Message-ID: <CAH9_wRP6ENEa8MmsuqD4R-TR=SpJdaoi22BLHM8A4LNGPP29Fg@mail.gmail.com>
Subject: Purpose of line discipline in bt drivers
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am facing broken audio issues when using the broadcom bt chip
especially when it comes back from suspend. While debugging the issue,

What is the purpose of doing a registering a ldisc in the driver using
the call tty_register_ldisc call() in Bluetooth drivers which deal
with power management.

I am referring to the below driver:
https://android.googlesource.com/kernel/bcm/+/android-4.4w_r6/drivers/misc/bcm-bt-lpm.c

Thanks for your help.
Sriram
