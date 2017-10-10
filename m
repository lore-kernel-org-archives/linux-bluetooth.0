Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1507651475.5470.1.camel@ewol.com>
Subject: meshctl: set-pub fails
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 10 Oct 2017 10:04:35 -0600
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

discover-unprovisioned, provision, add-appkey & bind work as expected.
The meshctl's onoff client evokes expected behavior in zephyr's onoff
server.

The command being passed

set-pub 0100 c000 1 5 1000

The length of the set-pub packet exceeded the size of the data array in
struct mesh_pkt in net.c by 1. This stepped on the length field which
followed. The transmit mostly failed. The zephyr server received
nothing.

I extended the data array to 35. I now get consistent output. However,
the zephyr server is unable to decrypt with devkey. Net decrypt works,
but app decrypt fails. 

I looked at how config-client.c:cmd_set_pub handled the app key index.
According to 4.3.2.16 (pg 158) of the Mesh Profile Spec, the app key
index should be in the top 12 bits of octet 4 & 5. I shifted it up by
4, but get the same results.

I'm pretty sure the problem is on the meshctl side. I've used the
Silabs Android app to successfully configure the zephyr server. It
successfully sends a set-pub which the zephyr server correctly handles.

Maybe this is a regression. Has set-pub worked in the past?

Any idea of where to go next?

Steve
