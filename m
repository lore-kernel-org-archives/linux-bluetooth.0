Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH Bluez 04/11] Add checking if profiles are requesting connection
Date: Tue,  4 Oct 2011 15:31:09 -0300
Message-Id: <1317753069-13939-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-5-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-5-git-send-email-claudio.takahasi@openbossa.org>
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
index c3eaf45..78a925c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2027,6 +2027,9 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 		return;
 	}
 
+	if (device->attios == NULL && device->attios_offline == NULL)
+		return;
+
 	g_idle_add(att_connect, device);
 }
 
-- 
1.7.7

