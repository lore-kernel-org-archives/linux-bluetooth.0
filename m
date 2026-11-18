Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029094;
	b=27YNq747e+6ZwD2aijRqnPT4quRA1zRAOP+H1KVfTBnnbix/ecI4THWihHO0PSkeVbKt
	 0qTLrPFcWoxKG2fHIpEcXi3bL6sMVtwugS3wTaqOwbANweHbgPa4GaUP8IhuJWkaW8UlK
	 3/RgPkMqjydI8dODiOR5MCCxle6+2RQJ+l+vRskLz1eMIlL8t0vl7yebtwVc8E8MNF27k
	 FlDTC37SPB6fALjbzQn8kpbUq5OAcFnMJ37bO1uYS+/3XI6/XyYPsEYMh334DsNpB3ZSZ
	 yIXWgq/x4mja8lC41885eAiMR8Y8kLnRgPMxyD7BkBeOuqoZaRNsGAh3XVee9lSa+5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kVz0+f5exJcDCVcjhcH32bJTDK8I2i6cX7t4EPuLb70=;
	b=Q+ahx9LqtzcBX7sVzdaIGI5UJYBFUk2or9n8w3NWLzBUYaa4yUJNjY+i/Dhy3gtSccb8
	 VzvS8iFq9nWvyID5iyIrNOoWOTyRGjf1fyYgTzNgFa+f3G0l7heodAvUGhIJrUYW3S3eJ
	 f41f29wyhvWe7mxre2Cvw1ofWR0f2aZ4+Zsc23QhyDNJI3OTm9Sv8zp7wYpq/4XGm9TCA
	 CRwYybphH2SvyT8VGDvDJRpgbiryo3awNbEeNM5R3jMNyBZlE8ABFtg8EjiBBu2pvXCVc
	 R992htwnqjsd0ChDPsoK0MsczV8CbiB7VG2E0tPkL4yS46opSXNfxktfcW5CVnMRrfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B6D5rF0c;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E3606A325
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF7E3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B6D5rF0c
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso509268e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029093; x=1795633893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kVz0+f5exJcDCVcjhcH32bJTDK8I2i6cX7t4EPuLb70=;
        b=B6D5rF0cWe2OPg3cCboHB44t/s0IGckTl4Jb02zAon9Y6kAcLjAhjfAyjxOH8HAfxp
         gqnft9h7+VeAt1HgXFD7Oc3A9lOsKf8mpz9MPdr0UaZM6iT4j7WKX8F2NR4Q1d7EOJ7R
         nPHyBovOpn5D7AD/p69gjXBDGanX2ALVgE2N4gvlOoVnCgHCN2FCdfjZBYbdaS7ci9Q0
         xhgLRyNs93WpUHG/b7uBvTdM2FYDxDR8nEZSqxEh4pxkmYSQrylo/lvGBMIlGgICJRzn
         ZpBmqgYnn+jH7Y0hP0KY2AQxcaxmDEuG/WsoIakKlYNCU7CZ56JntD7glGBe3mEejkN9
         gU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029093; x=1795633893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kVz0+f5exJcDCVcjhcH32bJTDK8I2i6cX7t4EPuLb70=;
        b=pbqcvqdDGCXiDiYsTr9x89kgE5+GC0MIooEaNjpTcTn4uk+m2/lO0+B+UsJA/LOa4l
         r5Jfl/BxzIN2DxbmFaO2qWW+mouRCVgMFMcWC+tV+38aZQIFjXtpZs++ZMZoL7YcodMp
         nFevaMqXgVu2jkKkQi2mfeIaHxTAaNp3EoJrtrcKAXHZyFgRsQt8K7eCV+HI0ZuWAndU
         x951/2tICKSJJkPW/0+rHXoeYyUHzcqL1E4L+ihR6CJ/uE4j8WQJMiVzl9HIn3/N9dGq
         AdrVgF7Dc4E4i6j2Xcmk/zJMFVUGfeVS3Gnt2PgEc3t/qnJS/tOGeKtm7skymqlJLojY
         p5BA==
X-Gm-Message-State: APuU4Z+lr6ElpI2yAZlLjrGVeTIRyY4Fq7cxGKmv0QApRzd9xzl8+1fO
	xUmjdo4fp48T6AyT7hhx1PbJBTnbNfZG4oRMA2utH8RLKfbfHPpnTLLtElORcIJG
X-Gm-Gg: AYBFou0gPQGDEOxXwageTHzfh8T7egxwBdErB+lONVRpMPGbpa6oDM44oEKyTklCye1
	/FmqRf0ZwwXVpUv4epqHJvn2TfaXNBHW1JmqIqjQEC120pNnvKDNpd4GHOpYGfv6F3sZ+BkQRTN
	c64l3pglkyIFLfDWcj3Jw2CFqi8yFSDIg3I3aYccDqB+8MUj9vEhGI8Vgitk2/Jf02xD4sxjb1x
	rvc+vr3MaIE+kQKl7IGHwUB7G6tz7Da4xmfO2vvFvmN9P0R+OBnZ162YoY2/FkI9U5OPHohycf+
	TxO7+UqM6yFQaJZ0O9Qe8Oaqm95w9Joy4vc4h/LlzRtUkUnDiLpJ4XU4X6ZnT2KlFk0GgoGLZIn
	bDIe2ZsnGSJqRr8lwL3lxYIiF7GQGfrTOFZQ1ybt2ysKHSPsRaHlJzmkz1Rt/oi+56TZdT6L1Uj
	AfLM64vr3MI9REjn+X2pSMntxoYTJDLC22vVEeYJzLbos9HVMND1ySigNIX1LZf7iI5K1r5szCD
	/FEv1Xgy2iJlYR8k6Sj9mxbOJAt5vybtc/6a2FNbla5d4wOwXVtFY4ly8uFI+NAWqhd+pau//IK
	7ayPf1+m9pT60M9o1FvQYuHyMsQKX18rbIbpW1g000f1BBDyEQLQjgWaVsgPMFvd5CJ25IpJpVL
	1H1kliMuZLSH03MQu7uSyWV5wnTmd8KVUFIU/vG3swRi8NQA/CmETYdSt2hyMeBLjfdQxW/2tUj
	CK+TI=
X-Received: by 2002:a05:6122:513:b0:5ea:e324:7c0c with SMTP id 71dfb90a1353d-5ee6473888fmr1641388e0c.22.1795029092591;
        Wed, 18 Nov 2026 11:11:32 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee64c1801fsm2479672e0c.0.2026.11.18.11.11.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:11:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 12/17] Bluetooth: MGMT: Fix use-after-free in mgmt_powering_down()
Date: Wed, 18 Nov 2026 14:11:13 -0500
Message-ID: <20261118191118.318779-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118191118.318779-1-luiz.dentz@gmail.com>
References: <20261118191118.318779-1-luiz.dentz@gmail.com>
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
index 90517e7593c7..1a75c2d04107 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10405,19 +10405,27 @@ bool mgmt_powering_down(struct hci_dev *hdev)
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

