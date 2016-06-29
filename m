Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 29 Jun 2016 17:07:53 -0400
From: Craig Andrews <candrews@integralblue.com>
To: linux-bluetooth@vger.kernel.org
Subject: systemd service hardening
Message-ID: <7c5ca1d4dd4aac0e52ee10ec7d9b81ba@integralblue.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've been on a bit of a mission lately to improve the hardening of 
systemd services wherever I can find them. Today, I ran across this one.

I believe the hardening of the bluetooth.service ( 
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/bluetooth.service.in 
) can be easily improved by adding these 2 lines:
PrivateTmp=true
NoNewPrivileges=true

If there is agreement, can a committer please make this change?

Thanks,
~Craig
