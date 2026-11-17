Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946846;
	b=WkUuFsPU8JBvLfvvgZS9z+l6Ek2HkCcfJsiMMP7hN5D8HHSx4kTMBRDqlzWSiE2b0e3Z
	 fP6rPgYtm8t5QwBzPJH8TNYU7aZETHAgWPw8awMz3pxZ8mSZ5dnybq/gWknj0w/2isXux
	 Pi+M5Li9ogN7yEjD61aQwMFFkdYXCAaN6ewGRjDD5qkNXiQzObxCnJJVcOhZ0vI90KT+k
	 Y1FZ//TurEwNkkd4wcSd4t5yeLlKKxIUuFzZmDlf/FVzWbGV7ucfU/KeWFZ/CCkeUc5uq
	 DHY8QnND0THIdwu5OCEcvG15ZfTPXS/usGitkr/B9K1lQHDl+YMD7wxF25MkrcOvb7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=raWP24iKlmm+Q3WPgp+dPhfHLUGie6F1kwUNYBbGZAE=;
	b=L7pdazyLXoro9Ne2EXfE+vDVVpf0NgkS6bFMecDEsmQltPT1ViZMGA6uQMDTLsUJnwL1
	 Y0lmLzqVodjzRyQpdZlIr/KsNssW1zytgTVb+tffQf7qVpnFEJ4Ael+m0wDYvK3nwVUDj
	 AhiEj5HwPYvVR57Wd9Q8EFeZBHRp/hFwXGmTM9drF5YHSpvCd8L1Yhd+ss4XmBteiAEP1
	 V9q6UUMQ1e7Ogp4MTJjue7PcPVE6iOro5SKP5fQwp8dEDlMrL1xnMYy0TostFjIEsaGy6
	 4Y/L3XPiaUrpfLWg5RKi7hY7NAQ8BvJi87fj+t11eS45fTYQrUUOsnKA3rtT7wHRQzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tQCMHAzH;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B6606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 20:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A1B6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tQCMHAzH
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99bf7b97f12so85223241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 12:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794946845; x=1795551645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=raWP24iKlmm+Q3WPgp+dPhfHLUGie6F1kwUNYBbGZAE=;
        b=tQCMHAzHeD/qvua8fzQtEoa6uUnLVCv3iAhyR0NZvmjVn8Iq/FC3ulF07PzcRMuaCd
         6xwK0OyYwNNv6HV4ZJQZqEKlEspj/akJ1HSdBB1PftWvSIxL0ZV5JoBUMe3PG516Zk/d
         r2UCKBsfkJT1tgsMCoPHG4EHFfQwT6TGtEURHwhc2YVcCSgTuHKw+60NBNGqaWgVVQG+
         4BQv2y9Qyv0KMumwwDV0RNUlhfH5bBkygRCqGvo0xtLqwYR+DvlCQ4N0TB0yBx9y77+D
         iKFJvGW1Sgsbfj+StW/Wdl6QRt7hyWWsiQ6wA8VThRF5cMGi6yGaQ8C+2SKuzv5hPQXl
         IZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794946845; x=1795551645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=raWP24iKlmm+Q3WPgp+dPhfHLUGie6F1kwUNYBbGZAE=;
        b=I4g5gd1sl/p7jMPU6dhPeOpftfjSKhbWlFWBy+7scr1iJxRhA1LFDNZCDP9FrtxgIP
         rgrNd8VNZ0Q4IY+IMERLZMICz3s1VgLiqr4NF30fbgXWHLxqH4Yi4xLo55ZlKGQ50e3X
         ZVvHu1+McswdJyux13WVreKLWrZ7lq9ZQur7CyDVdqEooRtmULlK14O9oMS+ayVN7yGK
         GCuUpaJLqGwGY1pUwr5jR89dq8cD8WsbxHRI6f4kD6KXN48IY30p9KDQvskV4vMGhnZN
         i9G5Rwma8xgJATtbg2pwK32wbfNKxfBzSal3vmFAOnA81QXSScysp8f8Gm08s0234fav
         iahw==
X-Gm-Message-State: APuU4Z88mmIfd3SayzjLaDQQ5siqsIz+kNkMOSS9rroyxyE5P6iAfuT4
	aINVrTKLqQEDPQ67zJLjSVF+o3scC55drfXYhVfStzE8vM5i5lha40nyj9EyBw==
X-Gm-Gg: AYBFou0gUW1ABHrUSfuzO7F2KB10Jg/NeE3EZo+0bHP0iTRzwuyXLPhzxEh/hsAuHRW
	/qCmZ1twd8y7tXPRSv3AwiJzK+0/+ZWwNIRncZ95nAqneN2cYAgMSkGSC8WwOXVXGvnuCJDVMzz
	ZFwX/0EvK64nGMDnoV594Mx6gxyWcgpw0tZ482RXjzXGSAJaHZYhu0QirRHWSupVTIz7LffNmUL
	Fmo1im1X5815BTjfL4N02BHRKP8qcotGVWwSMftO4CHFw3zXXuXyMphM5+O4pt26GFwecTPfT2B
	9oR0xXcC/Qpto8giAMk6fLgxdU5hklLOFGfIvZwg9B1dazpO44/x9qkMwVZjTyBlxFFVSJx8Gqm
	fnM+LTy0nvcGO6qahduDTenkv+PNPGpDZvYGUJVsiHDEFUdph/DhHgEN9sFVsFmqrwHlONAgx7s
	2zuanWVOXEhGKgg/hICkZXJTsjxlb5SQjjj+yKqbxE1woHDHRv/qLE3xii7/zpWSWe/SRskzQZr
	Y6ym65Rxw2lSS5LmUYW2BD8+IIKvr78qC5+3xRkUVRQ15qlhGrNf4tIo+JCymWf+OwmuPgg2A5p
	9qTNjpdcKJfMChIwq5VeMDkHSi0tKrAQwaWskMnLloDHfub9LaYWqyXbNcdzfM95cieT7MwM3re
	sTJljNncKeq9ywkBBkDfQxXPgSyVVWI/02HphrzTCZDztgq0EJTDsbuhMThjiDWwtxWAfnocXnk
	LwMJAh
X-Received: by 2002:a05:6102:688d:b0:7c3:874d:60bb with SMTP id ada2fe7eead31-7d6ba38c4b2mr33134137.5.1794946844946;
        Tue, 17 Nov 2026 12:20:44 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b935ddf3sm303166137.11.2026.11.17.12.20.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:20:44 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 12/17] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
Date: Tue, 17 Nov 2026 15:20:27 -0500
Message-ID: <20261117202032.3848411-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117202032.3848411-1-luiz.dentz@gmail.com>
References: <20261117202032.3848411-1-luiz.dentz@gmail.com>
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
index fbabe3dd1555..5a0f1e197e03 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10363,19 +10363,27 @@ bool mgmt_powering_down(struct hci_dev *hdev)
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

