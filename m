Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>, Alex Gal <a.gal@miip.ca>,
	Laurence Brown <linux-bluetooth@protazoa.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 0/5] sixaxis: Improved support for DualShock 3 clones
Date: Mon, 15 Jun 2015 20:28:25 +0200
Message-Id: <1434392910-31648-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is improved version of sixaxis patches. Comparing to RFCv2 this
doesn't regress with Navigation Controller and DS4.

Sixaxis specific code needs to be left in input code for DS4 support.

If people report that this works for them I'll push those patches.


>From RFCv2 cover letter:
Some DualShock3 clones (eg ShanWan) were reported to not provide valid SDP
record required by HID profile. Due to this those failed to work with
current BlueZ sixaxis code (ie no input device were created).

This small serie is an attempt to extend DS3 support also with those
misbehaving clones. Idea is that we can provide fixed SDP recrod for devices
that use valid PID/VID and skip SDP search.

In this version SDP is kept in sixaxis plugin and provided via
btd_device_set_record instead of SDP search. Nice addition is that
sixaxis specific code is no longer needed in input server.

This makes code similar to how original Fedora sixaxis plugin worked
as suggested in previous review round.

I tested this with genuine DS3 and it seems to work OK. Testing with
clones is stil required though.


Szymon Janc (5):
  sixaxis: Fix PID for Navigation Controller
  core/device: Add support for setting SDP record
  sixaxis: Provide DualShock 3 SDP record while adding new device
  profiles/input: Remove not needed sixaxis checks
  sixaxis: Fix multi-line comments style

 Makefile.plugins        |   1 +
 plugins/sixaxis.c       | 195 ++++++++++++++++++++++++++++++++++++++++++++++--
 profiles/input/server.c |   8 --
 src/device.c            |  31 ++++++++
 src/device.h            |   3 +
 5 files changed, 224 insertions(+), 14 deletions(-)

-- 
2.1.4

