Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Reply-To: edo.sevc@streamunlimited.com
To: linux-bluetooth@vger.kernel.org
From: Edo Sevc <edo.sevc@streamunlimited.com>
Subject: Concurrent BLE central and peripheral mode with BlueZ-4.101
Message-ID: <563B42D3.80208@streamunlimited.com>
Date: Thu, 5 Nov 2015 12:51:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Our embedded  platform is running Linux Kernel 4.1 and BlueZ-4.101.
We have received a new requirement to work simultaneously in LE Central 
and Peripheral modes, a functionality introduced in Bluetooth 4.1.
Would it be feasible to get the concurrent Central and Peripheral modes 
running on BlueZ-4.101 by backporting the corresponding changes from 
newer BlueZ (and kernel) versions?
Or do we have to migrate to BlueZ-5?

Many thanks,
Edo Sevc
