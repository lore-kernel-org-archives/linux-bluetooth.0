Return-Path: <cyrus@holtmann.org>
Message-ID: <512EB3C4.1040606@wp.pl>
Date: Thu, 28 Feb 2013 02:32:52 +0100
From: "W.P." <laurentp@wp.pl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Can I make USB sound card be available over BT? How?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi there,
I have following setup:
router with USB - TP-LINK MR-3220,
USB 2.0 hub,
CSR BT USB dongle plugged to hub,
"USB audio card" plugged to the same hub.

I use (successfully) this "card" to play internet radio (wget | madplay).

Now I want to enable this router to act as HF (stereo, A2DP?) device 
over Bluetooth.

Client would be Android 2.1 phone and/or another Linux (laptop, Fedora 16)

What modules (programs) I need (router has 4MB flash, so I need to 
"hand-craft" firmware),
and most important:how to configure it?

(do I need "nohands"? there is HF server, but it is 2 years old, and no 
contact with author).

Current software is OpenWRT trunk 33310, compiled at home. (kernel 3.2, 
uClibc).

For tests, I'll run on Fedora 16 (kernel 3.6.11).

[same question on OpenWRT forum (and Buildroot list) is still w/o 
response... :( ]

W.P.
