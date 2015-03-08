Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Veseli Veseljko <veseljko75@gmail.com>,
	Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 0/2] input: Improved support for DualShock 3 clones
Date: Sun,  8 Mar 2015 17:08:28 +0100
Message-Id: <1425830910-9549-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Some DualShock3 clones (eg ShanWan) were reported to not provide valid SDP
record required by HID profile. Due to this those failed to work with
current BlueZ sixaxis code (ie no input device were created).

This small serie is an attempt to extend DS3 support also with those
misbehaving clones. Idea is that we can provide fixed SDP recrod for devices
that use valid PID/VID even if SDP search failed.

This was tested only with genuine controller (with crippled SDP code) so
before I consider this code ready for inclusion it needs to be tested
on clone devices.

BR
Szymon

Szymon Janc (2):
  core/device: Add support for setting SDP record
  profiles/input: Add support for SDP fallback for DualShock 3 clones

 profiles/input/server.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/device.c            |  37 ++++++++++
 src/device.h            |   3 +
 3 files changed, 224 insertions(+), 7 deletions(-)

-- 
2.1.4

