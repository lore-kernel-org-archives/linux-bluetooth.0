Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815308;
	b=S29UFNedgOR3GzwXZkuJ4tpBvnTYgxFRUSzQHmvIBlCq44zz1MYHwyPzRrPXp6w1/l/9
	 jicVM4JGx+dqN9icHXJ03qxfXPALjeTJprMBt1ar4KWxGRzYNipvGewIHGSYTOxfFEgxK
	 ZzDRtpYorQ6jc9jMjhq+Yp0u7UiS49OsnF/zzuKwXGkO8heLJ06xYwBPddn05IynybR9Y
	 jWaGQdX9ZuDk2vLsfkMmI/wLxf6A0bGam8lfOsLLU7ief7M0WNifmTjDMnKKX7Z1rwPtm
	 qrjFPZ4vOH3G9aRXksJmVwHU5SJMqgHg/9KyM6Ew3ZQa4iJ87QWvJPxiJQf2d0hJRPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QwzNyguAgW/E53FqydeO6avTsx4+4SzXYfxWgKgZF24=;
	b=hTq1XROk0bX8ERWMCpeocSvLkRg/Hm01G/2TqAXbOeweqZ3PcpVy1FtAbS3XOUylZ73q
	 pj304DNDF126PTmgWmWs0+W0tYTRUCyLqACR3z0RJjv5pUcrA6H3FvFqeILCHdXqLdvKH
	 kIc+wFTh3fb+ZLWXyZkgBtWlxP3hjmBxIo5y5UBekmZoXIbnGEuahGDvR1l4tLzS0GZ1m
	 hU3/9g09pTlWwtJyG2l+haA80ZiW0ICzhZxdnAW8s4m5tOBUHaCpRgI+XMi7D/oZ99wR9
	 Z83TKw29lheY6JCLDf/F5LjgLyu/vue5WCsn0yrCLj3ZUSpWQr35Y8ziPto7Jg8GUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DzR/ylnR";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B14606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 21:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B14606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DzR/ylnR
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a440c9e13aso620604f8f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815306; x=1796420106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwzNyguAgW/E53FqydeO6avTsx4+4SzXYfxWgKgZF24=;
        b=DzR/ylnRo2QRWJxxQZwDEk29vqjLGLuzpTavhcYcFaWell2iKLsmLwcqLmcnMlE8NV
         Vf9FSE9/WKmZwD3JC6BXxWRT+h51X2W5+ohNIbvhoGLo4lP29sj8PXAjFEfx8hB9Vj91
         3VqyWK33lV2eCLfpw/qsLvibzL7CsTOzpkNkfUCSwSjnSjQ88H9Bjz/pKB5HA3CfwGbW
         jGXiI7UKyN6CBGHBBDqPPvhCOelXjyNeG7LsRQIj+Bq9xK2KsMiv/akKIdzsVaD7l3Yk
         OObrlvr3nlK/Bjx/6hK23q2Tw8+H14MbErgf3xu1bZKCu8IHc9CC31GZa8v7u/zRW8aY
         8bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815306; x=1796420106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwzNyguAgW/E53FqydeO6avTsx4+4SzXYfxWgKgZF24=;
        b=luUOryRcOfReXsIfdgz/C9b/FEAiwR8hjnrIrpsUPjGl7qcGCG7o9hqHSiLfioXTJH
         Zfn8mos4fCjpxiYV2/XFmMUVDn5pSTmFiNMBbKIQfxiZZd/zjV5aOaQr7UpytmQMijsO
         ozDk1OLFofWXlCNyyWhmJF9BMdB87QmFZjtlzy7PVZB0tOVRcr8yau3i7HJCZxl/hIra
         Mzad1XI/+uo+z738uE3B7OMWOnI5Nx+DnsCqLA45Iba8RIh/F6r8aPOW06r3XIEy9Hzz
         zyT0FUdPWBiSEa/yhMdHvx9GzYx0OOT5eXzSUvgHS7czPu45d4bSgu0BX5Kl9C5ecp+f
         qMaQ==
X-Gm-Message-State: APuU4Z/ktojKLsCtEjJdJu6kERJNfXcAdrKmE7PnKwNzed0zLE4EMpyA
	nm079K9WxXhqdpZMI//6E/bmyaaFVX2XSjzI6aaq72o6F9/SZNEftRr9hUU7qQ==
X-Gm-Gg: AZFdTZdVyMK1VgHyFDsZ0W+xD8r81vCVaiYDX+qmhStN1aWBC38ukKodII082FJw12S
	VR+P0QLYDJg1pl44wUMeCqWwOmEA7OVBvqZdiBMkruvt0OpmII10lvjqPMs/v1H95TsrwqTuw++
	SEXdMWbsofdSA0N7IXdlOcO7qfUzccp74yJKiCVcsgdFYlL5PfC8nHz4TKO/sfemneCF5BYoxKt
	bvm12nwWCAhDRVs2KqPp9GNKTtumvCCRGRTcVd7gzntTWswhNA1mKPXqXWU3laZqcvbooyKhgvo
	01tenS2E2ZhU69y4EOnyJ1+EjpdD+FAGet4/u2frY69Kqt6uNQYg45MEY5IVo3Nv1y0zXc/Ae6v
	O2mKHr9joUVZ8TgdYgMcgJmpchW7+9ua2XheJsmfAAhEMyFDwqZlKCCOBISS3CjQac8eZQXGOOL
	Rd2+omzgyrtEaHA0+iSZ6d7gaIxbCszfv8LUevZ1qp3px76SrzS6sCXDtaz3lmAgBWMaS/jX+Cu
	gVopLBvRPlIVIZBSLqTQe9iVB1R4oqCTtXkvVT8pMoe9UBhPkk2CCHlZ6oeURilYz56l0bY88KK
	oTrlMUBP0Qn5aUtF8n8VPN+0CyvV9Nv9oKVKmHYoNT30DkVDQQ==
X-Received: by 2002:a05:6000:2983:20b0:490:3f9a:5173 with SMTP id ffacd0b85a97d-4abb30b95c7mr39702440f8f.4.1795815306211;
        Fri, 27 Nov 2026 13:35:06 -0800 (PST)
Received: from schinder.fritz.box ([2001:9e8:b3a5:d700:4efd:de8c:f09c:9d10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm48571870f8f.32.2026.11.27.13.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:35:05 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH] Bluetooth: hci_sync: Disable PA before removing an advertising set
Date: Fri, 27 Nov 2026 22:34:37 +0100
Message-ID: <20261127213437.121157-1-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
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

The controller answers LE Remove Advertising Set and LE Clear Advertising
Sets with Command Disallowed while periodic advertising is enabled on
a set (Core specification, Vol 4, Part E, 7.8.59 and 7.8.60). Both are
sent without disabling periodic advertising first.

A BIG is the one user of periodic advertising so far. Its own removal
disables periodic advertising, but powering the controller off does not:
hci_power_off_sync() clears the advertising sets before the connections
are terminated, so with a BIG running the command fails and the power
off with it:

  Bluetooth: hci0: Opcode 0x203d failed: -16

  # btmgmt power off
  Set Powered for hci0 failed with status 0x0a (Busy)

The BlueZ emulator accepts both commands in that state, which is why no
tester shows it. With the emulator following the specification [1] the
BAP broadcast cases of test-functional fail, as the controller is power
cycled between two cases.

Disable periodic advertising in the removal itself, for one set in
hci_remove_ext_adv_instance_sync() and for all of them before LE Clear
Advertising Sets.

[1] https://patchwork.kernel.org/project/bluetooth/patch/20261127085525.264299-8-rolandschober1968@gmail.com/

Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Roland Schober <rolandschober1968@gmail.com>
---
 net/bluetooth/hci_sync.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ee426ffeaa03..a1c723aad55e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2263,6 +2263,13 @@ int hci_remove_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (err)
 		return err;
 
+	/* The controller refuses to remove an advertising set which has
+	 * periodic advertising enabled.
+	 */
+	err = hci_disable_per_advertising_sync(hdev, instance);
+	if (err)
+		return err;
+
 	if (instance) {
 		hci_dev_lock(hdev);
 
@@ -2392,6 +2399,32 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	return hci_start_adv_sync(hdev, instance);
 }
 
+/* The controller refuses to clear the advertising sets while one of them has
+ * periodic advertising enabled.
+ */
+static int hci_disable_per_advertising_all_sync(struct hci_dev *hdev)
+{
+	u8 instances[HCI_MAX_ADV_INSTANCES];
+	struct adv_info *adv;
+	u8 i, n = 0;
+	int err;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(adv, &hdev->adv_instances, list) {
+		if (adv->periodic_enabled && n < ARRAY_SIZE(instances))
+			instances[n++] = adv->instance;
+	}
+	hci_dev_unlock(hdev);
+
+	for (i = 0; i < n; i++) {
+		err = hci_disable_per_advertising_sync(hdev, instances[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 {
 	int err;
@@ -2404,6 +2437,10 @@ static int hci_clear_adv_sets_sync(struct hci_dev *hdev, struct sock *sk)
 	if (err)
 		return err;
 
+	err = hci_disable_per_advertising_all_sync(hdev);
+	if (err)
+		return err;
+
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CLEAR_ADV_SETS,
 					0, NULL, 0, HCI_CMD_TIMEOUT, sk);
 }

base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
-- 
2.47.3

