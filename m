Return-Path: <cyrus@holtmann.org>
From: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/1] avctp: Set browsing channel connection for ct
Date: Tue, 22 Jan 2013 11:34:03 +0100
Message-Id: <1358850844-19752-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A few comments:
Handling channel creation for AVRCP:
  For AVRCP >= 1.4 the browsing channel can be connected after the
control channel is connected successfully.
  It's not clear for me what bluez should do in case the browsing
channel connection fails. There is nothing stopping bluez for still
providing avrcp 1.3 functionality over the control channel.
  If the choice is to allow the use of the control channel even if the
browsing one fails then bluez needs the logic in
avrcp.c:state_changed(). If not then both channels must be destroyed
and the session must not be initialized.
State AVCTP_STATE_CONNECTED in state_changed has also to differentiate
between AVRCP <= 1.3 and AVRCP >= 1.4. In AVRCP <= 1.3 after the
control channel is created the avrcp session can be initialized.
In AVRCP >= 1.4 we need first to try and connect the browsing channel.
The session can be created if:
- The state is AVCTP_STATE_BROWSING_CONNECTED (if the browsing channel
was connected successfully),
- The state is AVCTP_STATE_CONNECTED and old_state is
AVCTP_STATE_BROWSING_CONNECTING (if the browsing channel connection
failed),
- The state is AVCTP_STATE_CONNECTED but avctp_connect_browsing fails.

Handling the feature mask:
Since bluez will support AVRCP 1.5 is the AVRCP_FEATURE_BROWSING
actually required? It was checked on the target side during the session
init.

Alexandros Antonopoulos (1):
  avctp: Set browsing channel connection for ct

 profiles/audio/avctp.c  | 11 +++++++++++
 profiles/audio/avctp.h  |  4 +++-
 profiles/audio/avrcp.c  | 28 +++++++++++++++++++++++-----
 profiles/audio/device.c |  4 ++++
 4 files changed, 41 insertions(+), 6 deletions(-)

-- 
1.8.1

