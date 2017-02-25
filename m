Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Tallo Tallo <octavio.santana@gmail.com>
Date: Sat, 25 Feb 2017 18:14:42 +0100
Message-ID: <CAN_hsJS3j8XpTJS-8mvXmSg5bCci6+iYzs9=xTZ0U5noXhmsFg@mail.gmail.com>
Subject: i need to send a known number of beacons.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
I am analysing the performance of my RPi3 Bluetooth IC (ble beacons point
of view), to draw some more accurate curves, I would like to be able to
send a known number of frames to my RPI from another computer, then I would
be able to check the number of frames received Vs. the number of sent
frames, and so on,...

So far I have seen ibeacons code where lower layers takes care of automatic
resending, and this was good until know, but I am seeing some discrepancies
I cannot explain.

So the question is how can i send a known number of frames? could you give
me some guidance or point me in the right direction? I have coded my
applications, not afraid of write some more code.

With Kind Regards
O.
