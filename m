Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 04/11] Add checking if profiles are requesting connection
Date: Fri,  2 Sep 2011 18:38:34 -0300
Message-Id: <1314999521-11261-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
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
index e812e01..432c02b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1937,6 +1937,9 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 		return;
 	}
 
+	if (device->attios == NULL && device->attios_offline == NULL)
+		return;
+
 	g_idle_add(att_connect, device);
 }
 
-- 
1.7.6

