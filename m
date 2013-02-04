Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 0/3] SDP library invalid memory access fixes
Date: Sun,  3 Feb 2013 21:20:42 -0400
Message-Id: <1359940845-14451-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This small set of patches fixes a couple of invalid memory reads/writes
detected by code inspection and confirmed by emulating invalid PDUs.

BTW, I have been silently working for some time on a tool now called "Blueish"
(variant of "bluish", meaning "somewhat blue"). It is fully written in Python
and allows to "easily" generate automated standalone test scripts (that also
only require Python + D-Bus/GLib bindings) for testing scenarios difficult on
real hardware. It uses VHCI for emulation.

For documentation and code, see: https://github.com/lizardo/blueish

The repository contains example data files for the latest patches I sent a
while ago (and these ones).

I tried to make it easy to use by adopting YAML for HCI packet construction.
Still, I'm aware that constructing HCI packets by hand is error prone, so I
plan (someday) to have a nice GUI and even some sort of visualization for the
packets (message sequence charts, maybe?).

That said, I'm still interested on helping with improving unit tests for BlueZ
(specially code not touched for a while). I just could not come up with a nice
way to integrate SDP client unit tests with the current server ones without too
much code duplication.

Best Regards,

Anderson Lizardo (3):
  lib: Fix buffer overflow when processing SDP response
  lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP
  lib: Check if SDP buffer has enough data on partial responses

 lib/sdp.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
1.7.9.5

