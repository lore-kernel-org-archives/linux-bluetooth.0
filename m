Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: deymo@chromium.org, Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 0/4] AVRCP connection-tracking issues
Date: Thu, 23 May 2013 11:28:25 +0200
Message-Id: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patchset addresses the issues reported by Alex Deymo in the thread "audio: Connect doesn't return when audio device is off". Extracted from his message:

"There are two ways to hit this problem:
* One is to attempt a connection when the device is off,
* the other one is to attempt a connection from the host right after
you short press the button with the bluetooth logo on the speakers.
This button normally reconnects the speakers to the host, but if you
attempt a connection while the device is also doing that, you end up
in the same situation."

I have been able to reproduce the first issue, which should be fixed with patch 1/4. The second issue is addressed in patch 3/4 but I couldn't actually test it.

Patch 4/4 tries to improve the AVRCP role heuristic, which could alone fix Alex's issues, but I think the core cannot rely on this heuristic nevertheless.

Mikel Astiz (4):
  avrcp: Fix missing reply to profile connect
  control: Remove unused parameter
  avrcp: Fix service connections not reported to core
  avrcp: Don't require active sink in role heuristic

 profiles/audio/avrcp.c   | 17 ++++-------------
 profiles/audio/control.c | 37 +++++++++++++++++++++++++++----------
 profiles/audio/control.h |  7 +++----
 3 files changed, 34 insertions(+), 27 deletions(-)

-- 
1.8.1.4

