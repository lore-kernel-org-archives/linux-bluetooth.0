Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B03644CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612796; cv=none; b=dNrGeHx+hd/FYwlQ8g6bfjdHzjF/7hdVsGvLQ0chvJ4mkWVgpdZOshk6bJXvP8mJ4cpgVHS4CyCES95GR6g/z9kF/OfhJz7tywP+4UdPf1x15W3gG1jRlArqyRYaArgkpi8IjMjrW2isCrBzplSn+7jnwxMcanzmi6hVBKmxmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612796; c=relaxed/simple;
	bh=kR7DR8mNjfaaoTsx7op1lfjVLot5W8IxTI+ty6+AWsk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcrTxr591X+AYH5Cam7qQeaocVZP/YWKkwFzucdVTj6G8HdSqmcalnXi1GKBuJaHQYId7R2I9hVG9bjPn0/kLHDO2ibsVsqZvc94VpMzb/J4L2M5zDoW8zhhA3jMmQIEf0zTaRoKw4QedkK5RoyneE9TGE8m0d1rg0uNajszD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B58E3EC37
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 09:19:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 2/2] adv_monitor: Ignore additional patterns past what's supported
Date: Thu, 13 Aug 2026 11:16:58 +0200
Message-ID: <20260813091937.2600061-3-hadess@hadess.net>
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
X-GND-Cause: dmFkZTEUwzyWaHq8gkried2wBndz7yrQQZgbtR5FrDPynR7w8kBJZCZI5eXymgKM5eUIlo/30XJHoWcNht/bZtww4gG6xgXaUU4amm3fXSSmmvKe0zHZmVoI7N80LixKVdL4z2f7RKeNyYyIk7/bGRQJUBqo28yLuPE8J/wndiTnHiGs0+nyV6gFwabh/hK1yTvlWv5r4MoUwZVMSXS+nRYkfuxazrjzaY81A/aHprbarVxAUlBZzw4AjRbjvSfhM0Djddqo05t33SW/zv24EYQSVkw/cnoX3vONOh2HoScaLNTIRBXMbP264J1QVYc34SpLkewgJ48DKVq5sHL7YuCfC4SlQfJTzhz7cwo++W4A+Zl28NrB87mmMsJa7wLC7zUTvpo0F8YhmVzuPr8s0HomzsewFq9d2J/Bncu9+UwSB80wtr7x6oEK9WT7kO2rDX7z33NgaK5uFl0uR+re3VWSRmP/4Tddzt2reIxKh0lyKXTXlvR40S9IA8GOypVZfeBeHootCAVD+EeCb1rhbYKdzs9sEUX66pezzOwxseFpkPJOoMFFOLXumNsrHJUdC9qSvyTazKYuWOjbHF7OytgeES1JOyUYugs1EOzKVm0hP5GCasPm/ugryuHMcsAIBngyeGwG3wqfwZ4w19C8e8OKwd7TEpcxwDAIG/xV+312mWfjkg
X-GND-State: clean
X-GND-Score: 0

Ignore patterns beyond what the adapter supports.

Suggested-by: Aisle Research
---
 src/adv_monitor.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 7f437a0e7c8f..c7de01f72a26 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -889,6 +889,7 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 {
 	DBusMessageIter array, array_iter;
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
+	uint8_t max_num_patterns = monitor->app->manager->max_num_patterns;
 
 	if (!g_dbus_proxy_get_property(monitor->proxy, "Patterns", &array)) {
 		btd_error(adapter_id,
@@ -950,6 +951,10 @@ static bool parse_patterns(struct adv_monitor *monitor, const char *path)
 
 		queue_push_tail(monitor->merged_pattern->patterns, pattern);
 
+		if (queue_length(monitor->merged_pattern->patterns) >=
+			max_num_patterns)
+			break;
+
 		dbus_message_iter_next(&array_iter);
 	}
 
-- 
2.55.0

