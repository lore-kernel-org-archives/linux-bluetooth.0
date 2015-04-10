Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/4] Improvements to the LE Advertising API
Date: Fri, 10 Apr 2015 12:06:04 -0700
Message-Id: <1428692768-31941-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a method to add the TX Power attribute to the advertisements that are sent
through the D-Bus interface, and supports more than one advertisement based on
the maximum number reported by the kernel.

Michael Janssen (4):
  doc: Add IncludeTXPower to LE Advertising API
  core/advertising: Parse IncludeTXPower
  core/advertising: Support more than one advertisement.
  test: add IncludeTXPower to example-advertisement

 doc/advertising-api.txt    |  5 +++
 src/advertising.c          | 86 +++++++++++++++++++++++++++++++++++++++++-----
 test/example-advertisement |  4 +++
 3 files changed, 87 insertions(+), 8 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

