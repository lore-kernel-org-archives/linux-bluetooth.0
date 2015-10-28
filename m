Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 27 Oct 2015 21:10:49 -0700
Message-ID: <CAD0=r8zi097exhrwL8nJfUeL7wLYSHfpKYvgh33dFGcPYyoedw@mail.gmail.com>
Subject: BlueZ: btd_profile callbacks not being triggered properly for LE
 devices ?
From: Jakub Pawlowski <jpawlowski@google.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

struct btd_profile contains folowing callbacks:
.connect
.disconnect
.device_probe
.device_remove
.accept

I noticed that those callbacks:
.device_probe
.device_remove
.accept

are called properly, but:
.connect
.disconnect

callbacks are not being called at all when LE device disconnected
itself or was connected or autoconnected back. There is no doc, but
I'm guessing those should be triggered in this cases, right ? Also,
when I connect first time to a device, only .accept should be
triggered, but when I connect next time only .connect ?
Can you please explain what is the intended order of those callbacks ?
Then I can fix them if I find some discrepencies from intended
behaviour.

Jakub
