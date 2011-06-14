Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>
Subject: [PATCH 0/4] Add support for custom (e)SCO parameters
Date: Tue, 14 Jun 2011 15:57:03 +0200
Message-ID: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches add possibility to specify custom parameters for
outgoing (e)SCO link. This is implemented as SCO socket options.

This change allows to use reference parameters as defined in HFP 1.5
specification as well as support for future enchancements as wideband
speech as defined in HFP 1.6 draft (uses different air coding format).

Additional socket option (patch 3) allows to disable automatic retry
in case of failure which fallbacks from eSCO to SCO connection in
current implementation. Such fallback should not happen when using
wideband speech which mandates using of eSCO transport.

Patches are on behalf of ST-Ericsson SA.


Andrzej Kaczmarek (4):
  Bluetooth: Change bit logic in pkt_type for SCO links
  Bluetooth: Add BT_SCO_PARAMETERS SCO socket option.
  Bluetooth: Add BT_NO_AUTORETRY SCO socket option.
  Bluetooth: Update mapping for eSCO related error codes

 include/net/bluetooth/bluetooth.h |   12 ++++++
 include/net/bluetooth/hci.h       |    2 +
 include/net/bluetooth/hci_core.h  |    6 ++-
 include/net/bluetooth/sco.h       |    2 +
 net/bluetooth/hci_conn.c          |   43 ++++++++++++++++-----
 net/bluetooth/hci_event.c         |    5 +-
 net/bluetooth/l2cap_core.c        |    4 +-
 net/bluetooth/lib.c               |    2 +
 net/bluetooth/mgmt.c              |    3 +-
 net/bluetooth/sco.c               |   75 ++++++++++++++++++++++++++++++++++++-
 10 files changed, 135 insertions(+), 19 deletions(-)

-- 
1.7.5.4

