Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072442;
	b=MqbFVXh0/07wRgG1RHo+MZoT8iWDMOeW0xusNB15qZPh7s/Wvf5en+d7IF+f/24j0oXB
	 yypF1LHDUDmYkKdTvdMIG1r5TlR2nh8e2K19JRhxcRnAnz5qJuf7UlaKV74raLuq9/uKZ
	 b31PqalFKbBVRzc1MFP6fdk5v8Bf1Al0T7FBG+LwJij0sW43HI170Yj2JXOwi1EPePmFe
	 HJ90F0FIJZh/1buJ/TThi2ikNCS7L4pEg8YmGX2tnPWmvsrsSSGXAq75LV+fPczXR/DrM
	 I+nuo2SWDRybJrrLACrd0S5+K+GokMxRLmx8wNAY/Qm7d292cnu6laHexwOXdzG4PYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i3iKnLh6NZmOvIo+AB+CizexH4TnqVcWJP+0t5Ki0og=;
	b=arp6W38KZBub7qdTVV8cIdDpdYcDtCyLrwj3L/XMFghJR7luFcckiedADl8t8s31gJ42
	 OTIoI4ibHqzwBIOgFVijXPoaQYLwr91RFNsRBuGgz7+DEId5rQeOzXnZ2Ov+TsvbwcEEQ
	 T8YuHtKkpW+kBVcCKc01VraOrvR+nQ3krJrNrFx80VVN1Ts5hTQl3yx/KcFntyJ+rmSYH
	 N+EDxLQfs5hh1JwZ8Y+tG4F9p6svDUyJlYrcr6bxbcHW6x8MbGyRdczUT+Eyxl7kETkLq
	 YhTjZvXESs7TNAmaSm5MfsANZFOdbsg1IiM0K/zkQyJ0uXXloLAtAM6x4EKdCtiPc7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BL32lDGs;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BAE606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 07:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9BAE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BL32lDGs
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb7679f28bso1495785e9.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072440; x=1795677240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i3iKnLh6NZmOvIo+AB+CizexH4TnqVcWJP+0t5Ki0og=;
        b=BL32lDGsNTRiwwf4CRCcPRtzRc9tVwrWPjeTd7okFt/7ORdDyvXNOP/z061oejJiPi
         cAif2tk2c2tveDdisYeiu3wmhLpfW+DZ7XPjdt+YM9I8OsUACEJPrLBHVL6Exclpg2K4
         Jaf8omxmW0zRUsAJyf6LO4m8MRFoWxrL5gWkYdHtwyEI116mLiopC6p+RIEF7vVI2j8G
         jhsRZ0OkT+/cMGOrLDzX35/HJ8SXk6/cA5G1+PL5Am0gW54v+FDw9dTDlaHL/vpPbC+M
         zRvERcmtuHjD4EQrHmu2IUc8sU5EeI96TBeXT9ZC+xINcIXBZ1uyRyErs6YMZfJPgRos
         eXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072440; x=1795677240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i3iKnLh6NZmOvIo+AB+CizexH4TnqVcWJP+0t5Ki0og=;
        b=ed5PlXY2DxzS/wbKflZ4hoy8TXN2UT/3HcrMa5ZVJsjFTgARgbLDLE/kfpyu7/NQJs
         J1KONqLZj0X0t+yjUC242HY6nzcjI4FfvtYH3DvDP8yR/S5Li5/E5HQ61ChmXihRtgrL
         hNfgbB7AXCo8zecw5tunOvh1g9XlDho3ieLEMQ0AS7v3cB8NEUxULhG2heoCSk+zawCu
         jTAm82M5TJ+dUeEBNSdrJWFuVn7HvCWlm498zAH98vdbebhSk7iuOd4FemZ6ODyuQnqJ
         INhES1WnnZMJhaS+Y1N2TprRsDEY4+xbkF4Dh6bsFSJ6eN2Vrj9SKGqKMY4cE2EZ8jcm
         TSbg==
X-Gm-Message-State: APuU4Z9uI+np+BSLD2ajiUNpJIoTY0s0W3Mia+fUY66eFk9AM9ZWQ2LS
	EyBX0w39srKMFVZsdvF9VkMScPxB74uFPyHBUf0aQNWUlgP9DxYIvKofAV+XKZa1
X-Gm-Gg: AYBFou3MRiaALAVoABkLDo5/aIwflS0uBc/VhFRksAIiWkdxSD/MhevQ/bzjSPyHH82
	uk0reX/reWxGdZ0kulpuckyYHSU13AkkSn7Icc89HqFfB7q5cdk/nWvHcjzUvU4Mw1oXFSCXbzB
	C/eh7/tDzoTGcvP3ljLTxS/0xNXGyXXjw4BCbe0pqrYptKh6p6we8wq48ExgBfRDOzb5VEnvSjn
	muA9fRF9K2eiV71FJhr+/0M/DgZadEIHNfGvE2S4ZtQrkoWWVhqRhmxMAN+VYTAsENAYW7e+zC5
	yfPAHpajJQ5lKOsbo0RzOL+tL4ZkllbC5JaD2SjBrAfTrvoZxSAlajdwoMIQLRkSm2K1CD3h9vs
	JfGb+jQDB1ef3J5fH6CYPl5AQ0KSZ9sRVnRrQGIN7561JbEMa+8m1SBvJhLJOUDM3/nMW+X+KB9
	IGA/hUC2F54Sex5hnpZaJiBhtty9XGY6wpu6yW5QnFKt0z/aV0/RNMcNp6qfzmJGhpsZ31dicZ8
	oDS19I0ZQn+l0K238454RcwHMsu7iyhCfgv/N16WAiCCWeMsqY1DxZKD1ZwHfM8nYhozdLTxS08
	gX/sSMQOB9QbQmIHPIDjtiOBtqLHaRnb/RM=
X-Received: by 2002:a05:600c:2e0b:b0:4bb:6a02:d42e with SMTP id 5b1f17b1804b1-4bb7da033b8mr56511275e9.1.1795072440279;
        Wed, 18 Nov 2026 23:14:00 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm17549165e9.6.2026.11.18.23.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:14:00 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 3/6] monitor: Fix PHY decoding of LE Ext Create Connection
Date: Thu, 19 Nov 2026 08:13:29 +0100
Message-ID: <20261119071332.32424-4-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119071332.32424-1-rolandschober1968@gmail.com>
References: <20261119071332.32424-1-rolandschober1968@gmail.com>
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

Check the size of the command before decoding each block:

        Initiating PHYs: 0x01
          invalid packet size

Fixes: e29ef3b85116 ("monitor: Add LE Extended Scan commands decoding")
Assisted-by: Claude:claude-opus-5-5
---
 monitor/packet.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 0adc0144a..ee9e63496 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -8816,7 +8816,8 @@ static const struct bitfield_data ext_conn_phys_table[] = {
 	{ }
 };
 
-static void print_ext_conn_phys(const void *data, uint8_t flags)
+static void print_ext_conn_phys(const void *data, uint8_t size,
+							uint8_t flags)
 {
 	const struct bt_hci_le_ext_create_conn *entry;
 	uint8_t mask = flags;
@@ -8827,9 +8828,16 @@ static void print_ext_conn_phys(const void *data, uint8_t flags)
 
 	for (i = 0; ext_conn_phys_table[i].str; i++) {
 		if (flags & (1 << ext_conn_phys_table[i].bit)) {
-			entry = data + bits_set * sizeof(*entry);
 			mask &= ~(1 << ext_conn_phys_table[i].bit);
 
+			if ((bits_set + 1) * sizeof(*entry) > size) {
+				print_text(COLOR_ERROR,
+						"  invalid packet size");
+				break;
+			}
+
+			entry = data + bits_set * sizeof(*entry);
+
 			print_field("Entry %d: %s", bits_set,
 						ext_conn_phys_table[i].str);
 			print_slot_625("  Scan interval", entry->scan_interval);
@@ -8880,7 +8888,7 @@ static void le_ext_create_conn_cmd(uint16_t index, const void *data,
 	print_own_addr_type(cmd->own_addr_type);
 	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
 	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
-	print_ext_conn_phys(cmd->data, cmd->phys);
+	print_ext_conn_phys(cmd->data, size - sizeof(*cmd), cmd->phys);
 }
 
 static const struct bitfield_data create_sync_cte_type[] = {
-- 
2.47.3

