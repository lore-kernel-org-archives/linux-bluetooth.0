Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 5 Feb 2009 17:23:19 +0530
Message-ID: <c2a31c480902050353t23c5739cqc69df0e6c2024048@mail.gmail.com>
Subject: skype VOIP calls using bluetooth headsets
From: sreevani medhahal <sreevani.medhahal@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
 Kernel:2.6.27
 BlueZ:latest
After answering the received skype call(Accept Call) ,if the Bluetooth
headset is switched off, after i change the skype Options to default
speakers i am able to hear from default speakers. But if the headset
is switched off when the RING is received , even after changing the
SKype Sound Options to Default Speakers, i can't hear the audio from
the default Headset.
a)Can any one help me what interface in BlueZ needs to looked into to
fix the above (or this is nothing to do with BlueZ) ?
b) How does skype talk to BlueZ ,i see that BT_GETCAPABILITIES_REQ
(unix.c) is received on starting Skype with Sound Options set to
Bluetooth headset.?

Thanks & Regards,
Sreevani M
