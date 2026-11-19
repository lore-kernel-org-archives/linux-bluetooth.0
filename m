Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795076199;
	b=vtZSgBn4wCZ5bO9KcRbJOcqKJ7jmqY/iP6SpHngWeSPdDRGZBJtm1GIGop4vSdiriTB6
	 z8rYCi3Jxtn5x2cCqy3eKppSEjTvP0ckFLOo43VuT6ynOtX35saf3sB7YVnDTqY6YGeco
	 Px/kIfeU/Az/1m+eJ8LAQtOf8sgDg7hRkyXff8T1lGPWBdf71iogec23Z+48YwHaFwIRJ
	 0uqtKFmcqomj+IhRFQFBmpr3Q5xpMfPLV6rTSj6oJT5Io0F+P7fPHQbfDlh63Ma1dbovZ
	 ou/5KN+hbHy/mpL8KUb5VE9p1hGMHTwOScBG0atILjyEwwIWI/F6YUnqQNQz442NqMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cfo0FeITPqb9ldTT7O4YGUYupe/uN7L2wXf2oydgreg=;
	b=Uci9qeAdF8HVISf3YZLkqBImMVfJkDecwVQ+TlUL1yvEdlG5Yzf/9d4ityyQQW2mPC7t
	 V5FB227bfFkqmptcT51rAuEcPWZ8vagjzO8RH2cRDekNBK//Q2iRNKEzHAps1+grsPQFy
	 BVuhdrVSqbmUGHal6LVrt60nB4Q21gJAG35DUgw3daZNSHeuZGbcFAsR9nQ/lHJLVJJYj
	 NfbBkxEpvQO2JsFGibnY30whD+EtOvTMhVZcVWXXYKwerM0gcjuKtZLoEiZTntXJrICkF
	 gb/cnKECF2K+4/JQrXmaWLBTpdjpsFr/b82gatuxQgsjqAJEgu88eXHfxLgXDjbNsIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TozSNliz;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871E606A805
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 08:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4871E606A805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TozSNliz
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b89399d92cso275623a12.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795076198; x=1795680998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cfo0FeITPqb9ldTT7O4YGUYupe/uN7L2wXf2oydgreg=;
        b=TozSNlizD8RurSJ3KgmKo7GeHivtIDlnw6O8p37sGRSBe6RfeWMqGz+xTEEYmI258U
         MtGfIi4z6Todiqz4aRR84cA+5GQz2/FLZQMjtSgAw+rQBbMennQuc0EoWFYi4couKWHv
         Y1a6V9+tsjqMom+yxnedy4GQZPh4ei9EWRugk4DcB2Q6DuQw9Mk1S5T4zcdy9ESxxysy
         gVygOhdj1dckPd8p0OnNv/ySp4oOW+kyDnLlDbszJ+7Ibl3ju6wH0rpJ5UP6ZgEy2yRA
         aVTB7+OUVhJ2UF5uz3cSJmYaLiDNXHwZrGnw3UjCPgkaknTfOrGs/dJmMa/srALgiyGU
         Pc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795076198; x=1795680998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cfo0FeITPqb9ldTT7O4YGUYupe/uN7L2wXf2oydgreg=;
        b=fPHgn1FCwnbWairZ5tMayqpwO9XQ8KGoq5RlT6cNZE4eFyh9WH0fKMtcxHr1uhJuTv
         7DjVXkuf4kMhNw4KiJQmdxz0Jqjnuc2fog1zE9NO4tAgxcvvPsLaOc/T0hGgSh+5XSbG
         EznFPL+rk/+X+EHhkdcWd0mepODaT48RpoCb9o6kmOHHaFchW5iAMWTW6Sfq4pNwlpJq
         t5hvMAlFVzFJtemOO7ntNP7ZtilrhXxWiP3wtEJuBnkmh6y4ZpdrnVvvKMLXS/fn8nZe
         JogO20PhPfH+hi9II0ZBRC2zNFmgYRQnREQ1i1b1NZk27BUJEA1FEJ8qIlKzG5vGE/aZ
         u7bA==
X-Gm-Message-State: APuU4Z95nWlsnsVy15ScpaEt/cb+Rxlsmnmo2TEmJIuF14z9ZondkvX0
	2zPWKhxaJZv0ak17iQm+giBZkcweEgqLm4l2ddMcyvBVF9PE0nVmR1grD1YXslWR
X-Gm-Gg: AYBFou2dOOShSgBUFQsD0WnDW7UjIpGCUlZ5UbadOx8fvUjv58qGAFAXJP4Pv01hVTI
	FtFMMrIV0w0L++xQUYrbvjtj925ErREUvNQdLE3JTZOb3P+reotf9ioJC4j476qBw67A++FmDsD
	hopbtm5P7ibtNFJCFewmefiVXhCLYXmQkdZQn+S2gHeI6Mtv67LZBQ25WXZUBtk9pvqqPhXktSC
	iaRSEvCmK/KzzM6ESJ2kG1f8sMDhHMm1qoP2ov50Ci1KcMBTF4jV/7oZD6nqHy6z8MFsXcIhlp2
	GgZtqPpC1MRQ1XLN7gXv+Zk71vn7xgPCw2RWhZ+mpknUk7bJnXNqdSwW4/YlKBl7+kh3IwAObA+
	OK3+jiQnozoKDiJUFK5I/W5Z1jtkub8JHeMpDE4HjRvxfX7qblhcL+WgVxlKqJdySAeKA/wqeEV
	fmwO4zu3UkuQfAth88QcTCLRXeZDyNR3Hu9ZN8mFTlul5MCatpob7bDnkyTezGkOXRE5CdF5L2d
	HBMsdvkfjLMnDcXcbn4SJzI3pW+3+gTfWHDZG3YWYb1jr4EXTSRAPt/rsOpk8OMClxSNkUwcPqT
	zhh59bNjikhQtwTTxrypSDs2yC6zhqbiJu8=
X-Received: by 2002:a05:6402:3137:b0:6b7:aca7:4cee with SMTP id 4fb4d7f45d1cf-6b887eac9d2mr4348188a12.3.1795076197322;
        Thu, 19 Nov 2026 00:16:37 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88a22e143sm2229580a12.29.2026.11.19.00.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 00:16:37 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v3 3/9] monitor: Fix PHY decoding of LE Ext Create Connection
Date: Thu, 19 Nov 2026 09:16:15 +0100
Message-ID: <20261119081621.112623-4-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119081621.112623-1-rolandschober1968@gmail.com>
References: <20261119081621.112623-1-rolandschober1968@gmail.com>
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
octets left over after the last block:

        Initiating PHYs: 0x01
          invalid packet size

Fixes: e29ef3b85116 ("monitor: Add LE Extended Scan commands decoding")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 0e40300fd..c290dbf7c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8816,10 +8816,12 @@ static const struct bitfield_data ext_conn_phys_table[] = {
 	{ }
 };
 
-static void print_ext_conn_phys(const void *data, uint8_t flags)
+static void print_ext_conn_phys(const void *data, uint8_t size,
+							uint8_t flags)
 {
 	const struct bt_hci_le_ext_create_conn *entry;
 	uint8_t mask = flags;
+	bool truncated = false;
 	int bits_set = 0;
 	int i;
 
@@ -8827,9 +8829,20 @@ static void print_ext_conn_phys(const void *data, uint8_t flags)
 
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
+			entry = data + bits_set * sizeof(*entry);
+
 			print_field("Entry %d: %s", bits_set,
 						ext_conn_phys_table[i].str);
 			print_slot_625("  Scan interval", entry->scan_interval);
@@ -8852,6 +8865,12 @@ static void print_ext_conn_phys(const void *data, uint8_t flags)
 		}
 	}
 
+	if (!truncated && bits_set * sizeof(*entry) < size) {
+		print_text(COLOR_ERROR, "  invalid packet size");
+		packet_hexdump(data + bits_set * sizeof(*entry),
+					size - bits_set * sizeof(*entry));
+	}
+
 	if (mask)
 		print_text(COLOR_UNKNOWN_ADV_FLAG, "  Unknown scanning PHYs"
 							" (0x%2.2x)", mask);
@@ -8880,7 +8899,7 @@ static void le_ext_create_conn_cmd(uint16_t index, const void *data,
 	print_own_addr_type(cmd->own_addr_type);
 	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
 	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
-	print_ext_conn_phys(cmd->data, cmd->phys);
+	print_ext_conn_phys(cmd->data, size - sizeof(*cmd), cmd->phys);
 }
 
 static const struct bitfield_data create_sync_cte_type[] = {
-- 
2.47.3

