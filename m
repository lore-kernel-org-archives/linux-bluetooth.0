Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C433A9D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612796; cv=none; b=P1S8SakbskJBx5hAlpYk5pzfpaBlkk8ZEuVOMXFfO3uyHt48Aj+Sqt/DtmA4YwmVAAKp9u8NdaO/FjA+fxcCXrSHVlKEIhCq+tJiky/p63gRUQ81NFSRZERNFKXPVwsMzk/iP8jl+H3IEzpRipwUv1EVxWPQ9QiNWlRNrXCPWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612796; c=relaxed/simple;
	bh=V4HWT7ENoFegL7fFzCfHYc4fweIgH6pTEoVzb1lWlDw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFtU124IaZncZVPy6zj3fhZE5dekmFT1DGlaYVhV+9rOvtu+s9UWfgNU51aH3+SxQ3rDv4CFF522/KNg9L9XBciJAEQlsB9ZAsvaoP3Sv3ynTvnGHR3iH7/W0KtklTEqoN/qzs5WDJehtMUHlvJKNTajHPH3+vGrqrC8Mc5zvyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 679BE3EC10
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:19:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/2] adv_monitor: Fix buffer overflow caused by integer overflow
Date: Thu, 13 Aug 2026 11:16:57 +0200
Message-ID: <20260813091937.2600061-2-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813091937.2600061-1-hadess@hadess.net>
References: <20260813091937.2600061-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEUwzyWaHq8gkried2wBndz7yrQQZgbtR5FrDPynR7w8kBJZCZI5eXymgKM5eUIlo/30XJHoWcNht/bZtww4gG6xgXaUU4amm3fXSSmmvKe0zHZmVoI7N80LixKVdL4z2f7RKeNyYyIk7/bGRQJUBqo28yLuPE8J/wndiTnHiGs0+nyV6gFwabh/hK1yTvlWv5r4MoUwZVMSXS+nRYkfuxazrjzaY81A/aHprbarVxAUlBZzw4AjRbjvSfhM0Djddqo05t33SW/zv24EYQSVkw/cnoX3vONOh2HoScaLNTIRBXMbP264J1QVYc34SpLkewgJ48DKVq5sHL7YuCfC4SlK2LmUHjhSut+kKbAhmNib9J3HimmDU2mt8ocESBAdNH6DSn6WuMOeZQ2ioa2bPVbTwrwjOX43QeXDjCIWjbo+JCToGVIPOzbrsW/Z//8V/SFNt55P11i6YCp7WqWcZqt+JuxVCZu8ytkpMhmS4c2PO/3W5OdSXCdTpyoCGeZzDJOUGtioVvkVOU5pOJHEhGkPLyIbyfMR3fF/k60/m5wP7IdQdzBV768C9STieyxls2N1v8yvAkUt2P+u4YR4iKcvTRegOFPZ4aYG0DPExa1blC8v+wxFAP+LudGryooTgqm0Kj3/z1dpkzb6BOmoWga7cVKFtEJrnluTcEY5Z8RpA
X-GND-State: clean
X-GND-Score: 0

In src/adv_monitor.c, merged_pattern_send_add_pattern(), and with a
large merged_pattern->patterns list, it's possible to overflow cp_len,
an 8-bit integer:
pattern_count = queue_length(merged_pattern->patterns);
cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);

Eight patterns require 273 bytes of command storage, but assigning
that result to uint8_t cp_len wraps it to 17 before allocation.

The loop that follows does not use the truncated size; it still copies
all eight 34-byte struct mgmt_adv_pattern records into the heap object.
The mismatch between the wrapped allocation size and the full copy
volume produces a large, deterministic heap overwrite.

Fix this in 2 ways in the function itself:
1) increase the size of cp_len, as 8 patterns would overflow it, and some
   typical Bluetooth devices can support 16 patterns
2) Store the result of the multiplication in a 64-bit integer before
   checking whether it's bigger than our 16-bit cp_len

A similar bug exists in merged_pattern_send_add_pattern_rssi().

Reported-by: @ax-nnlabs (for merged_pattern_send_add_pattern())
Reported-by: Aisle Research (for merged_pattern_send_add_pattern_rssi())
---
 src/adv_monitor.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 87fa824b35d8..7f437a0e7c8f 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1106,12 +1106,15 @@ static bool merged_pattern_send_add_pattern(
 			struct adv_monitor_merged_pattern *merged_pattern)
 {
 	struct mgmt_cp_add_adv_monitor *cp = NULL;
-	uint8_t pattern_count, cp_len;
+	uint64_t cp_len;
+	uint8_t pattern_count;
 	const struct queue_entry *e;
 	bool success = true;
 
 	pattern_count = queue_length(merged_pattern->patterns);
 	cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);
+	if (cp_len > UINT16_MAX)
+		return false;
 
 	cp = malloc0(cp_len);
 	if (!cp)
@@ -1126,8 +1129,9 @@ static bool merged_pattern_send_add_pattern(
 
 	if (!mgmt_send(merged_pattern->manager->mgmt,
 			MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
-			merged_pattern->manager->adapter_id, cp_len, cp,
-			add_adv_patterns_monitor_cb, merged_pattern, NULL)) {
+			merged_pattern->manager->adapter_id, (uint16_t) cp_len,
+			cp, add_adv_patterns_monitor_cb, merged_pattern,
+			NULL)) {
 		error("Unable to send Add Adv Patterns Monitor command");
 		success = false;
 	}
@@ -1141,12 +1145,15 @@ static bool merged_pattern_send_add_pattern_rssi(
 			struct adv_monitor_merged_pattern *merged_pattern)
 {
 	struct mgmt_cp_add_adv_patterns_monitor_rssi *cp = NULL;
-	uint8_t pattern_count, cp_len;
+	uint64_t cp_len;
+	uint8_t pattern_count;
 	const struct queue_entry *e;
 	bool success = true;
 
 	pattern_count = queue_length(merged_pattern->patterns);
 	cp_len = sizeof(*cp) + pattern_count * sizeof(struct mgmt_adv_pattern);
+	if (cp_len > UINT16_MAX)
+		return false;
 
 	cp = malloc0(cp_len);
 	if (!cp)
@@ -1169,8 +1176,9 @@ static bool merged_pattern_send_add_pattern_rssi(
 
 	if (!mgmt_send(merged_pattern->manager->mgmt,
 			MGMT_OP_ADD_ADV_PATTERNS_MONITOR_RSSI,
-			merged_pattern->manager->adapter_id, cp_len, cp,
-			add_adv_patterns_monitor_cb, merged_pattern, NULL)) {
+			merged_pattern->manager->adapter_id, (uint16_t) cp_len,
+			cp, add_adv_patterns_monitor_cb, merged_pattern,
+			NULL)) {
 		error("Unable to send Add Adv Patterns Monitor RSSI command");
 		success = false;
 	}
-- 
2.55.0

