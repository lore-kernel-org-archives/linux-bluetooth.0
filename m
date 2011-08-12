Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/7] Add support for HandsfreeGateway to Media
Date: Fri, 12 Aug 2011 17:27:50 +0200
Message-Id: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch will enable HandsfreeGateway interface to work with PulseAudio.
This is similar to what is done for Headset interface.

Some details about patch 2 :
In an error situation, endpoint_reply calls request->cb which frees endpoint->request and sets it to NULL.
But endpoint_reply uses a local variable with a copy of the pointer and tries to free the request again.

Also there is some minor fixes in the pulse audio part still required.
I'll send the patch on the PA list.




Frédéric Dalleau (7):
  Add missing call to headset_remove_state_cb
  Fix double free in error case in endpoint_reply
  Add state change callback to HandsfreeGateway
  Use state change callback from media interface
  Update g_strcmp0 to strcasecmp
  Add state change callback to audio interface
  Introduce new state GATEWAY_STATE_PLAY_IN_PROGRESS

 audio/device.c  |   54 +++++++++++++++++++++++++++++++++++++++++++++
 audio/gateway.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/gateway.h |    8 ++++++
 audio/media.c   |   61 +++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 187 insertions(+), 2 deletions(-)

