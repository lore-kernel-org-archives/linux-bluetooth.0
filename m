Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 0/5] gattrib: Registering per-handle event listeners
Date: Mon,  8 Oct 2012 21:26:07 -0300
Message-Id: <1349742372-18420-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This RFC is mostly to gather some comments about the idea, and see if
anyone can see any problem with it.

As we are starting to have devices that support multiple profiles,
something like this is inevitable, if we want to avoid having every
profile getting notified for each notification/indication received.

Cheers,
--

Vinicius Costa Gomes (5):
  gattrib: Add support for listening for events for specific handles
  scan: Use the per handle GATT event notifier
  hog: Use the per handle GATT event notifier
  heartrate: Use the per handle GATT event notifier
  gas: Add the per handle GATT event notifier

 attrib/client.c                    |   4 +-
 attrib/gattrib.c                   |  33 ++++-
 attrib/gattrib.h                   |   7 +-
 attrib/gatttool.c                  |   8 +-
 attrib/interactive.c               |   8 +-
 profiles/gatt/gas.c                |  71 +++++----
 profiles/heartrate/heartrate.c     | 287 +++++++++++++++++++------------------
 profiles/input/hog_device.c        |  65 +++++----
 profiles/scanparam/scan.c          |  15 +-
 profiles/thermometer/thermometer.c |   2 +
 src/attrib-server.c                |   2 +-
 11 files changed, 262 insertions(+), 240 deletions(-)

-- 
1.7.12.2

