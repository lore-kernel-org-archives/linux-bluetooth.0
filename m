Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Device discovery procedure
Date: Wed, 18 Apr 2012 12:15:06 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B4836F1@DNCE05.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All,

I've looked into the adapter.c code, after I encountered a little problem. It seems that for some reason, in adapter.c, in function void adapter_set_discovering(...), which is called by mgmt_discovering(...) as a result of discovering state change, we take a decision to start a timer for rescheduling the discovery process again. This relies on the main_opts.discov_interval, and it calls the following code to start the timer:

	adapter->discov_id = g_timeout_add_seconds(main_opts.discov_interval, discovery_cb, adapter);

If the main_opts.discov_interval is equal to 0, this means that the discovery procedure will restart immediately, and loop forever until someone explicitly stops the discovery.

Is this intentional? Is this how it's supposed to work ? Is there a way to disable this behavior?


Thanks,

Chen Ganir
Texas Instruments
