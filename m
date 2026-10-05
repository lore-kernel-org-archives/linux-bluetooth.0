Received: from mail-vs2-f34.google.com (mail-vs2-f34.google.com [74.125.227.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53593ABD95
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233076; cv=none; b=Pygn3bPlLFe+xSnZS9sCSaHH2BVfXxjZZnLxcKRCiUv2HjPDLGud+VOnaYxrOs5du3PVwJnUS9NPF+huBv1mbyWosTKtq4iXW7/XgSdQ47atS1m99pHaycvqdQNyl8GlzNZ4J8s52xO7hrnBotzGqsYjiUkNRrGLN30gMCX84WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233076; c=relaxed/simple;
	bh=A9Fs5AdqBcb26lKcBnk0LX8wPrpvfCaXJLjQDzz3M34=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gog2z7DtXqsMZta+vPoN2KX/XO6cGekfuW1kIJh9qMk20Z2EPNbaZUgz4DBgeyhnRbaTBBT2M77ZJHjCib8Hfz8oUCWMzXReT1sKP8HrQ+J2kM78QOx9Gogobs2nL6yfY915jMPa/aTmyKfzcOK84UnNFYTTikasWzdUGUgJ8JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1Tah/eW; arc=none smtp.client-ip=74.125.227.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1Tah/eW"
Received: by mail-vs2-f34.google.com with SMTP id 71dfb90a1353d-5e372be3cb5so341526e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 13:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791233073; x=1791837873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4sJHNxjiuA+irb0F/9g8MQWDNoCtIr1gYzlZjsXOV/I=;
        b=Z1Tah/eWRMujgShjApG/4TucNS1IEdDNi8TFJqA8O7MVIuW1+gLQAXNX3JNSThsm0w
         2467v5CtLavjWYY3rkDGLwbQ0r3TGoki+FTfAI1o0nqeHkHCmZLE9ZBHpZDIGLKjbFeW
         GxEFzpSkXlffMtS6xXhO2T/tAZdOPZIK90jY9lG5Uqfy5rgw5Qo+1uqKMUiW4ihTIFuk
         BoCkmLHozMrc04RwU6IitTzYU0lQxhAf2FFylHPkbCrMWXiXLRAoFMdv0s+Dbd0S9eK7
         ItVh/01JzwCoDuLkx3K35aumbs0UenGuZQliRCTIepqDna3cSlcU5mJZQIzP/2enD2HW
         AqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791233073; x=1791837873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4sJHNxjiuA+irb0F/9g8MQWDNoCtIr1gYzlZjsXOV/I=;
        b=n+fmuIXOtDSNshZHhP+9ZL36QcTlOSEKYw4Bxhe1QKAG6/8YBpMBgCjgq5U33r7/fK
         oSE4Zq8atclAOG/o+WmjIBoJShWx9s/9sRCJL3C0ObNOTwxkJncl1Nw/rqSiEFn6JmAX
         3omJ+L8ch1OBHoniZ2B+GQ5ddulXDRp9wHpyYV7w+nP7GR4h2lvRvpeQsmIc+gIVXn/2
         x1fu+HtPNn+xBYsMw+Js42QxtYEMeQ2MgXW9fHJduuGXIJ5+oJ2bZE2KJjL6BDo079Qk
         95WfSK/lq358YOZ+9N1dJQgNBfs4Ii0QMaO6MIwBU50hKlEOePaKzZyB201Q53+Yb7MP
         N4yg==
X-Gm-Message-State: AFq9FYJaeJwF+ivk/wQTbmMcCtR7O8b+1RIyRM4QGTHT0hrGZEc973qs
	cHRoqhqB3c9i4x1b+Zltlca3AZAgtDguvrq97z14+lPYENJ5be0meEDa3s+kyWpw
X-Gm-Gg: AYBFou03ufkExcDIXxtWxt3b5s0dHskPKd/ao1Hxt32JFQooKDlWwl13k36YlS7Oy2i
	6ZJqXdKlYtW/9L8k9eKbtCMPjDrge1oGKzzWz7vdtaS6TVqPqQ9uyeTkBVTP/sKbDqjLgAkFgbi
	w+HmYVoP6gHEOPxNAprx9URVZq8WRax+GhBV9eBXIXZqQAgZ75N8ZX5zbsigFE4w2JX3bqFANH1
	xVjHfGCyuVHZJ2p8SY5w0qowApze5XPbNJoeSuW0+I1jx0Cd5lsGMY2shWewjJJxfimXRzyZI3U
	b3fALISt+HLY7ryIlqhLi2mLsJoWkkGJ/1Bc3m8Hl9PUZL5IGXrhYG9ghtAH9n7KuxyCOw4IKGQ
	EhW+QNxETxoMysqVFrCKITIprmViknPX3Aiu7euiq15IcjJgtfXWwaTfnjClMH86i0AiXMZL2if
	WEBgbe8YxZULr4qQGEGA2OWPcMpwr051GY8S6hXX/9XgrcrHaJXq6AIAgJurK1zUxzFEH8D3KPZ
	NLxEWo6DVKIXvPlImNIQlCgwFptumj7sp7ueBnTT9P0BdVmmEqJRtE+lnKGIrkq
X-Received: by 2002:a05:6122:d1d:b0:5c9:a60b:e5c9 with SMTP id 71dfb90a1353d-5dab0dbf757mr3702179e0c.12.1791233073102;
        Mon, 05 Oct 2026 13:44:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54ffb92a5sm531789e0c.18.2026.10.05.13.44.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 13:44:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
Date: Mon,  5 Oct 2026 16:44:20 -0400
Message-ID: <20261005204420.3684587-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005204420.3684587-1-luiz.dentz@gmail.com>
References: <20261005204420.3684587-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If queueing the command fails the instance is never removed, despite it
having already been added or modified by hci_add_adv_instance, so remove
it as it is done by add_ext_adv_params_complete on failure, signaling
it has been removed if it was previously added.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 93872a5fc39c..ce091bf84642 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9361,14 +9361,15 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 				       data, data_len);
 		if (!cmd) {
 			err = -ENOMEM;
-			hci_remove_adv_instance(hdev, cp->instance);
-			goto unlock;
+			goto remove;
 		}
 
 		err = hci_cmd_sync_queue(hdev, add_ext_adv_params_sync, cmd,
 					 add_ext_adv_params_complete);
-		if (err < 0)
+		if (err < 0) {
 			mgmt_pending_free(cmd);
+			goto remove;
+		}
 	} else {
 		rp.instance = cp->instance;
 		rp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
@@ -9379,6 +9380,18 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 	}
 
+	goto unlock;
+
+remove:
+	/* The instance may have been modified already so remove it, like it
+	 * is done in add_ext_adv_params_complete, signaling it has been
+	 * removed if it was previously added.
+	 */
+	if (!adv->pending)
+		mgmt_advertising_removed(sk, hdev, cp->instance);
+
+	hci_remove_adv_instance(hdev, cp->instance);
+
 unlock:
 	hci_dev_unlock(hdev);
 
-- 
2.55.0

