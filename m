Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE SM Testing
Date: Sun, 18 Dec 2011 12:19:26 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B02607D2C752@DNCE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.
Does anyone have an idea how can I establish an LE link with SM fixed channel to a remote peer to test the SMP functionality ? I do not see any possibility to do this at the moment. Hcitool does not connect the SMP, and btiotest requires a remote l2cap channel listener other than the SMP. Gatttool will not help as well, since it requires an ATT server at the peer device.

Thanks,
Chen Ganir 
