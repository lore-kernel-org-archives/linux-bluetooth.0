Return-Path: <cyrus@holtmann.org>
Message-ID: <551D879B.7020409@bitcircle.com>
Date: Thu, 02 Apr 2015 14:16:59 -0400
From: Jason Flanagan <jason@bitcircle.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: bluetoothctl Segmentation Fault on confirm
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The issue that i'm currently having with BlueZ 5.29 is that when i say 
no to confirming a passkey i get a "Segmentation Fault". I've tried 
multiple times on multiple devices and i get the same result.

bluetoothctl
[bluetooth]#agent on
[bluetooth]#default-agent
[bluetooth]# pair XX:XX:XX:XX:XX:XX
Attempting to pair with XX:XX:XX:XX:XX:XX
[CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
Request confirmation
[agent] Confirm passkey 080443 (yes/no): no
Segmentation fault

