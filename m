Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 1 Sep 2015 15:19:38 +0800
Message-ID: <CAGQ70euRR__Vv25Z9kvj6EfXyFruU36sYC82RrN8ijg_rdpYUA@mail.gmail.com>
Subject: SMP Security Request breaks previously working bluetooth mouse
From: Oon-Ee Ng <ngoonee.talk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I refer (to the best of my knowledge) to the patch submitted in [1].

When upgrading from 4.1.5 to 4.1.6 (Arch Linux), my Lenovo N700
Bluetooth mouse stops working. Downgrading fixes, hence unlikely to be
a hardware issue.

When on 4.1.6 (bugged version) dmesg spams this every 3 minutes or so:-
Bluetooth: SMP security requested but not available

Please advise on additional details which may be required.

[2] is my original bug report in my distro's channel, including the
above details in a bit more verbose form.

[1] - https://lkml.org/lkml/2015/8/14/369
[2] - https://bugs.archlinux.org/task/46006
