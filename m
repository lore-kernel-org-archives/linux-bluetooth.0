Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: "Arun K. Singh" <arunkat@gmail.com>
Date: Thu, 30 Jul 2015 15:29:37 +0900
Message-ID: <CAOnmHE9V9iJjbtTLvfS+pFYCaZGmSj4Z6ZK28-ER0K=CZH4TLQ@mail.gmail.com>
Subject: Enabling continuous LE Active scan in 5.32?
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I am trying to enable continuous LE active scan in Bluez 5.32.
Platform is Raspberry Pi with kernel 3.18.7+. I find no param in
adapter-api.txt, to set LE scan interval/window. btmgmt offers some
respite but setting scan window and interval to same value(via
scan-params) it still it takes around ~2 sec to trigger next scan.
Thoughr BT specs says that if scan interval and scan window are same,
it should trigger continuous scan.

Checking adapter.c, adapter->no_scan_restart_delay parameter looks
promising if set to true. Still same result - next scan delay ~ 2 sec.
Not sure if such delay is intentional or platform performance related
My question is :- Is there a neat way to trigger continuous active LE
scan even though it may sound power-wise inefficient. Tried to grep
archives but couldn't find much help.

Any cues would be helpful.

Thanks,
-Arun
