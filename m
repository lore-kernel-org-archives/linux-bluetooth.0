Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B8401A32
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815004; cv=none; b=erUDdCn4XR1fW6SDGoUjhgw1Jjfh/DbuJtfveHH33nfTbn98rCb/68iDGBUjQIU3GeNLF60nvxu9diDnc78aSPO01Nf8fdZECfEGntymakZF1ymrfwACRDBdLvawbauPKvRCAqrmrTHvYroGMJupcv2AJvoyp7lz6jDCx98boJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815004; c=relaxed/simple;
	bh=Se2751wXLSqsctqJrMAb9FxYdxCfEo3uR1BF5JWnNaE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z/QGdxJrrGWsh6sUlSZ2YZEYRKuj2LzKj9h+TbuLrmVTyGpOvxDQdq/qBPUMIyLXA/qvCOvgqWQrcUV4q3GiG/o6Ah2bmivjrfKIwreE1954RN5SJ1IzDAnxDpa4kXuSvseGebSQf0LmIc/LJceeC8fv0eAzAbUSLUvxUewDLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7RadbRK; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7RadbRK"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-95fbe2d4d9aso2947427241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779814999; x=1780419799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=a3TYHiWKn2G32yZP0nkvExb76ZaNY+W2hhkCxJGx/NE=;
        b=W7RadbRKjVZYBp0VR8zeyddeYbuIYlBuke2QSrQgoLlCIQoUKo6Wefqo7sm7ShYk+8
         kiI2K1y1KK20KNb0SEUiRqOMgVMvw67tdl/IcopUaj+KJvLseFK9g4h2IEM3nQg6cBFQ
         abBj8y5pJ6ujkGc0Pp9Peuzalp3W1Q8+SKmOy4dKER7K/oQeUXJk+3jEeaoTQAX7W7Ol
         3M93IQEuyUnOZEOqkzo61opQ+3VDXj1aSm3rsF0roM+wDdkf+9QItvDIs3+wr0sL1A2p
         EWmFEz3QR+BX7pyrH2oZ2ho9JmrTN+svgXK1GM/Oy/goVe7o4WCK653ufT/QdFaRtxIf
         1amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814999; x=1780419799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3TYHiWKn2G32yZP0nkvExb76ZaNY+W2hhkCxJGx/NE=;
        b=UNS7HRGbUJEHZHxGuUZBjGAzAegHGGmNyq2oWlRyykAnFntW8nuMlZDT1oiLzcqYN/
         BniMElZuZblwIS37R9Elby3Xx6zY+UA3jDnIXDY7fXjtQjJ2Cz7G/fZncFMj4POezHrP
         gGaIf3Qet+U/sEzIZH5TAm9kObIlJc0v7VY5Taua00NC9VpEmwvNppH77twop6pjSo3u
         Sjj6CVSCsCS5IkTeTvbYWdAttSoSTcR10pg2haxgLtfAX8+4e5xaHCddkOVQnQlR8DYn
         SWuAJ6rQTu0sNhYzOlqqYMkzvkugyrLQOYyp53QSNtlLoqGnrU3lRPYgezOdp3oGvWJc
         F6HQ==
X-Gm-Message-State: AOJu0YyH3Cq5GVlgWYc+Svhxn4VWCXUoXcvTfuzYpbGlyqjf6Z82CXet
	lur7npb1NOqHI5Mxa+aTlHOq9003V8m5lN0Fc0CJgsuhQzjbqFkKMUnCWg5ihA==
X-Gm-Gg: Acq92OEp1HP84DUo2R9jrbVJLEos7C9o0keYkSGKv020fz6H2Bctks0cHqOIndA+ToJ
	zzkycriE/Y0N10+q+vvvtgTH41fmzEc5/q3t1yIZowOdWr+abh48lMtjzo8f4sZvdkg8SambpDU
	0LdQj7BuP91TEizwavbpoTCJR8huyoYYS0DLNjXHquacO8xKtxlcYel9b80/aEAZY3QCKg2hfPp
	FDLyScHh1UZnCEdBQkqMhTSc60ORFX7eB0wSudI+bJCUfPp3vACN0opGRLU9h0AN1tE9jggx47E
	mlhL6YZt4EPsWM9P3LS0Sam0anMScGsjyo+2BB3eY2qZnxFsFw5txNHAI5hWe0AEvCRgen/mP+z
	FNODe8rJTXihOlGn/gsuKR4yJ/Lw075+bI1Lwi9EAgZKr0MhNntMdwPdkxxWQYqPyjngmX4UnLt
	eDpBaJM79cAp/Wogd1gbfAMoSF8b9Ly40e6+mEB3BinShTDdItCJmHatpSHFPlBdb7SFGCT/IlI
	Vmb4JOvoDvuD0ESzCAxrV4oq1wA
X-Received: by 2002:a05:6122:f07:b0:575:38d3:7c8a with SMTP id 71dfb90a1353d-5865d70cb74mr11261247e0c.2.1779814999341;
        Tue, 26 May 2026 10:03:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-588c129cba5sm14603504e0c.14.2026.05.26.10.03.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:03:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] emulator/btdev: Add LE Set Host Feature V2 command emulation
Date: Tue, 26 May 2026 13:03:08 -0400
Message-ID: <20260526170309.3529062-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add emulation for LE Set Host Feature V2 (0x2097) command which
uses a 16-bit bit_number field (vs 8-bit in v1) to allow setting
extended LE feature bits. The command bit is set at byte 47 bit 4
as defined in bt.h.

Assisted-by: OpenCode:claude-opus-4.6
---
 emulator/btdev.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index ad2e025d1b45..3206caf5be86 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7907,11 +7907,40 @@ static int cmd_le_read_all_remote_features(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_set_host_feature_v2(struct btdev *dev, const void *data,
+							uint8_t len)
+{
+	const struct bt_hci_cmd_le_set_host_feature_v2 *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+	uint16_t bit = le16_to_cpu(cmd->bit_number);
+	uint8_t page = bit / 8;
+	uint8_t mask = BIT(bit % 8);
+
+	/* Only allow setting host controlled features */
+	if (page >= sizeof(dev->le_features)) {
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	if (cmd->bit_value)
+		dev->le_features[page] |= mask;
+	else
+		dev->le_features[page] &= ~mask;
+
+done:
+	cmd_complete(dev, BT_HCI_CMD_LE_SET_HOST_FEATURE_V2, &status,
+							sizeof(status));
+
+	return 0;
+}
+
 #define CMD_LE_60 \
 	CMD(BT_HCI_CMD_LE_READ_ALL_LOCAL_FEATURES, \
 			cmd_le_read_all_local_features, NULL), \
 	CMD(BT_HCI_CMD_LE_READ_ALL_REMOTE_FEATURES, \
-			cmd_le_read_all_remote_features, NULL)
+			cmd_le_read_all_remote_features, NULL), \
+	CMD(BT_HCI_CMD_LE_SET_HOST_FEATURE_V2, \
+			cmd_set_host_feature_v2, NULL)
 
 static const struct btdev_cmd cmd_le_6_0[] = {
 	CMD_COMMON_ALL,
@@ -7930,6 +7959,7 @@ static void set_le_60_commands(struct btdev *btdev)
 {
 	btdev->commands[47] |= BIT(2);	/* LE Read All Local Features */
 	btdev->commands[47] |= BIT(3);	/* LE Read All Remote Features */
+	btdev->commands[47] |= BIT(4);	/* LE Set Host Feature V2 */
 	btdev->cmds = cmd_le_6_0;
 }
 
-- 
2.53.0

