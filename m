Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] [RFC] handling avdtp collisions
Date: Wed,  6 Apr 2011 14:00:32 +0300
Message-Id: <1302087637-30131-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This has been causing some problems with some devices, specially with
start and suspend commands which even when local endpoint handles it
nicelly (by accepting as a valid response) the remote stack may not
respond at all causing the resquest to timeout/abort.

The spec suggest the following about this:

"In case an INT receives a request for the same command that it is
expecting a response for, it may reject the command and may use a
random time offset for a retransmission to avoid deadlock."

But note that this is not possible for abort which cannot be rejected
and also may be too expensive in some cases e.g. switching a2dp to hfp
when a call is ringing.

So instead of doing this directly on avdtp levle as the spec suggest, I
suggest to let the local sep decide what to do with the command
indication and in case it accepts remove the pending request from the
queue so it doesn't timeout nor can be rejected.

Note that this doesn't change much the current implementation of local
sep, it was already accepting indication regardless of pending
requests, but with the proposed changes when a collision happen
callbacks are called and the indication is properly propagated to the
endpoints.

Luiz Augusto von Dentz (5):
  Add handling of avdtp command collision
  Fix handling of a2dp suspend indication
  Fix handling of a2dp open indication
  Fix handling of a2dp start indication
  Fix handling of a2dp abort indication

 audio/a2dp.c  |   62 ++++++++++++++++++++++++++++++++++++++++++---
 audio/avdtp.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 127 insertions(+), 13 deletions(-)

