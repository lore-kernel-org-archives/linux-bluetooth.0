Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/4] Cleanup browse_req
Date: Wed,  8 Feb 2012 17:35:45 -0300
Message-Id: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series does some cleanup in struct browse_req. This series
depends on the last series I just sent to the ML.

BR,

Andre

Andre Guedes (4):
  device: Use att_io in device_browse_primary
  device: Remove unused function parameter
  device: Move GAttrib reference to device
  device: Remove unused fields from browse_req

 src/device.c |   54 +++++++++++++++++++++---------------------------------
 1 files changed, 21 insertions(+), 33 deletions(-)

-- 
1.7.9

