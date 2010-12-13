Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] More btd_error_* patches
Date: Mon, 13 Dec 2010 19:32:57 -0200
Message-Id: <1292275987-13799-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set adds a new error function btd_error_failed(), which has a str
parameter to enable a more accurate error report in the case the usual
btd_error_* does not fit.

After this patch set there will 10 occurrences of g_dbus_create_error() inside
bluez code (not counting health/ here)

Please review!

Gustavo F. Padovan (10):
  Add btd_error_no_such_adapter()
  src: use btd_error_invalid_args()
  Add btd_error_failed()
  plugins: use btd_error_failed()
  attrib: use btd_error_failed()
  network: use btd_error_failed()
  input: use btd_error_failed()
  audio: use btd_error_failed()
  serial: use btd_error_failed()
  src: use btd_error_failed()

 attrib/client.c      |   10 +-------
 audio/control.c      |    6 +---
 audio/device.c       |   14 ++++--------
 audio/gateway.c      |   11 ++++-----
 audio/headset.c      |   18 ++++------------
 audio/sink.c         |    9 ++-----
 audio/source.c       |    9 ++-----
 audio/transport.c    |    7 +-----
 input/device.c       |   31 +++++++----------------------
 network/connection.c |   30 +--------------------------
 network/server.c     |   13 ++---------
 plugins/service.c    |   22 +++-----------------
 serial/port.c        |   20 ++++++++----------
 serial/proxy.c       |    8 +-----
 src/adapter.c        |   37 ++++++++++++-----------------------
 src/device.c         |   52 ++++++++++++-------------------------------------
 src/error.c          |   12 +++++++++++
 src/error.h          |    2 +
 src/manager.c        |   13 ++---------
 19 files changed, 97 insertions(+), 227 deletions(-)

-- 
1.7.3.2

