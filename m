Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA23AF66C
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855917; cv=none; b=c3CiQEkU0cEClB20svC6/ei24sUtrjc1tAKWBVpe8dmfAIHtyvIItmSbP/0nF/3WsnZxI9bCNOT0jJuvxcNY1GC2pRg1JDOVq7g5gLDWq6w47dKkAMOk6BhglYnJToDx4Cz4sOYRfGw19fqHRP1W7/h4J4kAGA/ZlzyHPirQRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855917; c=relaxed/simple;
	bh=2uIUvMfiF4cgcvYk8bxAE2OZEuMgLEA/pRzxAF1Dg8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gz9ZP8sdv6Qq7D9nV2EG+92fN/EGsFvLzr34XxgD/ptJBXjNEIghAZE/woIiqKuBjtZL4dJPRzUq3Y62oIl918De/kFqnARVOuAMNuL77XQZ3nNkp7g2DIXB0thjImGixZzVnlz4VvSRD+hbiZ6nxdQfNucJ8+HDz3Pd56Hh2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFHev3kL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFHev3kL"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-90eb7a63a30so286814685a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855915; x=1779460715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0eN9vNuAp3xUezVO5MEgTAw6ZndItRaIjwbcaUfeDUw=;
        b=VFHev3kLlB+hNT3artTeSbhNGePXgT/NM2pyc1oHCytgG5QdRQ7vTgS1k0i3E5NV3a
         hi76eTOdBOA4vMoPdGzgkus4FRz5A7wsGZEdxX/mpJrtBWdW7uCEqgSb+kKzpuHp3vbp
         WHqH8nF8oK8ehp+XT3xI1RzIY/R1gnOJSVXU+XaliPE//Di05nYGkixykVtDvyYvlX/z
         9zarhtu2tJG1SbEBPAO6LAnm3CT/OWF7f45Qu2vT3H4y3mBlEiJA/q/qszzNTp++e+fV
         xVhyVOFUizNXjlV03ri9ehHYK5+fHZTZ0Am+qDt4rFVvZQst3reCCQoPhLvUqHk9KzAr
         zILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855915; x=1779460715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eN9vNuAp3xUezVO5MEgTAw6ZndItRaIjwbcaUfeDUw=;
        b=tZ0SlgzcJCnzmmHr23lux2HpHaLmluAsGdaTKzamukQZh3GQJBN7qWjAuIlaYUxKMl
         uNCMKXtys0ew6Dqz8eoCH2IcidOE0Wy8j9upSCfhENOxeuksZgJcvswiAJEBPgKb5n6n
         3BJFDqljJs+b3wNWPR4ROzgoUy+VDItscOM4cZcS07KcrR1CVn4+PBV811cDZr6/g/Hc
         RMs/BYXrLMLFe/3jDs+NlJzNT+lX7dcIxR6uBUGDKxDNOiFeycv75jmGY/x2JWCO8h14
         InzfXwYaIdn7wbzIRZqGwqa20ZdDWm63mdAUYkzXVtQ9ECkgSEhlyjAsrQh0214YrF4u
         yFeA==
X-Forwarded-Encrypted: i=1; AFNElJ887q0mEAk1ombsk8vhzxAPOzD1SlQPlk/LXlUhIv0Yh36wEvvoU+DvKe5dAgqvBFE2Ub+ZljrOqrpEv51suSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTuJ2w5I4lCwz60EKBh4mKqjmNuGLQ4B+cZV7cxVkho4JaQg0
	R7VpmED3Gr7oGBegRjTgmjqGfTmpDHwuYCC6892RoC9dcSnqSqRYgoMH
X-Gm-Gg: Acq92OGSSdBTlIfKHHQkX4WyrVQo9Y5p6jGgusHPg2FMduwiWSGWaoyXnXotDCI6JIi
	P4DGavw6cc8Nb0audFxkGGrsF2uu/Jh/UwWlVUCgYdRzh0wCxQwxSvEfm/S2+57jejvaVDfj2TK
	jjvoSxJQGs6bnIQ8LdEkF1aOz26jAnQlw+6myOAYV2QXOeO81HFXECoXODMi1RkU/I7cdn2GK4y
	a3LhBScDpGwUu5ubq0DBflTN1xG/vLT9tJDJi1ysXGtvdrHr87AXpRRSS2fvGAEl8B5GcFCSLj8
	tao43yNKYHhCZQp1TQm2RvSGt5NA2NY3VClorR5lDllho4YXTzZxsjH+PcoCfugy2w3ghMB2Zjq
	GL4g4KIk89TD5dLInmfZMFCsbt+8C1Hjx70whDbDsl8CMeZ9OGUG5d2ZnAaK9VKBGg3cdMZ4V6a
	eJtNDQfcjcv10wmJiAL6sJN7GJA52KMF7XZ/t5kr/aGvDQMw90T8laDRXcGFFbVmipGyTZgEtC2
	tutMczga72xrI4t87qxKp5CkH60CggK1+swBd5z4tE=
X-Received: by 2002:a05:620a:444a:b0:90c:c513:2b19 with SMTP id af79cd13be357-911cd9579efmr684135785a.15.1778855915314;
        Fri, 15 May 2026 07:38:35 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd8211e2sm562286785a.47.2026.05.15.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:38:34 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Daniel Winkler <danielwinkler@google.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: validate Add Extended Advertising Data length
Date: Fri, 15 May 2026 10:38:19 -0400
Message-ID: <20260515143819.1157807-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

MGMT_OP_ADD_EXT_ADV_DATA is registered as a variable-length command,
with MGMT_ADD_EXT_ADV_DATA_SIZE as the fixed header size.  The handler
then uses cp->adv_data_len and cp->scan_rsp_len to validate and copy
cp->data, but it never checks that those bytes are part of the mgmt
command payload.

A short command can therefore make add_ext_adv_data() pass an
out-of-bounds pointer into tlv_data_is_valid().  If the bytes beyond
the command buffer are addressable, they can also be copied into the
advertising instance as scan response data, where the caller can read
them back via MGMT_OP_GET_ADV_INSTANCE.  The trigger requires
CAP_NET_ADMIN in the initial user namespace; KASAN reports an 8-byte
slab-out-of-bounds read.

Reject commands whose length does not match the fixed header plus both
advertising data lengths before parsing cp->data.

Fixes: 12410572833a ("Bluetooth: Break add adv into two mgmt commands")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b05bb380e5f8..de5bd6b637b2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9110,9 +9110,15 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct adv_info *adv_instance;
 	int err = 0;
 	struct mgmt_pending_cmd *cmd;
+	u16 expected_len;
 
 	BT_DBG("%s", hdev->name);
 
+	expected_len = struct_size(cp, data, cp->adv_data_len + cp->scan_rsp_len);
+	if (expected_len != data_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	adv_instance = hci_find_adv_instance(hdev, cp->instance);
-- 
2.53.0

