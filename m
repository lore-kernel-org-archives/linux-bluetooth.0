Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF2488DAD
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361806; cv=none; b=AK4zkzS5WvdM6j1at5W6KA/I1ybq7e337JpG17cGYiIyYJPCqBU0PeyQa9DheX+/A4zDh72l65IG7k1PPPqDOw9ku70Te86fHpUDzfn8yBPqAaFkXP2LAc0pyVMxRFVMa2aOiqBwu1tfN/NDGux4Q2KgZDUsLSWyYVgmWqNvvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361806; c=relaxed/simple;
	bh=ULGJdsPdWDDAtxoOCSc7hWr9tTPD277AmU42AlXSHcM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBBX8+Lgx6rf2dKHdGe4VQrTipJeBwml+Ztmf0djBXaUT5eIIIgopAA0LhFAg1dKFYb2m8CrFWrdlQFjIK8bfCJFDV4/O88KM79f6hd53a3r6zzcy/dcWH+cco+XUXjqmcvFnvYAxTi89oyrJkjyR0/fxNhiCxHgs6egzwuxKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILWJiU+y; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILWJiU+y"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-784980b88acso518435137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788361803; x=1788966603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f7TgOKrbX5IcGhW9dtYyUqDJgDSZl8HMGs1HHp7yxBc=;
        b=ILWJiU+yoSHv1LFhFTgjmUFRiOThMFma9PvkNqkeo31RZIcVfNFQdKPx0ojl//idD3
         49Rkv8H+F0VWdbX0RT24MlsRYoyFqwsFFrSAmWxVLY7Vg1w21epY9eI8tbU2lsHjDi6Z
         GPvy4kr5AUHMCEV0itOg+KJzugVXiHyb/YRc8TRSPMH2g2S0Rbd31RTYg1JlLUTb1MNm
         QLRGfALh+H/1+tSYMFu8rzEdec7y/zOhCdR9Nz0LfjOIxAS8mIv21WAkEkN8Ct/in3Jd
         LTYu+zrwGW0LteQcUCeMMNaKCgjE/msjy3tSY5C/jCyVmBXytQGzLbRWtUKFMkvbzJSW
         93gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788361803; x=1788966603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=f7TgOKrbX5IcGhW9dtYyUqDJgDSZl8HMGs1HHp7yxBc=;
        b=A6oXdbjPzbm0MKl40puAmQfsliw6NJ//46reysKjvlcKwOUTD493iOqicaXTzQqq6p
         kAJqSgMvw6qfq+OvqCBfm4iquRX2tYsMI2dSRsY7l4CYegz4XHeth8/bi+IJuz9swlt/
         GhJsr5VJlTuEwhGASPzXjufx2soPxTtNoD7apx/hVz0HVul8ymfgPkUDsjlgxyLuSQp4
         1PD5JahTD18xq4bnakbq4FsqFQTkrIgKQGuYiJFgfPuWji8M13GF2V2XMpE1U3RmajkI
         oK9XAftkytCCftkplkcFdJkPPM2busDspBfDmljmoUPUtL2/Vsz3xV3WRypdUSZiR/Uz
         +P1Q==
X-Gm-Message-State: AFuF++lh4+qcgC9hYJVcLcCypsU7s6bfSQkxbasdHq/xE3QqGGcAtIIB
	wkF0J+K7/zf21ftLOmMb8fduXlPd87vaIuNqOAeSWLzvCw5stLLiAXKd82q5hplAm+XV6w==
X-Gm-Gg: AYBFou1IqjtIW1e2bwlmNSSM6RZx1ZDEZNACCn2JkmZSSgsNFq2svYeCs3DNnQwBJP4
	z3N0uc7iINGVAYofCvFzUrfavgCcaQ71KvRaxiaf2GC8gAGNhoYa/NJ6Jc8xudQGwna/POf7jzj
	HTlc/mYQ5/J7qQu+NwyvByYk2z3D57VJ/CHfdcw/urv6j1OrorlZWOBc06xakKv1jAy9tisE2Ht
	aCcyXZFEgk9Bw4Ry6ktTwrt+5x9D0r5u8OmDNF/eDzPkwGjLqIJGA+4W5Ezc2Z5odW0tvzPiy6L
	9ImVYRupHUFoyY3Xyfg7wlNySipc+QrrYMrPKjsjQ+NKE5SadDoggAZmGJoOrcojpmBsUNaEM79
	1eGGWcxyu16IVXwP2u8XBavz+WiqATvOfYDcHPxnP6BKEK1jWiVTzQ1zIP+O4hQaoMAxnNCIKSV
	BrAT7zRTvVczvrd/8mmtzb/jE0VdP/jOSc9+IHRl+wXUf9Ml99xKGpka15+Wn3hqKUMzXnbjxVR
	XcYC7UsaWNAUpIjduioxNpsBlGfnQNSGW04HYfmbX6AZepkMqEtXKU=
X-Received: by 2002:a05:6102:510c:b0:777:ab3c:b88c with SMTP id ada2fe7eead31-78a1f31b40dmr1565417137.8.1788361802849;
        Wed, 02 Sep 2026 08:10:02 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a510ca3sm2355265137.11.2026.09.02.08.10.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 08:10:02 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] emulator/btdev: Check valid range of CE Length
Date: Wed,  2 Sep 2026 11:09:51 -0400
Message-ID: <20260902150951.1583184-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902150951.1583184-1-luiz.dentz@gmail.com>
References: <20260902150951.1583184-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The connection event length recommended in requests by a Peripheral has
a valid range of 0x0001 to 0x7CFF (Time = N * 125 us, Time Range:
0.125 ms to 3.999875 s), so reject LE Connection Rate Request and LE Set
Default Rate Parameters with values outside of it.
---
 emulator/btdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a53bd82526d9..bc573c3a2370 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7963,6 +7963,27 @@ static void set_le_60_commands(struct btdev *btdev)
 	btdev->cmds = cmd_le_6_0;
 }
 
+/* Connection event length recommended in requests by a Peripheral:
+ * Range: 0x0001 to 0x7CFF, Time = N * 125 us
+ * Time Range: 0.125 ms to 3.999875 s
+ */
+#define BT_HCI_CE_LEN_MIN 0x0001
+#define BT_HCI_CE_LEN_MAX 0x7cff
+
+static bool valid_ce_len(uint16_t min_ce_len, uint16_t max_ce_len)
+{
+	uint16_t min = le16_to_cpu(min_ce_len);
+	uint16_t max = le16_to_cpu(max_ce_len);
+
+	if (min < BT_HCI_CE_LEN_MIN || min > BT_HCI_CE_LEN_MAX)
+		return false;
+
+	if (max < BT_HCI_CE_LEN_MIN || max > BT_HCI_CE_LEN_MAX)
+		return false;
+
+	return min <= max;
+}
+
 static int cmd_le_conn_rate(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_conn_rate *cmd = data;
@@ -7974,6 +7995,8 @@ static int cmd_le_conn_rate(struct btdev *dev, const void *data, uint8_t len)
 				UINT_TO_PTR(le16_to_cpu(cmd->handle)));
 	if (!conn)
 		status = BT_HCI_ERR_UNKNOWN_CONN_ID;
+	else if (!valid_ce_len(cmd->min_ce_len, cmd->max_ce_len))
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
 
 	cmd_status(dev, status, BT_HCI_CMD_LE_CONN_RATE);
 
@@ -7999,8 +8022,12 @@ static int cmd_le_conn_rate(struct btdev *dev, const void *data, uint8_t len)
 
 static int cmd_le_set_def_rate(struct btdev *dev, const void *data, uint8_t len)
 {
+	const struct bt_hci_cmd_le_set_def_rate *cmd = data;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
 
+	if (!valid_ce_len(cmd->min_ce_len, cmd->max_ce_len))
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_DEF_RATE, &status, sizeof(status));
 
 	return 0;
-- 
2.54.0

