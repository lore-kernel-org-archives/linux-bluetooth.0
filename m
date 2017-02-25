Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Dor Shemer <dorshemer@gmail.com>
Date: Sat, 25 Feb 2017 16:10:39 +0200
Message-ID: <CAKwwfuT5t6ARrmhPnpTTDpyhTUZ1j+enRh1jsMMhyb5jjiaBYA@mail.gmail.com>
Subject: Unable to pair Bose QC35
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a new set of Bose QC35 that won't my pair with ubuntu 16.10
(dell xps 9550). I tried everything I could find on this mailing list
(http://marc.info/?l=linux-bluetooth&m=148314289530765&w=2) and
askubuntu.com (http://askubuntu.com/questions/833322/pair-bose-quietcomfort-35-with-ubuntu-16-04-over-bluetooth)
but nothing seems to help.

I'm trying to pair using either dual mode or bredr, as suggested in
the askubunu answer.

Using ControllerMode = dual I get:

    [bluetooth]# devices
    Device 04:52:C7:62:27:75 LE-Pigment Pete
    [bluetooth]# pair 04:52:C7:62:27:75
    Attempting to pair with 04:52:C7:62:27:75
    [CHG] Device 04:52:C7:62:27:75 Connected: yes
    Failed to pair: org.bluez.Error.AuthenticationFailed
    [CHG] Device 04:52:C7:62:27:75 Connected: no


OnControllerMode = bredr I can't even find the device, but if
remembered from the dual mode scan, I get:

    [bluetooth]# devices
    Device 04:52:C7:62:27:75 LE-Pigment Pete
    [bluetooth]# pair 04:52:C7:62:27:75
    Attempting to pair with 04:52:C7:62:27:75
    Failed to pair: org.bluez.Error.AuthenticationRejected


I'm not sure what causes this or where to keep looking, as none of the
questions I found online have this exact problem. Could you help guide
me?
