Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: "complex" Bluetooth handling
To: linux-bluetooth@vger.kernel.org
Message-ID: <c290d35f-1637-1199-11a2-e2424262b175@gmail.com>
Date: Wed, 15 Jun 2016 07:10:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm working on an unattended machine (i.e. with no direct user 
interaction) which should handle the following Bluetooth features:

- A2DP
- AVRCP
- HFP
- GATT server
- ANCS consumer

all at the same time. I mean, the user might listen to a song and answer 
to incoming calls, while he's receiving the ANCS notifications and 
exchanging data through a custom GATT profile.

I have a USB / BT,BLE dongle and I'm using Raspbian Jessie with bluez 5.40.
Right now I'm just trying to make the things work before write a C++ 
application which manages all the stuff.

First question:

1. I mainly find Python scripts, but I'm interested into Qt5/C++ 
libraries. Is there something out there? Before write a new one from 
scratch....

2. Do you know any working example to subscribe to ANCS push notifications?

3. Do you have any suggestion about how to handle all those profile 
together?

Thanks!
Marco

