Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156746;
	b=Kp+66bplBVZOX4RA5IGm9NxbtFnIdh0e/ayzoB8bNbINPz8CcJTXGX/AVspHmuRYrB/2
	 cGnzH1m6kmrT03PuI97YlA/4LPhO3F7rqbSL91AsntpXG5Yvf+iCp4qw8LpivgLklTTc4
	 wBwFoLKg6byj1+QgXypzmUd3sf/eXcNE/xk4tIhJgm/BEC/6wRUJhc/bYOblB/v3Aneb/
	 SHkmv/cNWsAWzOWfw7K9P8OOLMKEd1finGlOnVLSqfMbMVfMEKL4a2GTwei8pZCWEb+Gd
	 cQsujVOaq+Z8Hgs0IY6zVcTvNlETI5HK7Ag16UBKFsRS21rrUXRDpUuF6zQ7mEkyFDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TkhCcLh/zPAZoL2FP92AWE5tqZl/J4LBjZ4QmJNkIKA=;
	b=a1A5sLS6wFLwi76cYru7B8J/MYYB2X3smElyh7J0T7G39mNTK53fCefKzyK9g9SpkDNy
	 ff8sg+2t6psBFNW91332X1ZExUzaOTmrqk+jRnkNZof9skzNvjsHGdIrShSZjArqhgQhV
	 5KAwpRtJ2uGJ0Pqqu0mgBqGkO6ezyxxkucuPgzn3X6b4hYiua4fsw8fxSuadX5tx67sjD
	 2ONjLQs99djDvVXtKNwkDMll2LwblmiClCiD6/BOQdX4PWNEoIMNRPdknp4YdjRBVsutv
	 fKg8qp4Dxdxz09L08H+VwVUnMS/nlc279QZF3EcqNQ/ldhxuDlria8ap+6v0BMruGgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VX9yKlTo;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690F6606A339
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 06:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690F6606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VX9yKlTo
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-49355a50d11so5762f8f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 22:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156745; x=1795761545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkhCcLh/zPAZoL2FP92AWE5tqZl/J4LBjZ4QmJNkIKA=;
        b=VX9yKlTohyNiwFBBEHwzMLRaLRZOt3ONH+zzrJXwlsTj6VjDhHWYDCjsU5lSELUr+L
         dg/x64YAc6UndxdLM2YTbVy0aeVLFh1AERvsOP20QAik6ccaaIqxt52VD2nxfU4JekCO
         467lp0XQI6PK3g3ApMnuxbJVrMKRTjHhOSveYUZoZxttjGdNu8EMtkfB4bPW7NPl1tMe
         OsbL6C3N9serLamL2RMSMeiivK7WXcL5syDeFLFyrkqfjSvkDOl5ZgfI7ji55FjdyEbW
         rwXlJUcFVGCu9cbE9q18Qz9FK37JUHkllxEu0nFGFdJfSTr466HP41WVQ0nGasLBQ7Lk
         Mfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156745; x=1795761545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkhCcLh/zPAZoL2FP92AWE5tqZl/J4LBjZ4QmJNkIKA=;
        b=wEwPECcY6c7qo045cTUPTF0OvNhiSCy/hTjFN/byH+wmeuV6i9tpTmIsxCyCZ9OUN/
         kEeGiXgHjd/66Mno89K6zBrJJ0p5nDJxg+wcpJ8Rm/KwG88FGdnSp5ELil06N55LHrib
         4OvXZRAWF20WpVg64De8GcpR4odvaz4MukW9nF0Oqi78G67tOhl8Jpqqr6wIL5lHojW3
         9HHDOjUMGzyvlFiL8RjGUGMtZOfWXgwds5JJaXsH2dlbXdjDb4qzk09Ri9nysNGEEzsb
         54mtU9El3nSarvsA+YSS5cwLbkcZHYcQHz6FYnvFRUAUC1PJSkfOYyhKKx0NOSzKucIL
         y6xg==
X-Gm-Message-State: APuU4Z/jpqoBFJswi17SrlzYzVfaasuyI6vjaUWr4mwVmpwcvOEU4zp8
	m/CMxAQhHxlvNzT+jK5zcVUw3PZqkHImkvAnqua/a+1MH8xv06eBX+KHoIh2YEmX
X-Gm-Gg: AZFdTZeoONpLfxnE75pjKqbScHQA6dmTKVV/0Z6zFibQOkJ1fNjoxzTEfTYAI0H56o9
	muFl/Faoouaht30tkql97rOihAzNUiPjpPmkyWryq/ou2MXZWtObTGyLxc5/NHpi1drlZ5dQkTs
	s30GHKQUj4i5tkipkQGzSuARitjzvNlhjElpA7BW8GOPh4rVjOJ5AFuHWjVwq7nW0TfcL7f4+gd
	sAyv6ZLzC8i0xvb8T4nQlQxEcTlRXZPyvzugbj8SFafANEJPLKH3EAbeV0qXcP2vzAQFqhP3NwR
	GS5eFvOIIRzm63aXh8hNZ4VqMVfdzbb2zhGN6E0gbO94r59VG7T8jP9MyYeXB0270MUt2gCp7QZ
	3NYf/4aXzdhwckk3eS3WfVmBkussH+ObfyAU7WNHEeppu/t5P7wOCOfonP21u0G7Apg15C9vgpT
	tz4nzEnrOqn7fU3ZGuZtIf3b73pMRgpO5QLY4EnoK/y3vAoP68FvyuWsdUpGbUCpYEC0y20ftNn
	8MYVDQbJXmyLpKPOejr3XPE1LPo5IkRzTfiEWU/UOI4g7OiZOcIHXP5feTvaKPQwCp7O1uFdgmt
	gcHoF85tSerCX6XqGgjhUsjpLmjX3cyXIfI=
X-Received: by 2002:a5d:588c:0:b0:4ab:3a26:31b7 with SMTP id ffacd0b85a97d-4abb8ac4103mr3627851f8f.6.1795156744648;
        Thu, 19 Nov 2026 22:39:04 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm3685607f8f.16.2026.11.19.22.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:39:04 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v4 03/10] monitor: Fix PHY decoding of LE Ext Create Connection
Date: Fri, 20 Nov 2026 07:38:49 +0100
Message-ID: <20261120063856.16585-4-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120063856.16585-1-rolandschober1968@gmail.com>
References: <20261120063856.16585-1-rolandschober1968@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The LE Extended Create Connection decoder reads one block of connection
parameters for each bit set in Initiating_PHYs without checking that the
command carries that many blocks, so a truncated command makes it decode
octets which are not part of it:

< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 10
        ...
        Initiating PHYs: 0x01
        Entry 0: LE 1M
          Scan interval: 0.000 msec (0x0000)
          Scan window: 0.000 msec (0x0000)
          ...

Check the size of the command before decoding each block, and report
octets left over after the last block. The blocks are indexed through
a pointer to the block type, not by adding their size to a void
pointer:

        Initiating PHYs: 0x01
          invalid packet size

Fixes: e29ef3b85116 ("monitor: Add LE Extended Scan commands decoding")
Assisted-by: Claude:claude-opus-5-5
Assisted-by: Claude:claude-fable-5-2
---
 monitor/packet.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 0e40300fd..9814e0e96 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8816,10 +8816,13 @@ static const struct bitfield_data ext_conn_phys_table[] = {
 	{ }
 };
 
-static void print_ext_conn_phys(const void *data, uint8_t flags)
+static void print_ext_conn_phys(const void *data, uint8_t size,
+							uint8_t flags)
 {
+	const struct bt_hci_le_ext_create_conn *entries = data;
 	const struct bt_hci_le_ext_create_conn *entry;
 	uint8_t mask = flags;
+	bool truncated = false;
 	int bits_set = 0;
 	int i;
 
@@ -8827,9 +8830,20 @@ static void print_ext_conn_phys(const void *data, uint8_t flags)
 
 	for (i = 0; ext_conn_phys_table[i].str; i++) {
 		if (flags & (1 << ext_conn_phys_table[i].bit)) {
-			entry = data + bits_set * sizeof(*entry);
 			mask &= ~(1 << ext_conn_phys_table[i].bit);
 
+			if (truncated)
+				continue;
+
+			if ((bits_set + 1) * sizeof(*entry) > size) {
+				print_text(COLOR_ERROR,
+						"  invalid packet size");
+				truncated = true;
+				continue;
+			}
+
+			entry = &entries[bits_set];
+
 			print_field("Entry %d: %s", bits_set,
 						ext_conn_phys_table[i].str);
 			print_slot_625("  Scan interval", entry->scan_interval);
@@ -8852,6 +8866,12 @@ static void print_ext_conn_phys(const void *data, uint8_t flags)
 		}
 	}
 
+	if (!truncated && bits_set * sizeof(*entry) < size) {
+		print_text(COLOR_ERROR, "  invalid packet size");
+		packet_hexdump((const void *) &entries[bits_set],
+					size - bits_set * sizeof(*entry));
+	}
+
 	if (mask)
 		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PHYs"
 							" (0x%2.2x)", mask);
@@ -8880,7 +8900,7 @@ static void le_ext_create_conn_cmd(uint16_t index, const void *data,
 	print_own_addr_type(cmd->own_addr_type);
 	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
 	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
-	print_ext_conn_phys(cmd->data, cmd->phys);
+	print_ext_conn_phys(cmd->data, size - sizeof(*cmd), cmd->phys);
 }
 
 static const struct bitfield_data create_sync_cte_type[] = {
-- 
2.47.3

