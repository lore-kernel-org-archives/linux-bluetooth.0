Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 6 Oct 2017 14:24:06 +0530
Message-Id: <201710060854.v968s6kT020905@web12.vgs.ws.untd.com>
From: "R. Rajesh Jeba Anbiah" <ng4rrjanbiah@rediffmail.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: "hcitool lescan" can't detect BLE simulators!
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I hope, this is the right forum, if not kindly excuse and direct me to the right forum.

I have noticed that "hcitool lescan" and "sudo bluetoothctl" can't detect app simulated beacons (For example, using
https://play.google.com/store/apps/details?id=net.alea.beaconsimulator&hl=en ). These app simulated beacons are successfully getting recognized by Android & iOS based apps.

Is there any additional check done in BlueZ to skip these app simulated beacons. If so, is there anyway to disable that?

(I'm on Raspbian GNU/Linux 9 (stretch))

TIA

___________________________

Date & Time: Fri Oct  6 2017, 02:24:06 PM IST
Sent via http://GuideMe.ITgo.com/mail

Use Quick Mail @ GuideMe.ITgo.com
(It's No Signup... No Password... Mail Service!!)
