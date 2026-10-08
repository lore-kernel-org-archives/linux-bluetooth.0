Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384324DD3D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472391; cv=none; b=u3WWUmEDpVTDZk6sk7GdR/ZO3wrJvUC1oMj0bmb00uZWfXCUrjTmjzX3a07HZGN6LbUb07WPlPAt6PidVGRq8+GKcNRak5qBmngcV6WSy1migHs7vMPHIu2uCp4Rm/Mc8pk2ebOjo7WVSUZQi6yPTXsxSs5gmIGTk6HtA7ipvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472391; c=relaxed/simple;
	bh=9eTqsgxOGqcdU6me9AD6/Cn9lxReRKHCBxZ7dqQbKD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXZpR6qJc7+jpeePsSyqPipNOkhBNz2/Lx/Cm3bEA2CBQcIh5/ZeLDyosmCuR38GrfbBobz6Fv3fU/kZ632Iexw/InxfPQdDbkd0MllZ4e+E3JBtNfLZ5/IqvgL5VIdnvm3emvMZwySlNgupPu6I2nKUGOTtUH7CcjDx7d56rzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rTQu/pTO; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTQu/pTO"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35175074dc8so106537eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472382; x=1792077182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgntWyKZ0htXISM21JY9zVA6whoi61UfYRw0k8Qzz7w=;
        b=rTQu/pTOuFKah0vcE33b6BKd7nhcGbVCKpI02b4wAzWbhUixG91CvO9S8xTKGl2z96
         EpfIPOvhFoNHnrM1pphE4HQuNCaLTYY1bCmb9IvpQlvkQAHtptzjENZFTZ6P1RVhmSk7
         3qlAq/HH80cbiwo2vqs5asv70B1D1GZgtjsiHJZ4trGjb15o5SGAn/3CCGdXJyx6P6rn
         1D+e9raqimsa4z76Odeut6TSNSbBUfIMdbouQm675V723pMEYDuWi1MqNi23QWPy3iW5
         iUCfAOu7uaZC85CJIKmw3TJ4tuKeoELWxuX2oPni5M/uFw/4Rvyiy49SUrzPQ73bngqu
         Opuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472382; x=1792077182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgntWyKZ0htXISM21JY9zVA6whoi61UfYRw0k8Qzz7w=;
        b=vDGDDHvDyzbZu6yw2FmWXMoh7I1hkVZOHzEWdq9EgosXzSHp2rb3YGPSg2iBdAcL8O
         O4uJzHPp7NkRarU/2N4cLXb6fJ5YOmc2VJpKs/MWsATFZxIS82b6zeVRTFpwA8g7Mq5h
         8XKO6g0Ensn0uqO5Q/FoFTT/W8frAK7UZY298+Qu7WqnMiS9aZ4s/prTZwL+IUUZuXEj
         KIYr3vUvMmnZ5HrnyCF3rortOQVPO9h2GCawB9HI2AtXwXR8/lLsJxolWWnlq+Klufa/
         U9ZJrxu/hzUmQ8d2b02pWvKzZvpLLPKZmvlj/4wH439yb9Qa/H+9RMtDoxbt7BovJmVM
         PdiQ==
X-Gm-Message-State: AFq9FYLJzpEESmiDMhrvDM5bydSegmP/fZOz29EXmm/tgPRQa36ozaKp
	djQRIVImNH8CE8V5CB/7tGlBR2lPu1cRMmi7eKQ1Ra9yRf0pdwuchF0eyz+1i3TKYws=
X-Gm-Gg: AYBFou2H+sQ+c2cZ2UwjTpajJVG1IC9rd26K4QxLlCUWN3dEpMVqr+ZWzRN3hadsG20
	f+a2UjGlCDk/4IbQlE52sOvsbkMal75R9oZstibXyG8tH97eU0F4BoZErCQE6eniN4juxeYxYsB
	s1n4mwwmtuUVIrn8Iv8m6ML3PxtuogPeTEy7hfq7/Ec1oLVKPMHqGY1cTKxFfS7F4ShKvEmyxJz
	2qa4LUHDgaVr42W4V7FfOzwFbZyWrdSpZW9hYuqNf5Qv0SVa0Jkt3/mtfSitTKSMiiyK6nGyJDo
	B6PnyMDWvEjE+wFsrovH0bckLP+7+rVTVmKgXOSZuF7rdtOEyvy4xcNHV0HWPmExX7pSix8XJDQ
	7fEHaloM1lM7qGm8Sn5ht7opS6CrW8B8W5EDrWpy2Ashm4GjrQsO2Ay7EPcZ0vhEG3tF4ftIJy2
	U/ckF6NTDkc5ZijLzQepUs4Qh4hcPwnmgUzUa18Ion9y6drVxDBzPfTFheyHPTTHaWNPJ+Bw/vo
	bBvXMHkjbGcHrOs0jEXDkGihOtB1J7f3kbR97QJUQ==
X-Received: by 2002:a05:693c:630c:b0:351:d38e:6c0a with SMTP id 5a478bee46e88-351d38e6d5cmr3298564eec.0.1791472381895;
        Thu, 08 Oct 2026 08:13:01 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afd00e0sm18052389eec.23.2026.10.08.08.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:13:01 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v2 5/6] Bluetooth: hci_event: Disconnect an ACL link that completes after its abort
Date: Thu,  8 Oct 2026 11:12:37 -0400
Message-ID: <20261008151238.2138665-6-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008151238.2138665-1-enghitalo@gmail.com>
References: <20261008151238.2138665-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
aborting connections"), aborting an ACL connection in BT_CONNECT sends
Create Connection Cancel and deletes the connection. For an incoming
connection that was accepted, e.g. one that MGMT_OP_DISCONNECT aborts
before it completes, the cancel fails at once as the device was never
paged, and the Connection Complete that follows finds no connection and
is ignored. The link then stays up in the controller with nothing to
disconnect it. The same happens with controllers older than 1.2, where
no cancel is sent at all.

Disconnect an ACL link that completes with no connection to take it,
unless an accept list entry makes it an auto-connection, which is
handled as before.

Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_event.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8f22a4528..b1c107457 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3301,8 +3301,15 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 				goto unlock;
 			}
 		} else {
-			if (ev->link_type != SCO_LINK)
+			if (ev->link_type != SCO_LINK) {
+				/* No connection takes this link, e.g. an
+				 * incoming one aborted after it was accepted
+				 */
+				hci_disconnect_unused(hdev,
+						      __le16_to_cpu(ev->handle),
+						      HCI_ERROR_REMOTE_USER_TERM);
 				goto unlock;
+			}
 
 			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK,
 						       &ev->bdaddr);
-- 
2.55.0

