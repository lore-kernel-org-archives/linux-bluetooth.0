Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 0/8] Proper support for pairing LE devices
Date: Fri, 19 Aug 2011 21:09:21 -0300
Message-Id: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This adds proper support for pairing LE devices.

--

Vinicius Costa Gomes (8):
  Add link_type information to the mgmt "Device Connected" event
  Fix doing SDP service discovery for LE devices
  Set the Paired property of a device when restoring from storage
  Fix not using the same way for pairing LE devices
  Fix not using the "bonded" property for new bondings
  Fix connecting to the local adapter when receiving new keys
  Remove the default security level from btio
  Fix btio users to not expect a default security level

 audio/avdtp.c        |    1 +
 audio/control.c      |    1 +
 audio/gateway.c      |    2 ++
 audio/headset.c      |    1 +
 btio/btio.c          |    1 -
 doc/mgmt-api.txt     |    1 +
 input/device.c       |    1 +
 lib/hci.h            |    2 ++
 lib/mgmt.h           |    1 +
 network/connection.c |    1 +
 plugins/hciops.c     |    4 ++--
 plugins/mgmtops.c    |    2 +-
 serial/port.c        |    2 ++
 src/adapter.c        |   10 +---------
 src/device.c         |   29 ++++++++++++-----------------
 src/event.c          |   22 ++++++++++++++++++----
 src/event.h          |    2 +-
 tools/hcitool.c      |    3 ---
 18 files changed, 48 insertions(+), 38 deletions(-)

--
1.7.6

