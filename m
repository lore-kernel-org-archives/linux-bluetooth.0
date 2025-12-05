Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE63199931
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764977641; cv=none; b=fBh8sDpLvaaraJe2eEQPL3j4W9fj/xpVzXGHnf6EmHh/yvQQvALgIVA8oH7lRPBLXvRcIIlbZXw5N8Ja3QNY0lxgjxZASjvhcygilKATo9/xDc4fuXtkyali31YwfmhAef9yfOQFBxMatoj1OUmIjVYQh0lcXFP90y6vGb0ydAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764977641; c=relaxed/simple;
	bh=jSg2lS+XQ3dQ9kQYebTK8uVEfGCI11iwolOQUn3RjYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlwAGq6fNsyqBhXHFd9s4QBXpfHRjS8/mzTiM+/HV419l9zWjIinsfcKW3UbRQcjFw0ylfRbegdeygeL4VlTX4vi3xLWZLQZ4Jw+wb3nu1zjMJUh4NocU5zvhuC4S69ZtrpUjKLpkbopQvg+ZBEtkOP+Um7T07rOkJtHsz/TPH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9S2VrtO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9S2VrtO"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2984dfae0acso49097015ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 15:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764977639; x=1765582439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nz2grG1xuAl+Rzr0eQDQf9S1mJQdCMJmEsK6+uEcLC4=;
        b=I9S2VrtOpld6G4ZmYQWIIJ/v9R7T5KuUwFV2EWiTjfL+A+wXNKcSlqsn9Jk5MhzQCq
         iqHgBisinslorbU299Q569IcHUeQ4ccov43WOrXOsz1ijSLfNc8zySSXu7p+/7w5Cyxq
         XULfmIDIEmGtNyrTJjJS+kDVcSiu2CqfWZ93pw++qNLme5asBiXw6+TmqKFRRDHWjiFB
         RL4KqHb2Msf6rG3tKpI6AgiIirZd6rEZrPuLj+Q5xRVb/qtLxxQuyOHZQQ5utjW0Uv8j
         z4vl5WbQQCpCmQcBMxlO8J50V9Zab7ujHDHsMch0PHBPmMQivgWiX7Tt0VvHBMtCyyRy
         onPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764977639; x=1765582439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz2grG1xuAl+Rzr0eQDQf9S1mJQdCMJmEsK6+uEcLC4=;
        b=lhjn5lTejpGQUAEvHtV9pAfArCmQ75SrttHeGyDD9f8t5vo0eLwfvNgPPmEmyRc+sJ
         eKDYtRCUzF3EaP2d8/ozu+mHDHzm+7fj9InXlptW5L0UWgae5Bg8dc5RwHjK9Xb6m/0d
         JAa/XYS3c93KJQOHWTV8mkg1tSceN62mBobkmMNvxUfy4TwoPl+obMuSm/t9fgBKTFPB
         GJ7WrUzbHRTdFDNZUPU0m4z95CigmJMiShXqeRsssIDVUF5vwxObVgMeaE4DUeewYgp7
         hj2BvVZ2UFzslq+0JCLP3xRvcNmIc+q2Y8FdX7tQ992GqHiTYPhPeiCTMdbVG15sQTIS
         PYOg==
X-Gm-Message-State: AOJu0YyN3wdQGtHtzOoTMESwbtNdh1L9Wo/1BdE0Pw2CPgEvemA6szpy
	3jTRxFbNEOwtmZWrN94suN+S7sQVL9yniI/lIzxnxPO7ETFdbntcU2w9bGekKd47xrY=
X-Gm-Gg: ASbGnctsmDhKyPXUbiDCbnhKO8CeVYrOABG8DWxxBF3ghy77XgAAvO/FY2+ZyyS4pj+
	cZ6DHAfYlSBXaRM1WyLnw4NhiSkFFtfPz4StiprrQSrBphEIuiQd2H8OqvpzPib3bTtIWc3eIMG
	12EVdxb9I3f/x67Fjnbua0udOvbEJXp6Tr72smPsD7bd6Ardhn7He90fspgEQSXCDy4qXIks92k
	3QFvJW9Di7VfnrTAfMrIf3LCKDFg2Tto4KwEbj9M7kffMb0gBiA+AUS7MGLufFtypmchD8O3xyh
	QlU9DAjh/5z66zRXV9lJD8vj5uGPe9Rq4ac94NH32jT580oEmURiOoevXrFmBTjn0bk4EyIaq91
	vJLi3054rylE0mZai2K+XDvJIfMmphEVk68yIfo21UspiDpc1kn+m7wIY5M3a3CZjnGR0zE1Bfg
	aYiu5JAlBQH6UA9rILPL3z1mNRrc0m
X-Google-Smtp-Source: AGHT+IGGy2GaOROPuI/fQjfA2TFSOMlIzC23d81xW4tEyFs8miqXRCNq1RCsol3BKI47Ljtkd4NsQQ==
X-Received: by 2002:a17:903:196b:b0:297:d6c0:90b3 with SMTP id d9443c01a7336-29df5684a56mr6735535ad.23.1764977638850;
        Fri, 05 Dec 2025 15:33:58 -0800 (PST)
Received: from localhost.localdomain ([73.221.165.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae4cf968sm59758495ad.34.2025.12.05.15.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 15:33:58 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v3] monitor: Add unknown options decoding for Configure Response
Date: Fri,  5 Dec 2025 15:32:51 -0800
Message-ID: <20251205233253.550032-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unknown options respose for Configure Respose packet has a different
layout that that of unaccepted options, so it needs special code to
handle it.

Before:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 2 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        04

After:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 3 len 7
        Source CID: 65
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Retransmission and Flow Control (0x04)
---

Changes since [v2]:

    - Patched rebased on latest master

Changes since [v1]:

    - Code converted to use l2cap_frame_get_u8() and l2cap_frame_pull()

[v2] https://lore.kernel.org/linux-bluetooth/20190906190717.1325-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/linux-bluetooth/20190522013216.22493-1-andrew.smirnov@gmail.com/
---
 monitor/l2cap.c | 51 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 6380fec7a..f5ae379c6 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -733,6 +733,41 @@ static const struct {
         { }
 };

+static void lookup_option_by_type(uint8_t type, const char **str,
+                                 uint8_t *expect_len)
+{
+       int i;
+
+       for (i = 0; options_table[i].str; i++) {
+               if (options_table[i].type == type) {
+                       *str = options_table[i].str;
+                       if (expect_len)
+                               *expect_len = options_table[i].len;
+                       return;
+               }
+       }
+
+       *str = "Unknown";
+       if (expect_len)
+               *expect_len = 0;
+}
+
+static void print_unknown_options(const struct l2cap_frame *source,
+                                 uint8_t offset)
+{
+       struct l2cap_frame frame;
+       uint8_t type;
+
+       l2cap_frame_pull(&frame, source, offset);
+
+       while (l2cap_frame_get_u8(&frame, &type)) {
+               const char *str;
+
+               lookup_option_by_type(type, &str, NULL);
+               print_field("Option: %s (0x%2.2x)", str, type);
+       }
+}
+
 static void print_config_options(const struct l2cap_frame *frame,
 				uint8_t offset, uint16_t cid, bool response)
 {
@@ -741,20 +776,13 @@ static void print_config_options(const struct l2cap_frame *frame,
 	uint16_t consumed = 0;

 	while (consumed < size - 2) {
-		const char *str = "Unknown";
+		const char *str;
 		uint8_t type = data[consumed] & 0x7f;
 		uint8_t hint = data[consumed] & 0x80;
 		uint8_t len = data[consumed + 1];
 		uint8_t expect_len = 0;
-		int i;

-		for (i = 0; options_table[i].str; i++) {
-			if (options_table[i].type == type) {
-				str = options_table[i].str;
-				expect_len = options_table[i].len;
-				break;
-			}
-		}
+		lookup_option_by_type(type, &str, &expect_len);

 		print_field("Option: %s (0x%2.2x) [%s]", str, type,
 						hint ? "hint" : "mandatory");
@@ -1132,7 +1160,10 @@ static void sig_config_rsp(const struct l2cap_frame *frame)
 	print_cid("Source", pdu->scid);
 	print_config_flags(pdu->flags);
 	print_config_result(pdu->result);
-	print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
+	if (pdu->result == 0x0003)
+		print_unknown_options(frame, 6);
+	else
+		print_config_options(frame, 6, le16_to_cpu(pdu->scid), true);
 }

 static void sig_disconn_req(const struct l2cap_frame *frame)
--
2.43.0
