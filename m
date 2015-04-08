Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>, Alex Gal <a.gal@miip.ca>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC v2 0/3] sixaxis: Improved support for DualShock 3 clones
Date: Wed,  8 Apr 2015 22:51:28 +0200
Message-Id: <1428526291-11217-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

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

@Alex
Testing with Navigation Controller is also needed ie if SDP record
is same as with DS3 or if we need dedicated one.

BR
Szymon Janc


Szymon Janc (3):
  core/device: Add support for setting SDP record
  sixaxis: Provide DualShock 3 SDP record while adding new device
  profiles/input: Remove sixaxis specific code

 Makefile.plugins        |   1 +
 plugins/sixaxis.c       | 166 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/input/server.c |  89 +-------------------------
 src/device.c            |  31 +++++++++
 src/device.h            |   3 +
 5 files changed, 203 insertions(+), 87 deletions(-)

-- 
2.1.4

