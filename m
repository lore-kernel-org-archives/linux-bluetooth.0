Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ 0/3] Add TX Power to LE Advertisement API
Date: Thu,  9 Apr 2015 10:37:18 -0700
Message-Id: <1428601041-27353-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a method to add the TX Power attribute to the advertisements that are sent
through the D-Bus interface.

Michael Janssen (3):
  doc: Add IncludeTXPower to LE Advertising API
  core/advertising: Parse IncludeTXPower
  test: add IncludeTXPower to example-advertisement

 doc/advertising-api.txt    |  5 +++++
 src/advertising.c          | 31 ++++++++++++++++++++++++++++++-
 test/example-advertisement |  4 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.2.0.rc0.207.ga3a616c

