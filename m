Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 0/8] Another step in l2cap_core/sock separation
Date: Wed, 23 May 2012 22:12:36 -0300
Message-Id: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Hi,

This patchset does a bit more of clean up in l2cap core, it was inially based
on the two patches Andrei has sent to the list today.

Vinicus, you might want check patch 4/8 especifically.

Comments are welcome.

Gustavo Padovan (8):
  Bluetooth: Move clean up code and set of SOCK_ZAPPED to l2cap_sock.c
  Bluetooth: Remove extra l2cap_state_change(BT_CONNECTED)
  Bluetooth: Add l2cap_chan->ops->ready()
  Bluetooth: Use l2cap_chan_ready() in LE path
  Bluetooth: Use chan->state instead of sk->sk_state
  Bluetooth: Move check for backlog size to l2cap_sock.c
  Bluetooth: Create DEFER_SETUP flag in conf_state
  Bluetooth: Add chan->ops->authorize

 include/net/bluetooth/l2cap.h |    4 ++
 net/bluetooth/l2cap_core.c    |  121 +++++++++--------------------------------
 net/bluetooth/l2cap_sock.c    |  111 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 139 insertions(+), 97 deletions(-)

-- 
1.7.10.1

