Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 24 Feb 2015 17:54:49 -0800
Message-ID: <CAD0=r8wZdzJBVq3f9j9iJJOZw2T0JwNiKxto13p9MSR7uL_Ziw@mail.gmail.com>
Subject: Why is interleaved scan interleaved ? Can I fix that to do LE and
 classic at same time ?
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When I do interleaved scan on linux, it's doing LE first, for around
10 seconds, and then Classic scan for another few seconds on kernel
level.

I was playing with Bluetooth on macbook, and noticed that they do both
LE and Classic scan at once. So I tried modifying kernel, I triggered
both LE and classic scan at once by queuing both
HCI_OP_LE_SET_SCAN_ENABLE, and HCI_OP_INQUIRY and it just worked, both
LE and Classic devices were reported.

I tested that with CSR, Broadcom and Atheros chips, and all behaved well.

Is there any reason why we do interleave instead of both scans at once ?

I would be more than happy to modify 'interleaved' behaviour, to do
both LE and classic scan at same time.
