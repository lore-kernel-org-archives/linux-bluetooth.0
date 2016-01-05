Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 5 Jan 2016 16:53:03 +0530
Message-ID: <CAKafyqoeQj+T5V0wV5v3dDDVDzueKV+ZZwxfJ+gJ05026uJFwQ@mail.gmail.com>
Subject: [Bluez-android] A/V sync is lost when audio out device is moved away
 from bluetooth adapter and back again
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear list,
I am using bluez for andoid 5.35 and testing a2dp profile. During
testing i am seeing  the below behavior.
Connect to Sony headset(Model: MH755) over A2DP  while watching video.
Audio is played on headset. But whenever i move away from bluetooth
adapter with headset and come back again, A/V sync is lost.
But when i tried the below hcitool command A/V sync was always good.
i.e when i move away from bluetooth adapter, audio packets are
dropped.

hcitool -i hci0 cmd 0x03 0x0028 "conn_handle" 0x00 0x2F 0x00.

The value 0x2F i chose by trying with different values.

Has someone already faced this problem? Shouldnt this be handled in
bluez stack code? Please share your views.

many Thanks
prabhu chawandi
