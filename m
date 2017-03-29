Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?Q?Gr=c3=a9goire_Gentil?= <gregoire@gentil.com>
Subject: Clarification on tools/eddystone.c - how to advertise the simplest
 way
Reply-To: gregoire@gentil.com
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@codecoup.pl
Message-ID: <09879cf1-b181-1850-5f54-c0abf440ff4f@gentil.com>
Date: Tue, 28 Mar 2017 18:31:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,


I have an embedded device and I want to advertise using BLE. This code 
compiles against the bluetooth library and actually works (even without 
bluetoothd running):

https://github.com/carsonmcdonald/bluez-experiments/blob/master/experiments/advertisetest.c

I see the advertising on an Android phone.


I was looking for a more comprehensive and cleaner example. I was told 
to use tools/eddystone.c

I have compiled the following files together:

src/shared/hci.c
src/shared/io-mainloop.c
src/shared/mainloop.c
src/shared/queue.c
src/shared/timeout-mainloop.c
src/shared/util.c
tools/eddystone.c

but when I run eddystone, nothing happens. Nothing is advertised. What 
am I missing? Note that I have to "hciconfig hci0 down" to run 
eddystone. Am I misunderstanding what eddystone is supposed to do?


My objective is to advertise and to listen to advertising the simplest 
way (without d-bus or bluetoothd daemon)? I'm fine to compile against 
the bluetooth library if needed. What is the best starting point?


Grégoire
