Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 04/11] Add checking if profiles are requesting connection
Date: Mon, 26 Sep 2011 14:48:21 -0300
Message-Id: <1317059308-20038-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before triggering automatic ATTIO connections driven by platform event,
the device needs to check if there is at least one entry in the ATTIO
connection callback, meaning that there is profile requesting connection
and the state is auto connection.
---
 src/device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index ab4792b..b88aee4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1941,6 +1941,9 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 		return;
 	}
 
+	if (device->attios == NULL && device->attios_offline == NULL)
+		return;
+
 	g_idle_add(att_connect, device);
 }
 
-- 
1.7.6.1

