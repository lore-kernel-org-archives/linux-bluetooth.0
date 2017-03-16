Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: mohammed rilwan <rilwan03@gmail.com>
Date: Thu, 16 Mar 2017 13:01:47 +0530
Message-ID: <CAMaUp9YnhzsFU3MgORzNT89xbzwnxO_ZCernUQHATBtjNXSWOA@mail.gmail.com>
Subject: no audio when mtu is 1021:8,but works aclmtu set to 1021:5
To: linux-bluetooth@vger.kernel.org,
        General PulseAudio Discussion
        <pulseaudio-discuss@lists.freedesktop.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using broadcom 20703 usb dongle on fc25.
pulseaudio,ofonod is installed. Another phone is connected to fc25 PC.

phone is paired,connected(a2dp connection established) as per btmon
logs. But no audio is audible in the PC.
strangely when i set aclmtu to 1021:5(hciconfig -a hci0 aclmtu 1021:5)
music is audible.
default aclmtu is 1021:8.

What could be the reason ?

Thanks
Rilwan
