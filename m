Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D943C81B2
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521870; cv=none; b=QvsS9Qgkge3B90k4odu+MrsVXCLk7tE3GnxjdgbPlsZo2ENGO6vsh6L0k4kc+ajJXkTmob2ZZpD1j7WQxXa7D0anbNBARe1Itj0zs9GGo+77JlJzvRD7MZHy3CH0Wr380zFs4aS54gHOUskavvHZU0E07vtS6wNWIYUJ/rU0buo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521870; c=relaxed/simple;
	bh=dPBOoAnf3/2d1etWh/3w/G9+n+zSNvtUE+2ySExQ6PE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlofUvuPasE2kghbnNnez8vK/lkabCCL2/5Xyg7BqgjL1KqaSvtpMBx+WapJWnpREaQoT8q/pTj5K6EsX95AH4/7pLYG6sqzLAAcCqgrESB9lobN6F4APD/14cLN/6J/deYFtzCd68yJa/7f1Rajb7UxAGgwz+05/VJOcfwiHG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 554463EE6B
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Aug 2026 08:04:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ, v4 8/9] sdp-xml: Fix stack overflow when converting large sequences to XML
Date: Wed, 12 Aug 2026 10:01:39 +0200
Message-ID: <20260812080410.2116906-9-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812080410.2116906-1-hadess@hadess.net>
References: <20260812080410.2116906-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGnQGjbKmJd+Y1MDjSo4aN39TQZ1m7TiiY5swXGq+cBi1hlzlgQeWT5sd4v9pGo2Nult/OOPKFeC13MfhnGyEUlm7mauNaNtYRSeH0HVQvJT6SPmzqJl1RlOB7yVKDhDY5kCqJc0c7WnSfTn3uUh4zzQBNdk9XWciFveg7ufvMNisAUO8qq6QjjOns56rugpCW9OQnsy0EBXkM1hLpdmrTuFKryV78jHsSAizA96ZGrEL2yS9/PqU0nyfqgPjtlqOboqqA3QP7N3a15ICheKLviMZFIh02+gbGL8UUH6STBWhpbmEF7EZx5iFMWSGAhB2nw8OMVROSckGhTcuZ94yRlpCfuFUF5a54JxEUkdh3PboLwUTb4XEywmSp885le5mlqZJEkzfvyH1JoISurBzTC+MSHr6dKeZHLDiH9hykayX2rLYVo+JalgmmBy3dhZiT+/ivjyaT0MJGNBwROc4tIdypsuEEZENyzgFCiTK1Ukxncy/NZ7hZu5y95fB+LJj5dQ7sSjvEhVnvX6CToEuIwJw2SWUeRO9+DmzwVOmzGFFgWTAEA0Z4sT5u1NvqvX+CrNhxgT4JE3pS4xKcKzsBwnj9oLOE4eDNowD5Bn3do4m+jdY/32J9OsImqIQKRqj3Jrxz5ziFgah2mcCVn/a8HonGnnTp8lmmz84IjnflTYg
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
 src/sdp-xml.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 95431f6ca2dd..e4d10f00e96e 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -681,9 +681,12 @@ sdp_record_t *sdp_xml_parse_record(const char *data, int size)
 	return record;
 }
 
-
 static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
-		void *data, void (*appender)(void *, const char *))
+		void *data, void (*appender)(void *, const char *));
+
+static inline void convert_raw_data_to_xml_element(sdp_data_t *value,
+		int indent_level,void *data,
+		void (*appender)(void *, const char *))
 {
 	int i, hex;
 	char buf[STRBUFSIZE];
@@ -1001,8 +1004,15 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 
 		break;
 	}
+}
 
-	convert_raw_data_to_xml(value->next, indent_level, data, appender);
+static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
+		void *data, void (*appender)(void *, const char *))
+{
+	for (; value != NULL; value = value->next) {
+		convert_raw_data_to_xml_element(value, indent_level,
+			data, appender);
+	}
 }
 
 struct conversion_data {
-- 
2.55.0

