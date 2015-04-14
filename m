Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 0/6] Improvements to the LE Advertising API
Date: Tue, 14 Apr 2015 15:06:55 -0700
Message-Id: <1429049221-21984-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adds a method to add the TX Power attribute to the advertisements that are sent
through the D-Bus interface, and supports more than one advertisement based on
the maximum number reported by the kernel.

v1 -> v2:
  * Rebase
  * Bugfixes
  * Improve error messages from MGMT api
  * Fix possible issue with dbus_bool_t type
  * Patch to fix object matching
  * Fix instance ids

Michael Janssen (6):
  core/advertising: Fix dbus object matching
  doc: Add IncludeTXPower to LE Advertising API
  core/advertising: Parse IncludeTXPower
  core/advertising: Support more than one advertisement.
  test: add IncludeTXPower to example-advertisement
  core/advertising: improve errors for add advertising

 doc/advertising-api.txt    |   5 ++
 src/advertising.c          | 150 ++++++++++++++++++++++++++++++++++++++-------
 test/example-advertisement |   4 ++
 3 files changed, 137 insertions(+), 22 deletions(-)

--
2.2.0.rc0.207.ga3a616c

