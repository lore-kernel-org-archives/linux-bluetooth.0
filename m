Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/2] CCC for bonded devices
Date: Thu, 13 Oct 2011 11:53:07 -0300
Message-Id: <1318517589-17372-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to BT spec, CCC is persistent for bonded devices only.
If the device is NOT bonded, CCC entry is removed from the storage
when the connection is established. This approach is simpler than
keep different list/storage(and logic) for bonded and non-bonded devices.

Dependency:
[PATCH BlueZ 0/7] CCC persistence

Claudio Takahasi (2):
  Add storage function to remove CCC of a device
  Remove CCC if the device is not bonded

 src/attrib-server.c |   15 +++++++++++++++
 src/storage.c       |   11 +++++++++++
 src/storage.h       |    1 +
 3 files changed, 27 insertions(+), 0 deletions(-)

-- 
1.7.7

