Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448A390610
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461033; cv=none; b=IvysWd/o+wkEvvpuAqGlo35dbFTla0keGn65uBzwF3/5vxtwq52ubDj0WahLtYSmOIeVjhDBAj9URx2nfHBMMN84bsgsllhzXZfa2QLtzGt0qD7hv4YWACadxHuUtWZhstjiA/cTWqt1rjwb/nunbF2Cb5PrlDTn9mFFPt0YHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461033; c=relaxed/simple;
	bh=or0pGK6wZbaZyC9tV08vgSSX74iu3LGs9bQ4iwoMvoU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNgdPBuFa2wfSH/fEoNF8mq3Vz60oqnV0USqwV9fHidJi8wSrc/0uQSvzGeOlbkLTSqkW6/dHl/h2IncDsf854S2hb1Vgk22xbA+ltq0kjqc0aElaAkXb2Mta3xBzDwi8hAiWOdeMJ/aiiMXddpwl0XDuOsLhKwaVwq+GKCen/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 3F867582368
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:22 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 269523ED14
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 14:57:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v3 8/9] sdp-xml: Fix stack overflow when converting large sequences to XML
Date: Tue, 11 Aug 2026 16:54:11 +0200
Message-ID: <20260811145704.1766949-9-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811145704.1766949-1-hadess@hadess.net>
References: <20260811145704.1766949-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTF4bdVHFdZG4ll+rkbPd4OBQm7n4PeAxiBvwtIeMQr0JxyH0jMI7CIh0yO8VHtbAjnjyTUVcX/+LOjlbUj0Jc38vMSlj7MgAgF/YKstwnYcVs8H+qe2OlQQ45quGtMhPRKXk+jkUThgKyKUTZFiD2iLMqd2XQJbZF8axpqz2frx5d/7JnMP5udHcMOOsLijYqjg0my3Yl9QgaeUoIp8WKxeMLMzUaO8EBwXb/DELMyYvuvRIKK3TkxOj28MEPFChdbzmiXO0Vw3JHsRbe10V9NROOalZV+IiiRXp60coWsdh7hH3WJ8NpXriAhtbu2HP6TMXk7qH3rbr1j4twUFTpE+f7pHoNLYNqSZYn6prQbUmomE9UWdhS7yvIFjP9r5pYR3hcV0Vs+Q5JzrO81V2ol3VwTkytsFIOCHsk+sdO+MKnjzpYye1jYbWJJ5DJ9lPX+I0Gxv7eGriWt84nOh7CuD8dzMyqqiSBWU4DfZ9RezaUNOaOVoRvTsuisVIDBfP9G8f7N2tUVTSDpt9RUhnDlNUIdkobw1PQbrYqhnM6rVOXH/Lk8OmEFkqG58EmA7mpNOqh/f0Qm6VxBtReoeoc1Wf4zq5Jmjqd4Fv7KoWi4zrgh581Pts2Vlczd7mUwfoLjB+aeSYgSFyjvWTdonDyE4ENGnIXKPWgTW2Acc9VU18Q
X-GND-State: clean

Don't make convert_raw_data_to_xml() call itself recursively X times
if there are X elements in a sequence.

AddressSanitizer:DEADLYSIGNAL
=================================================================
==1684518==ERROR: AddressSanitizer: stack-overflow on address 0x7fff7fb40d98 (pc 0x7fbe1ee95c2b bp 0x7fff7fb41610 sp 0x7fff7fb40d70 T0)
    #0 0x7fbe1ee95c2b in printf_common(void*, char const*, __va_list_tag*) (/lib64/libasan.so.8+0x95c2b) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #1 0x7fbe1eeb72d6 in vsnprintf (/lib64/libasan.so.8+0xb72d6) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #2 0x7fbe1eeb94f4 in snprintf (/lib64/libasan.so.8+0xb94f4) (BuildId: 5395ec74f54d9ec7bf97c06583dd39a96c230822)
    #3 0x000000401fc2 in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709
    #4 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994
[...]
    #246 0x000000401c4f in convert_raw_data_to_xml ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:994

SUMMARY: AddressSanitizer: stack-overflow ../../../../Projects/jhbuild/bluez/src/sdp-xml.c:709 in convert_raw_data_to_xml
---
 src/sdp-xml.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 97fb8b0c1af0..0dcb8a7df601 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -679,8 +679,10 @@ sdp_record_t *sdp_xml_parse_record(const char *data, int size)
 	return record;
 }
 
-
 static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
+		void *data, void (*appender)(void *, const char *));
+
+static inline void convert_raw_data_to_xml_element(sdp_data_t *value, int indent_level,
 		void *data, void (*appender)(void *, const char *))
 {
 	int i, hex;
@@ -999,8 +1001,14 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 
 		break;
 	}
+}
 
-	convert_raw_data_to_xml(value->next, indent_level, data, appender);
+static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
+		void *data, void (*appender)(void *, const char *))
+{
+	for (; value != NULL; value = value->next) {
+		convert_raw_data_to_xml_element(value, indent_level, data, appender);
+	}
 }
 
 struct conversion_data {
-- 
2.55.0

