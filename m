Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] telephony-ofono: notify alerting calls when headset connects
Date: Wed,  5 Jan 2011 17:59:38 +0200
Message-Id: <1294243187-1849-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 00c3f6e..babf38f 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -128,9 +128,32 @@ static struct voice_call *find_vc_with_status(int status)
 	return NULL;
 }
 
+static int number_type(const char *number)
+{
+	if (number == NULL)
+		return NUMBER_TYPE_TELEPHONY;
+
+	if (number[0] == '+' || strncmp(number, "00", 2) == 0)
+		return NUMBER_TYPE_INTERNATIONAL;
+
+	return NUMBER_TYPE_TELEPHONY;
+}
+
 void telephony_device_connected(void *telephony_device)
 {
+	struct voice_call *coming;
+
 	DBG("telephony-ofono: device %p connected", telephony_device);
+
+	coming = find_vc_with_status(CALL_STATUS_ALERTING);
+	if (coming) {
+		if (find_vc_with_status(CALL_STATUS_ACTIVE))
+			telephony_call_waiting_ind(coming->number,
+						number_type(coming->number));
+		else
+			telephony_incoming_call_ind(coming->number,
+						number_type(coming->number));
+	}
 }
 
 void telephony_device_disconnected(void *telephony_device)
-- 
1.7.1

