Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Marco Trapanese <marcotrapanese@gmail.com>
Subject: Programmatically change bluetooth profiles
Message-ID: <ee18cede-d567-eb86-f6bd-241aaf2875e3@gmail.com>
Date: Wed, 5 Oct 2016 07:19:56 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I'm working with bluez 5.40 on RPi3 with Raspbian Jessie Lite.
I set up my own GATT server (handled in Qt5) so the users can write a 
characteristic which their preferences about bluetooth profiles.

In detail, I'm interested to enable/disable "on-the-fly" the A2DP and 
HFP profiles.

I wonder how to do this from C++ or even from command line.
Of course I MUST avoid to restart the bluetooth service because I need 
to keep the GATT server running.

Right now I only know the class value in /etc/bluetooth/main.conf 
(currently is set to 0x0c0408). But I'm looking for something better...

Any suggestion?

Thanks
Marco

