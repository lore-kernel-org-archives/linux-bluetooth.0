Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1DE3D954E
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901335; cv=none; b=QqR0RZz/fXmj3AnqjAlWY/I1SoThIytdHjkzcvuCt3YX6vRI3ExPotTREIflW3Ne7A7T11BLPUd2kp6iUlXI/tX2Zc6g0XXql3vg0zhQQ96BTc6nT2nCfGpwqxoFS6QU2IgwfquB/F7qPD6/TeGPPuL4bYCpD27jRp7/KIj8O6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901335; c=relaxed/simple;
	bh=KJkGa+6OxLGJ7DrcEE5Msti6SRw8Dnet0iFpMWKC0a0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IzihEDWocgNTQcI87uM+Etb1LnY6lA/UcRexytoXV2D89g/TTGUnD16MYHKXuhJxdTa8qzvukV6Aq9Nqu7mHGefoOF2SnfZyIwUme8gaJZDWNTjMVGv2QLZZMaByVCYQdmNqmlSbXz2hSnOdQ6c629VW3zNpeP/XQxhBFmxgU0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQD+XoPP; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQD+XoPP"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5d8e5624261so1145835e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 07:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791901333; x=1792506133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UHzNYhfTkuiEiaeWuVbuEEcCD2WWaabl8EE1N1mmAM4=;
        b=dQD+XoPPiQb6N/CB9d3l1bop76CrQkuhMrx1EqsD+L6EJhkjNKRimbbTAvk103bXKq
         YYAlkEUDqaLV2NHjH3I4OVHZvNYrm3EwL9EkQHo8byYfepamBpLmHXRpIwr8ex5J8Ta1
         5faMYjf4afkxqnAM7xyYsfANuDaAOXs72wfx6GiEMc8gUSS4u94x+dRTFwRC6sBowb1V
         W3DVmDEk5SPT/JnzG1EkVgUsfVlveD9rUOaV6pgKY0za7PWfVt3M+u7AuVq+NX2QacRe
         5CZwFYk1SMWaUrTGMv4r3x298OV1ltFthsZj+xfQPSjGzR/Hj7EGI99sqhKTINAMFEh7
         QivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901333; x=1792506133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UHzNYhfTkuiEiaeWuVbuEEcCD2WWaabl8EE1N1mmAM4=;
        b=STA9FzCec1ZeX7yQwbD6wlq8AC0S57AECT91gmSEC4ITnCFd//ISN5yT8WrNwvQNee
         xmI3UrLO2hj17WPpACOhbwNUOhScj4C5sZ3nAhSdYKxlluqQRKzkJAOC3UqfosQFdt1e
         lPMfqxOt2SAU7Pkgm1cL1rKsWXk0dooNSrDpdxC04X4T9SmXvkL3BAXPK1W+OmNPmrBL
         ysnb3FCVSu/v3ir11YY+00vQ6NnJNz+b2zJV3c7kIogL7hk8GoGP7LORDRhf5pvCKb8y
         hyy1qFhGqWfkFQbgpMVKB7PYF9AQVFDW+23QDux1dHccalSCgEHy899ZfATtB650PFel
         fLoQ==
X-Gm-Message-State: AFq9FYJsQRJvnAFZxiyQ01ZcGwHlsRNYU1PsbXgsJym4fd6NiFTwerIh
	i/XkJIObXC5YWONx7LsLkSBGQ/trQEYWr5f6J0c4J84ai7NLVPNl3xIWAycpYg==
X-Gm-Gg: AYBFou3FyjrPO1p1Qt9rueV/ZHzDKiFEpx7N2GhsVmHgJ8j9kfVTO66G0ycswUATWYn
	j4eW91MEQ2ZMWLyLh4OsH0zDbSC50Zxg5cFCiue5xihwTeglNeuWV3NmUwnU74Zhzzgx8U4KSJ4
	bdd7zA97nez49o0iZ42Rv0Q5gWDHDAgkBOyfqlEfmr4x2KzpIOWGTHE1PeOkLau3LLqBV5IUOOz
	nST5FnzMrZcRM7JMZ+YtkGYGu1yRTaIaakqJ3MTz17Muc4qKwDNTM1VzkN8BExAOlwar1VVGW+Y
	vrICo3bgN55CBIOUhwbZiNvyclI3Y2425i0ScqZHCy3OUucz2DY/ysUtDM/Xjsuy7wXP2iRdAdl
	oONHAviK56ur+OVO23D8D62NdOZ/ods47hHllf8FuqWO7mW3ydEPmuatlyCGPTwMQo96Ffy6Bp8
	HHNRI2OPf8G2Msj6r+bV8CbzSjzxqWT7eWAgP80PkpV3TohZPaPeHMS1qbC9RcnukJanGvySjsI
	KbcXWOGsHgGsFLucoJNT8MZdWauE1lCjFG1Ovl+2+upku+keqMCuY0L8ZxrrU7gkQ==
X-Received: by 2002:a05:6122:1d46:b0:5ce:b65d:22b4 with SMTP id 71dfb90a1353d-5e91f25d4c9mr3457047e0c.3.1791901332608;
        Tue, 13 Oct 2026 07:22:12 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e94896af36sm4180330e0c.11.2026.10.13.07.22.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:22:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: Fix the LE Read Connection Interval response layout
Date: Tue, 13 Oct 2026 10:22:02 -0400
Message-ID: <20261013142202.544985-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The response to HCI_OP_LE_READ_CONN_INTERVAL carries a
Minimum_Supported_Connection_Interval octet between the status and
Num_Groups, which was missing from the structure. Without it the minimum
interval was read as the number of groups, and every group after it
from one octet off.

Take the minimum interval used to clamp the default rate parameters from
that field rather than the smallest group minimum, as the number of
groups can be zero, which left it unset.

Fixes: 2f8784cfe8a9 ("Bluetooth: Add support for Shorter Connection Interval (SCI) feature")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_event.c   | 16 ++++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1641d879dbda..9dc714d9145e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2527,6 +2527,7 @@ struct hci_le_conn_interval_group {
 
 struct hci_rp_le_read_conn_interval {
 	__u8	status;
+	__u8	min;
 	__u8	num_grps;
 	struct hci_le_conn_interval_group grps[];
 } __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c055d16cfb8e..91a0157ff435 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1269,8 +1269,6 @@ static u8 hci_cc_le_read_conn_interval(struct hci_dev *hdev, void *data,
 				       struct sk_buff *skb)
 {
 	struct hci_rp_le_read_conn_interval *rp = data;
-	u16 min_interval = 0;
-	int i;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
@@ -1283,17 +1281,11 @@ static u8 hci_cc_le_read_conn_interval(struct hci_dev *hdev, void *data,
 		return HCI_ERROR_UNSPECIFIED;
 	}
 
-	/* Store the smallest minimum supported connection interval reported by
-	 * the controller so the default rate parameters can be clamped to it.
+	/* Store the minimum supported connection interval so the default rate
+	 * parameters can be clamped to it. It is reported on its own rather
+	 * than derived from the groups, as there may be none.
 	 */
-	for (i = 0; i < rp->num_grps; i++) {
-		u16 min = le16_to_cpu(rp->grps[i].min);
-
-		if (!min_interval || min < min_interval)
-			min_interval = min;
-	}
-
-	hdev->le_min_rate_interval = min_interval;
+	hdev->le_min_rate_interval = rp->min;
 
 	return rp->status;
 }
-- 
2.56.0

