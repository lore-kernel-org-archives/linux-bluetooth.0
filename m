Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010732;
	b=IuVJl4/8p1UD5LGt9DVbG4GHoi7Lujmb0s2okpbRalOKo25RRicPnHFIOIl/mwkVFyj3
	 j9Yabufi7BNuqU7jm4/VUTRuINXirx0rUYDn0S4ZYdJu6sqy1mHmFiV3TRfxBMsE11tz0
	 OSw1X9mufyeD6jBn0Nowp+4M8/9BGELQBHLuU2gGFX+oeZtOKnECADqheH9d2MKiaAEqZ
	 QP2TS00zICgdEiVGRY1BMGFbVOpQt4oTRguq5+MaeQwVp69+l4ouQbSxSAzCenqnuj8PS
	 8Q0LQVVUq4MyAVXveYQsuzI6pwEfisbXWDzqO9k2PyLUslF9g2py/y5DRG9qz0uUUEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zrBSxGOYD/TbJIOane7YWPwcqY/2aJKMgwJ/bfJxsaU=;
	b=nwYeWQ5Wta9rEuMIu5++RxK3xdf3i5J8t8dYVlookJxlo/UelZWNilGrQD6O5aePiwyD
	 kzyjODKgvj3qMgppAf6S7Pgvdqo7NYBLy5rlwKQhcpuXqzPrml3s4C62L2rYz5jZcc7Gl
	 3+bm9DyOEIt32xFsOCSDCwG9oU36hTrb0KSfqqolYyYjSYLFrhkCij6KO/NiwS9Abq5xC
	 mucs6A9p/gONIRTJzHMQR87ikW/7k48bk9Bq/QU/Ox7HO47FemqAFYvzpvXo2HoEjcXwv
	 2l+JwCSjub0QwzuJHrV/pWudYTbnBol1nvJVZcUo2aRl49t3spEZ5d7ES0sYVgGkFbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDrZaDVE;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D5606A32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2D5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dDrZaDVE
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99075306daaso307345241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010730; x=1795615530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zrBSxGOYD/TbJIOane7YWPwcqY/2aJKMgwJ/bfJxsaU=;
        b=dDrZaDVEohqmZGsE8R52ob91RQEkvKNDnkPawLY/ZKfj6n6L1ijx9R2bzLRyEG+CIy
         nRo2LTdbx/jsq7YjdbNtJ90+M3U++BMvYwT3bttQvzjxFAE680c2BgPF1iTEnUmhaAV3
         HZOxJmNpr1pkutL6bckxCWBbTXP4eHMLYWU80VsJeXYroXeDxfABtLUTsKUG5r0OhfFw
         IcmX54jAGgaYULX/2RRbCuesbYQvVl+Ysm9PduAxxUnyn6CgQH8kXO/ed2wllRghmyV+
         o03/isjy+dSmKRxIzqDRcypbiBUrBiQsOxKTZMZf9Ko4WGNGJtroDFVJhlvvY83vrZtL
         bDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010730; x=1795615530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zrBSxGOYD/TbJIOane7YWPwcqY/2aJKMgwJ/bfJxsaU=;
        b=W6FSYpqlXBa8QwE/QRgHd+5HRQzqEtBcYTsWVhLzMAilpvglbUVCZ/iqhRf9yoYkln
         quFELwy4yFZLBwoN65s4aRLZD13rv/tTRwAoXX67y2r0ocgCWuLBIac+wAC6Hf1FyWF1
         GsVDv1VonHRTI1nZF4tCIZnfewi73217GxVAMb8GqcwmWonDu0RH3Pz6QfDVd5dqLvvN
         fLzDMpGE6pK+JlsnCXAAI58RD+7gJX+NHLruOeEFeuwsWfoSWn14YrH8fWUZDVBdNNX4
         idCtXIhpUmdTvP+QKQE7I85MhuSS2hheOPd1huRF8zEl5acCY3yW3KjjkklMUKGvjNek
         cldA==
X-Gm-Message-State: APuU4Z+OEnPLVqhIcuopMxOTZLpmMh2sMpI9A0weFREnXhb1Dodl5dR/
	zoFbNQO6EGGVFoV1Z9eFzqRFOYnZiLKHpTWNUJvKrCEZPXjJY2NzdwHj1nDSTmYe
X-Gm-Gg: AYBFou3xfg5XlvaLobwkmA20Lsz3AfeNZR0QPI46sPW3VOK5Z686OjTATRFwLH8PPTu
	BjxsdorNwLGFW9wSl93640rP5TqVXoD4L+y9A8j/ALVWYc13Oab3Eev9D5ook7k3q/zQhpNDgwF
	Mnoh3i+aibgbfCMnnpsDOYSPYNPe/J23KvDtbxoYMc0epyGdpGQuGABHj+bD9aOlSeprDfxnH3D
	4gIFT2/0Hk6wtCVIlSgBXlkmHQYUW8CDiP95azYxL0tsl/SQiVVOoAl7aAAf+q9oBL+6ybUGmbq
	L804l6WlOweMaQ5A+va3hk78/J4Me43p05gRAFw3igBnhtAFhv8Srw/RBGrhu3I6d2bsr083IYX
	83siqgFBR0He/5KN5mcurcHeZj2gSsZch/2eMEfgUUQgD/I1NoWi4Sct/MLRQ7ZFBYUkYDshEDJ
	DWVqCU+6TrcKAyDvqJ4ZjuU4IRBHbpXXLfPWhoTUUdOXKmOaIFT9aZbLcK0/i8YeNn9btNsfKQD
	s8upF1Rt9laJz9v+/0pR8ojgAZ5iVA8JIIT6/B4yxG8sXDS5keIct++eTVLZ/bAIud3enfuhxRE
	719WWEIDJtZU0kVzPZw2JlnDI3G81HAqE9f5uFfNgjkkZ/fyLET6mUTmr58scII4JqhH+t89mgA
	xoY2m65jq9QeBTcnzh6xzW6YNyDXaWo0kwUOAOxui5QvbIAIP7uILk+joOY0pg+MZbj4OQNWSx1
	hpjGTh
X-Received: by 2002:a05:6102:4455:b0:7cc:115:ddf4 with SMTP id ada2fe7eead31-7d6ba438ebamr665934137.25.1795010730407;
        Wed, 18 Nov 2026 06:05:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 12/17] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
Date: Wed, 18 Nov 2026 09:05:13 -0500
Message-ID: <20261118140518.59878-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

mgmt_powering_down() looked up the Set Powered command and read its
parameters after mgmt_pending_find() dropped mgmt_pending_lock, so the
command could be unlinked and freed in between. Do the lookup and read the
parameters while holding the lock.

Reported-by: sashiko.dev (linux-e45413fa-48a6-43f1-90be-638841567534)
Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 773411406300..a7f2008fa046 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10378,19 +10378,27 @@ bool mgmt_powering_down(struct hci_dev *hdev)
 {
 	struct mgmt_pending_cmd *cmd;
 	struct mgmt_mode *cp;
+	bool powering_down = false;
 
 	if (hci_dev_test_flag(hdev, HCI_POWERING_DOWN))
 		return true;
 
-	cmd = pending_find(MGMT_OP_SET_POWERED, hdev);
-	if (!cmd)
-		return false;
+	mutex_lock(&hdev->mgmt_pending_lock);
 
-	cp = cmd->param;
-	if (!cp->val)
-		return true;
+	list_for_each_entry(cmd, &hdev->mgmt_pending, list) {
+		if (hci_sock_get_channel(cmd->sk) != HCI_CHANNEL_CONTROL ||
+		    cmd->opcode != MGMT_OP_SET_POWERED)
+			continue;
 
-	return false;
+		/* cmd can only be freed after it is unlinked under the lock */
+		cp = cmd->param;
+		powering_down = !cp->val;
+		break;
+	}
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return powering_down;
 }
 
 u8 hci_to_mgmt_reason(u8 err)
-- 
2.56.0

