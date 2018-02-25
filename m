Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Sriram V <vshrirama@gmail.com>
Date: Sun, 25 Feb 2018 16:23:25 +0530
Message-ID: <CAH9_wROtNmXdCzPRZZYup9ObiGapCd=Ku9hTX=eP=cKWtkGMcQ@mail.gmail.com>
Subject: Bluetooth sleep.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am using a BCM4339 chip. I am using android. I play audio. Pause the
audio. let the device go to sleep.

Meanwhile, I find that my BT Headset goes power off/goes to low power
mode due to inactivity. As a result of which when i wake up from
sleep. I don't see the  BT connection active. which results in the
audio being routed to the in-built speaker.

I wanted to check if this is a problem with bcm or the headset or both?

I think there should be some communication between bcm and the headset
in the background to keep the connection alive. is my understanding
correct?


Thanks,
sriram
