Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] monitor: Fix possible crash on unknown LE Meta Event
Date: Sat, 21 Nov 2015 21:09:04 +0100
Message-Id: <1448136544-18660-2-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1448136544-18660-1-git-send-email-szymon.janc@codecoup.pl>
References: <1448136544-18660-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For unknown LE Meta Event subevent_data passed to print_subevent is
NULL. This results in NULL pointer dereference when subeven code is
printed. Fix that by making print_subevent expect always valid
subevent_data and handle unknown event in caller.
---
 monitor/packet.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 70bd153..322bba6 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8375,23 +8375,17 @@ struct subevent_data {
 static void print_subevent(const struct subevent_data *subevent_data,
 					const void *data, uint8_t size)
 {
-	const char *subevent_color, *subevent_str;
+	const char *subevent_color;
 
-	if (subevent_data) {
-		if (subevent_data->func)
-			subevent_color = COLOR_HCI_EVENT;
-		else
-			subevent_color = COLOR_HCI_EVENT_UNKNOWN;
-		subevent_str = subevent_data->str;
-	} else {
+	if (subevent_data->func)
+		subevent_color = COLOR_HCI_EVENT;
+	else
 		subevent_color = COLOR_HCI_EVENT_UNKNOWN;
-		subevent_str = "Unknown";
-	}
 
-	print_indent(6, subevent_color, "", subevent_str, COLOR_OFF,
+	print_indent(6, subevent_color, "", subevent_data->str, COLOR_OFF,
 					" (0x%2.2x)", subevent_data->subevent);
 
-	if (!subevent_data || !subevent_data->func) {
+	if (!subevent_data->func) {
 		packet_hexdump(data, size);
 		return;
 	}
@@ -8442,9 +8436,16 @@ static const struct subevent_data le_meta_event_table[] = {
 static void le_meta_event_evt(const void *data, uint8_t size)
 {
 	uint8_t subevent = *((const uint8_t *) data);
-	const struct subevent_data *subevent_data = NULL;
+	struct subevent_data unknown;
+	const struct subevent_data *subevent_data = &unknown;
 	int i;
 
+	unknown.subevent = subevent;
+	unknown.str = "Unknown";
+	unknown.func = NULL;
+	unknown.size = 0;
+	unknown.fixed = true;
+
 	for (i = 0; le_meta_event_table[i].str; i++) {
 		if (le_meta_event_table[i].subevent == subevent) {
 			subevent_data = &le_meta_event_table[i];
-- 
2.6.2

