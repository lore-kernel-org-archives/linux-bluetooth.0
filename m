Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC 0/2] src/shared/att initial implementation.
Date: Tue, 15 Apr 2014 18:04:24 -0700
Message-Id: <1397610266-20894-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After discussions with Marcel, Claudio, and Lizardo, the need for a common
transport structure for GATT/ATT operations with no GLib or connection-specific
dependencies became apparent. This patch set introduces "struct bt_att", which
will be used by the daemon's GATT client implementation (and eventually server).
The vision is to create a brand new ATT/GATT stack based around "struct io" that
is agnostic to the specifics of the underlying connection. The current vision is
to implement bt_att for the ATT layer, a bt_att for the GATT client/server
transactions using bt_att, and integrate this with a shared GATT database
implementation, e.g. src/shared/gatt-db.

Functionality introduced in this patch-set:
  - "struct bt_att", with a set of functions that mimic src/shared/mgmt.
  - Handling of locally initiated ATT requests and their responses plumbed
    through a callback.
  - The "Exchange MTU" request and response.
  - The "Error Response".
  - Unit tests for request-response using a socketpair. Initial test for
    "Exchange MTU" request.

Next steps:
  - All remaining ATT requests/responses.
  - System for notifications/indications.
  - A command-line tool for testing live ATT operations.
  - A test suite that uses emulation.
  - Locally initiated responses for server mode.

Comments are much welcome.

Arman Uguray (2):
  src/shared/att: Introduce struct bt_att.
  unit/test-att: Add unit tests for src/shared/att.

 src/shared/att.c | 554 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h |  97 ++++++++++
 unit/test-att.c  | 307 ++++++++++++++++++++++++++++++
 3 files changed, 958 insertions(+)
 create mode 100644 src/shared/att.c
 create mode 100644 src/shared/att.h
 create mode 100644 unit/test-att.c

-- 
1.9.1.423.g4596e3a

