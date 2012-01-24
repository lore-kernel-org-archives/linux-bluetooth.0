Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: keybuk@chromium.org, Scott James Remnant <scott@netsplit.com>
Subject: [PATCHv2 0/8] Generate PIN for keyboards inside bluetoothd
Date: Mon, 23 Jan 2012 16:27:44 -0800
Message-Id: <1327364872-32313-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the comments on my RFC patch set, I've addressed those in
this new version which I'm now submitting formally.

The main changes are:
 - bt_ids.h moved to src/
 - a D-Bus error from calling DisplayPinCode results in a fallback to
   calling RequestPinCode instead
 - PIN isn't sent to the adapter until a successful reply from either
   DisplayPinCode or RequestPinCode

This grew the patch a bit unsurprisingly, so I've split it up a fair
amount more - including separating out the documentating and tests
as requested.

Scott James Remnant (8):
  bt_ids: add header of device class constants
  Rename AUTH_TYPE_NOTIFY to AUTH_TYPE_NOTIFY_PASSKEY
  Pass passkey by pointer rather than by value
  agent: add DisplayPinCode method
  Add AUTH_TYPE_NOTIFY_PASSKEY to device_request_authentication
  Generate PIN for keyboard devices
  doc: document DisplayPinCode
  simple-agent: add DisplayPinCode

 doc/agent-api.txt |   24 ++++++++++
 src/agent.c       |  112 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/agent.h       |    4 ++
 src/bt_ids.h      |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.c      |   72 +++++++++++++++++++++++++++---
 src/device.h      |    5 +-
 src/event.c       |   29 ++++++++++--
 test/simple-agent |    5 ++
 8 files changed, 360 insertions(+), 16 deletions(-)
 create mode 100644 src/bt_ids.h

-- 
1.7.7.3

