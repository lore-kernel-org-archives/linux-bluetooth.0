Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 0/8] Implement Notification / Indication TS Tests
Date: Tue, 10 Feb 2015 12:16:16 -0800
Message-Id: <1423599385-36295-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the four defined tests around the Notification and Indication 
functionality in the unit tests.  Also includes some fixes to discovery when
no handles could be found (services with no handles).

Also adds some functionality to the unit testing, to support when there is no
action required by the client and/or the server in a test, and checks for
post data transmission.

Michael Janssen (8):
  gatt-client: skip discovery with no handles
  unit/test-gatt: Add support for no-actions
  unit/gatt: Add TP/GAN/CL/BV-01-C test
  unit/gatt: Add TP/GAN/SR/BV-01-C test
  unit/gatt: add support for post-tests
  unit/gatt: Add TP/GAI/SR/BV-01-C test
  unit/gatt: Add TP/GAI/CL/BV-01-C test
  unit/gatt: minor consistency in test data

 src/shared/gatt-client.c |   9 ++
 unit/test-gatt.c         | 267 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 254 insertions(+), 22 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

