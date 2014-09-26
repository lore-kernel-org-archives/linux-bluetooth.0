Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 0/2] shared/gatt-client: ATT invalidation handler interface
Date: Fri, 26 Sep 2014 11:46:45 +0200
Message-Id: <1411724807-4842-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Purpose of this RFC is to discuss the need for implementing the following item
  from the TODO list:

  "
  ATT/GATT (new shared stack)
  ===========================

  - Introduce a handler interface to shared/gatt-client which can be used by the
    upper layer to determine when the link has been disconnected or an ATT
    protocol request times out.

    Priority: Medium
    Complexity: C2
  "

Even though the following patches propose the solution for this TODO entry if I
understood it correctly, I'm not sure if it is really needed to have this
in shared/gatt-client, as this would only be wrapping the shared/att code.
As shared/gatt-client is not directly handling the connection, nor is
initialising the shared/att, its up to user, which does that
(tools/btgatt-client for now) to handle this events, as it is using the
shared/att API directly anyway. And btw. 'bt_att_register_disconnect()' was
designed to be 'user ready/user friendly' as it can handle multiple
users/callbacks. If we realy need this multiple user notifications we could
extend the 'bt_att_set_timeout_cb()' to work in similar way.

Is there a good reason to have this functionality on shared/gatt-client level?
If we really want this, then what about the gatt-server? We duplicate the
wrapping we have in gatt-client?

Regards,

Jakub Tyszkowski (2):
  shared/gatt-client: Add callback for reporting att state
  tools/btgatt-client: Use shared/gatt att state callback mechanism

 src/shared/gatt-client.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/gatt-client.h |  5 ++++
 tools/btgatt-client.c    | 12 +++-------
 3 files changed, 69 insertions(+), 10 deletions(-)

--
1.9.1

