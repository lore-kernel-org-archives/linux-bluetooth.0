Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: Lock nesting for L2CAP channels and sockets
Date: Wed, 12 Nov 2014 22:22:20 +0200
Message-Id: <1415823742-26909-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

v2 has minor fixes to a code comment in patch 1/2 and the commit message
of patch 2/2.

>From the original cover letter:

I've spent the last few days fighting with all sorts of lockdep warnings
in the Bluetooth subsystem. A lot of them come from the fact that we
have cross-channel access for L2CAP channels. This ends up looking
suspicious to lockdep unless we help out a bit by adding nesting level
annotations.

It seems like we need at least three distinct nesting levels: SMP
channels, "normal" channels, and parent/listening channels. This is
because the parent channel lock may be held while also taking the lock
of child channels, and the SMP channel may be accessed while holding the
lock of any other channel (e.g. to request security level elevation).

We could in theory identify the type of channel in question implicitly
by inspecting the channel in the l2cap_chan_lock function, however this
is problematic since accessing channel data would usually already
require holding the channel lock (not to mention that the logic for
selecting the needed nesting level wouldn't be completely trivial).

A simpler (imo) solution that I've gone for is to introduce a new
"atomic_t nesting" channel member which contains the necessary nesting
level and is set as soon as the level is known (i.e. initialized to
"normal" upon channel creation or set to one of the two other levels
when creating the SMP chan in smp.c or when setting chan->state to
BT_LISTEN).

The second patch contains a long needed fix for l2cap_sock_teardown_cb
which only got a half-fix earlier this week (also from me) for its
locking. This function gets called for all types of channels so it can't
have a hard-coded nesting level for the socket lock. Instead I've opted
for the socket lock inheriting the chan level and then also using that
for the two other places calling lock_sock_nested() to be consistent.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Use proper nesting annotation for l2cap_chan lock
      Bluetooth: Fix L2CAP socket lock nesting level

 include/net/bluetooth/l2cap.h | 15 ++++++++++++++-
 net/bluetooth/l2cap_sock.c    | 22 +++++++++++++++++++---
 net/bluetooth/smp.c           | 10 ++++++++++
 3 files changed, 43 insertions(+), 4 deletions(-)

