Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D91E5205
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765409898; cv=none; b=AuQ7GkqH1XVhjNvw354EnSDvunL+4LWpAk7mD1LhgpwcXOkUwsQ+qXMj+P4DBE1uUKGelCkDBFeQESv8AGmwU/wMfC3QCVMjvF15PGJ9eL2KZOP0PY8XzzPdjfeLOnUjbCzv2KvwIK6mHm3BHkc9qfqkxN98daDV84yRQumuKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765409898; c=relaxed/simple;
	bh=gaDMfQa+hKFDCRDrFJeuGokLWDNko3wq7G4EDakylDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=od50+edxbweZuE+ywQy0JAwnY2HtoC3Imj4G6hNv+HEyf5ALNNdb8XFGfUmrtlcGiSUcE7xzOAI5W2M+Cn4Wa43ZSqh8eStg0zIfQp8YkRPrFiRrTlJmH1MO9F89exMnwn5ZL4Chlbdql0QuyuUsBvRxMMsjqtJFjHtFhyaZhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug7rbwko; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug7rbwko"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so427466a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765409896; x=1766014696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSqoVz0K/QZnou9ls05KRAopur/ThNtu2Vyd3fkzg6M=;
        b=Ug7rbwkoSidLNs2LzEJO9F7hU9O1jdTRNEfLrb0dkdnbw07fRZ/9U+/ioG+aokXpeG
         7sTcuP+W1fB/JPAnCSu5zpCRf258ozabZwH0E5fUXzHW49qRcTdSihe4cycToX6EI43N
         Oo2h2xj6XOCpHdGbJgDEONAirCbvT47SRKLCNpd6Ca6YTopBnsbwuZzqfUhBgdAWKySi
         PQKYuMsTtiFGat0SPqlZuTUqwUNlSBBNzPNpdQcqZi5kC38BblMk6yja/38TJsD8ievX
         ULk+CjayfyPCjvOORFjKTlcHTKnHV0EhNAWzYPScOEptHLBA5sTI/bs7nMWUbMOcryln
         bFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765409896; x=1766014696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSqoVz0K/QZnou9ls05KRAopur/ThNtu2Vyd3fkzg6M=;
        b=B8xe3zHOQncAXd0oSDy71h6mHu/drBN8RwCZmoZA7/QjwBfpYSildvb/hp9Hnsa7nF
         TwRKPEPOoWOfbfxl7HfgKXg1KXq0RyUv9tiQUxo6+jqRPFfxNTrmoAocV/1wfx0E7OIV
         payl3W8WGEaXnWzUTB7b8utjIk261PAkZ2oLWym4uVXRRjcOsfIlVyrT53OKaOBuoWX8
         rG3T/Q6xLW9/2RYXbTm703AyMhE+Ap/OBcycN3v7eeEyUuHefMd/+PyTVPFlYcE4j3n0
         f/ra4cX9nY+OtXPuMsmIyta/Lt+fWahGWABltWM/8gqEzaaBngW0nHr/Fbr4DxKXZJ8H
         1iJw==
X-Gm-Message-State: AOJu0YwOiPd9+tjLZwcxjS6zxnNFgbPN28wPHKix3AQIoGKs6assZCTG
	zVyHmBYmq9sM1buw/gEYrZCKVC89thpSr3OMxpbC9jqeDG9VU+pkx7oWFgLVmy9su6E=
X-Gm-Gg: AY/fxX4Re1Oavhhwz6Tc+w+sJ0rpWDz41vfFiUUroWiS86bdYHTy1B2WHOPscOGRolK
	8N0N1lKg/+UoNzqp1BR0UoRs70i/lAifZZZjxVYOODQyuppHVt0Uxg9VUgdk3uLFLIfIwyUIHgV
	kbHPUi+gWCRJd84fRV4fiH9NqqHX0kuWaQkGaSDDemf4GfMiIp5Nx/Ga+769rLPdYNXrmpDqXMJ
	8QDxw4CGmsAw7jqJOlFsoM1s69Z/13lcD4IPpDXJ6aIJiVzPoxJ6LTsWMHrQToUGq71SU6uAlHi
	8L2TlzNcnPqBp+qZhrnHyEEth/2VvYEur/vECLm3RTT1f8/IxiF4JWHLyMKUF+CYcEiAUVPt3L2
	H4VvvPzTm8EVbw8DD6uOY7W/vRRrpfdR3+JuvyxmHJAptZcK6JZoDmjh48QxSbxTRlDGvVtr9WV
	9jTpu7/JKcdk6YNk9MmYFxoLJTWqK2
X-Google-Smtp-Source: AGHT+IHGKtagm9wjmK8AOMGyoagtwsO3egeNSxgXgz6F+mG/PbOZVY2gNHyu2xOsY/5BdTFRxkpPGg==
X-Received: by 2002:a17:90a:c883:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-34a72900fe9mr4227737a91.18.1765409895645;
        Wed, 10 Dec 2025 15:38:15 -0800 (PST)
Received: from localhost.localdomain ([73.221.165.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a926af6efsm10049a91.5.2025.12.10.15.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 15:38:14 -0800 (PST)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v4] monitor: Add unknown options decoding for Configure Response
Date: Wed, 10 Dec 2025 15:37:54 -0800
Message-ID: <20251210233755.2252548-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unknown options respose for Configure Respose packet has a different
layout that of unaccepted options, so it needs special code to handle
it.

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

Changes since [v3]:

    - Fixed various checkpatch warnings

Changes since [v2]:

    - Patch rebased on latest master

Changes since [v1]:

    - Code converted to use l2cap_frame_get_u8() and l2cap_frame_pull()

[v3] https://lore.kernel.org/linux-bluetooth/20251205233253.550032-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/linux-bluetooth/20190906190717.1325-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/linux-bluetooth/20190522013216.22493-1-andrew.smirnov@gmail.com/

 monitor/l2cap.c | 51 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 6380fec7a..be041a8e1 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -733,6 +733,41 @@ static const struct {
         { }
 };

+static void lookup_option_by_type(uint8_t type, const char **str,
+				  uint8_t *expect_len)
+{
+	int i;
+
+	for (i = 0; options_table[i].str; i++) {
+		if (options_table[i].type == type) {
+			*str = options_table[i].str;
+			if (expect_len)
+				*expect_len = options_table[i].len;
+			return;
+		}
+	}
+
+	*str = "Unknown";
+	if (expect_len)
+		*expect_len = 0;
+}
+
+static void print_unknown_options(const struct l2cap_frame *source,
+				  uint8_t offset)
+{
+	struct l2cap_frame frame;
+	uint8_t type;
+
+	l2cap_frame_pull(&frame, source, offset);
+
+	while (l2cap_frame_get_u8(&frame, &type)) {
+		const char *str;
+
+		lookup_option_by_type(type, &str, NULL);
+		print_field("Option: %s (0x%2.2x)", str, type);
+	}
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
