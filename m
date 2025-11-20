Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489D36E9B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658325; cv=none; b=ulGXMQeHueOk2sivqe6lYiS+L5M1L54YO+i4/mrZnwtEOWM904dBSYiil6W8xqBu7tCqQjQsInwmT/gEWiK4milfUw6u3JDOw/kzeHorA1I8hfrhJC03Pqc/5yIq1WAsVDruj9h7Par7vvF+47tyAQFiS8QnBbPQUTpnGKMK8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658325; c=relaxed/simple;
	bh=MzMYZuRf7e3I/lN8rut0kGmp7FJthYo9q52MMR93Wms=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Xo0xElrGv8zBVw6HuN28SPgti1o5bApKn2TJRAcs8TEudlSusz07uMt4y+O43MmH/+yL3zggoo+zTaXSk6hQJd2DB1MCXW33lZ4uOzkLf2xD9u+vLgnaTs6Jd37uSaNCXSs1aE0Q3q4YUWVVD+Kt9a3FLS8z0XXYd92YDElulaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLOtB1hQ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLOtB1hQ"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93c6628c266so69977241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763658320; x=1764263120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPhZrv6lnrdsREdP3aEGP30G4E/QjtIOfFu2pFZ+Zsw=;
        b=JLOtB1hQY4u5+T6QYPF6rTkipq4w7q/2LTTMfv3F+DPZfFQcXrHogP9lezsriCdejC
         IO4JReR/oKiukJqNOJXcBN7ztxAiAwsm6/YplbaGb3CBW1yIV9JfnK0KyGCCvqJp2mXj
         mRvhCEUH9VUUiZFqYn4bejm2zBCNWAHlTrTbG7iDcWb9sKtFYN/A24ngItXLh71Mkd9g
         ogE7ZkvLridb14OcqcGZ2JWZExCEwBxVDo771OheRMp5UZv+M3IdXRlAjEQMhaAZB3e8
         gZOE4fc2Cl0d+dki+mOoEYex4Va212QNakTO1Ji+TaT5iQegqLHx4iBY20R8eTinM6C3
         jF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763658320; x=1764263120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPhZrv6lnrdsREdP3aEGP30G4E/QjtIOfFu2pFZ+Zsw=;
        b=O4ejrgqzO1/TkJdepo4egXWUNUJlEir1HEeohDhoVFdlvA8WIZBCSTot+IXQHpEDEe
         92z7NaJw/ha5uUzGxmJ4QuEOj2DplNKJNhF4CzCP5CMnTRFJEHlEi1CDxbB/+s9LE76n
         1t71uHSgjLGjkeScsdch6pSGC/n7LlC6jFhyCNdxddN1NxxS5X3Xm/zpQGuv1CNWI8mK
         eAC4GWtFyoP2grCIoVcYvLaAHRTvCNrA3ceqiFLmsRvEsRShuAxSwuZ61RMMRwHZ1VD4
         zPaDJA2wpMRcFbSokL+0VA/36yynBNEVUXlrtk9uVc9OdeLs4BOYO2rsOhf4cDWo8EBy
         d76Q==
X-Gm-Message-State: AOJu0Yzl7n8KFg0Xbcb3iVwELTCit1IZgSruYg+BzHlxfkvqjDLmUFBQ
	U+fvMMSs9xSxJad2/lN6wMaXtZQNTSOpD/l6S+N2lebk0Q6ldp6fGOkTmP3DBw==
X-Gm-Gg: ASbGnctqlu+Zrc3EEkiVHIqOxrO0PLLeL/eM7Ji/xo8Oru4VTXD4TPHUW9rlyY5mQr4
	sBDHh0WfOWOGn9AFCNxCNbAuJEH3wTGgLhzL98qk+v6jX84pT47ElsrLytT7VqRXCpCeu2TPHwU
	uU7r7fO5YYjmgfZvoso6S1Ws4DI1AKp6VQa7LIBE9ivtwfNQNuBpwzKEoWqsSvmYKHBDWv1eXc+
	3nL0QIeTWO+qTUI7xnauKnY15aFFS0cVqh6M3v62juCs73hVXOTSn33eQRNrbK6ktMaTpmSaWbm
	Ccw6IYP0kpzUGoQWXcOXWuIi2avNPNCz4pxuYd8NBPjYZd/qFUih2QYOfJiCXojCS/VeknOJZuV
	q1j4OURSEQ4MxycmvwZizFrawn/PQQbHNTs+EqWomn9Y6X/8Sb/Gz+Uvq0POjtUQtr4X1+HgWoh
	7P923A63uwucbjghibZ3/5NczQ
X-Google-Smtp-Source: AGHT+IF9ArAAoJxbzjbi8zOg6VA8+IHSWZf3zD5LHTb0rYV/lq5WXsKbM0543jwun//IfImoe40MSQ==
X-Received: by 2002:a05:6122:311b:b0:556:745f:6a06 with SMTP id 71dfb90a1353d-55b8b78fb12mr63137e0c.10.1763658318286;
        Thu, 20 Nov 2025 09:05:18 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7763dfsm1193093e0c.13.2025.11.20.09.05.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 09:05:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: SMP: Fix not generating mackey and ltk when repairing
Date: Thu, 20 Nov 2025 12:05:08 -0500
Message-ID: <20251120170508.30581-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The change eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
introduced a goto that bypasses the creation of temporary mackey and ltk
which are later used by the likes of DHKey Check step.

Later ffee202a78c2 ("Bluetooth: Always request for user confirmation for
Just Works (LE SC)") which means confirm_hint is always set in case
JUST_WORKS so the branch checking for an existing LTK becomes pointless
as confirm_hint will always be set, so this just merge both cases of
malicious or legitimate devices to be confirmed before continuing with the
pairing procedure.

Link: https://github.com/bluez/bluez/issues/1622
Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 45512b2ba951..b9196cefe68a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2136,7 +2136,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	u8 *pkax, *pkbx, *na, *nb, confirm_hint;
-	u32 passkey;
+	u32 passkey = 0;
 	int err;
 
 	bt_dev_dbg(hcon->hdev, "conn %p", conn);
@@ -2188,24 +2188,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
-
-		/* Only Just-Works pairing requires extra checks */
-		if (smp->method != JUST_WORKS)
-			goto mackey_and_ltk;
-
-		/* If there already exists long term key in local host, leave
-		 * the decision to user space since the remote device could
-		 * be legitimate or malicious.
-		 */
-		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-				 hcon->role)) {
-			/* Set passkey to 0. The value can be any number since
-			 * it'll be ignored anyway.
-			 */
-			passkey = 0;
-			confirm_hint = 1;
-			goto confirm;
-		}
 	}
 
 mackey_and_ltk:
@@ -2226,11 +2208,12 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (err)
 		return SMP_UNSPECIFIED;
 
-	confirm_hint = 0;
-
-confirm:
-	if (smp->method == JUST_WORKS)
-		confirm_hint = 1;
+	/* Always require user confirmation for Just-Works pairing to prevent
+	 * impersonation attacks, or in case of a legitimate device that is
+	 * repairing use the confirmation to as acknowledgment to proceed with
+	 * the creation of new keys.
+	 */
+	confirm_hint = smp->method == JUST_WORKS ? 1 : 0;
 
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
 					hcon->dst_type, passkey, confirm_hint);
-- 
2.51.1

