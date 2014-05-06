Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 00/10] bt_att initial implementation
Date: Mon,  5 May 2014 21:45:53 -0700
Message-Id: <1399351563-25991-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduces "struct bt_att" which handles the transport logic for
interactions over the Attribute Protocol. struct bt_att is meant to be
connection-agnostic: It enables a new GATT/ATT stack based around src/shared/io,
so that the library internals of how the connection is managed (glib vs
mainloop) is not tied to the protocol implementation. bt_att will initially
support the client-side protocol and eventually extended to support the server
side.

Major changes introduced in this patch-set:
  - src/shared/att.[h,cc], which introduces "struct bt_att", with initial
    support for client-initiated requests and asynchronous response handling via
    a callback.
  - unit/test-att, which defines unit tests for request/response using a
    socketpair.
  - tools/btatt, which is a command-line tool for debugging the Attribute
    Protocol.

The majority of the above are introduced in patches 1 through 3, which consist
almost entirely of boilerplate taken from src/shared/mgmt.*, unit/test-mgmt, and
tools/btmgmt.c.

The 9 patches introduced here are the initial portion of 20+ patches where each
ATT operation is implemented in groups of 3 patches:
  - 1 patch that implements the request/response or command in src/shared/att
  - 1 patch that adds a unit test to unit/test-att
  - 1 patch that adds a command for the request to tools/btatt

Arman Uguray (10):
  src/shared/att: Introduce struct bt_att.
  unit/test-att: Add unit tests for src/shared/att.
  tools/btatt: Add command-line tool for ATT protocol testing.
  tools/btatt: Add "exchange-mtu" command.
  src/shared/att: Add "Find Information" request and response.
  unit/test-att: Add unit test for "Find Information" request/response.
  tools/btatt: Add "find-information" command.
  src/shared/att: Add "Find By Type Value" request and response.
  unit/test-att: Add unit test for "Find By Type Value"
    request/response.
  tools/btatt: Add "find-by-type-value" command.

 Makefile.am      |  12 +-
 Makefile.tools   |  10 +-
 src/shared/att.c | 689 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/att.h | 124 ++++++++++
 tools/btatt.c    | 626 ++++++++++++++++++++++++++++++++++++++++++++++++++
 unit/test-att.c  | 473 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 1932 insertions(+), 2 deletions(-)
 create mode 100644 src/shared/att.c
 create mode 100644 src/shared/att.h
 create mode 100644 tools/btatt.c
 create mode 100644 unit/test-att.c

-- 
1.9.1.423.g4596e3a

