Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 02/11] transport: Store the value set through the 'Volume' property
Date: Fri, 11 Jan 2013 17:25:25 -0300
Message-Id: <1357935934-20033-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
References: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/audio/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 6ffa98a..f3caa1b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -658,6 +658,8 @@ static void set_volume(const GDBusPropertyTable *property,
 	if (a2dp->volume != volume)
 		avrcp_set_volume(transport->device, volume);
 
+	a2dp->volume = volume;
+
 	g_dbus_pending_property_success(id);
 }
 
-- 
1.7.11.7

