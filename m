Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B22374186
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354593; cv=none; b=h001DDyOTc1PWsBwP19IK7f0h1m3wj72KA/MGn7qICSaNMeaxNIiIICPWUaqF1AETiKiRu2LmSz/ikrEtxfXHYtF5f/nZGIb24XSQJGZdj5KMxkR2US/RI74ETkt10vaEgmNEFN5ZGDPxOAHF5x9dqF6QeDdJIK6DaMDofsBUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354593; c=relaxed/simple;
	bh=WWQddlmwztGzP1zQFKH1AYSd45NHXl40J8CybfMy9y0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DvZTVo5aZIzae428KrAdY2t2CEpPORB/vOEecxfu+bSzT+2yuAkHWW+/gn4kZT1/mDSJHAwDQ26SECcSpfp1gsH2wfaPdnQ1wXdn20ju9VHPXa8RIlJ/v3kJHG2AFf99Mf7s26mX7UiejrcujwG9Kb6vJn/ErWjSZnd6mbbEvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+K8rIiX; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+K8rIiX"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56706fd623fso2285949e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 10:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771354591; x=1771959391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+FjOwpw8XH3ydLRAbU6tRnR2Qqjn9n6TMxvqJurJlps=;
        b=i+K8rIiXmQ0oyYBUq7FFwcshQiu0tL61gdMhRuM4suCF0GltI1i/lom3DqDD8uI3bh
         fYY0K2/UGLe3RR3x5R/8gC0so0hhdXyK8lxZFFqH5WiHOEJUdoDx3SXiHXOajEkPmR2q
         zKzUG5XkY3fjxYazZYUGDbTsBMiumyRw3Eya5BtOqI/21EQ6NB0OGgLubPy5JW5xR0DI
         0XM+TP34zTKO/jc27vLb4tW6EHCIbWVtuyupmt2fysy4+PCTrTN9Zld7gCfT9wKo/5Oi
         PziRBqlZZuA9ddaV9essBnhwO8oHarX3Bp5pa4PHS86EjLFiunJQK3maO4x/7LewDCS6
         i9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771354591; x=1771959391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FjOwpw8XH3ydLRAbU6tRnR2Qqjn9n6TMxvqJurJlps=;
        b=wSY/nujP59QPUVOWA7vYpQWG6EkHFSI46mB56QL88mjUghKZ4lNzk6yc5GGoZCiwiU
         a4zVom+OQ5Qs76bCs7ku89Xa46K6Ufp33+UhkZI43OrBd/Y0x6ynCo+eAbV2hPnFNoQn
         oDNKTr/TNsnXmyHCWFm7Y7/GWIYP/k3x/Zqn9X5zge84xU1ilCm8Ac9EvMzp3SWjfTux
         vw7MrZEzq5vOsw+eXLPtw3ptjCD/i0gsYfGhDgrJOASjVFPpWeM9YveHgkzU6iW0WL16
         k5IDe0CcLs8S/KkroOtZSzz1w2THm5fGI1ftuWVVyMJf6ByFbzEf8Txtp5DwK6y+AKDA
         Rz8g==
X-Gm-Message-State: AOJu0YxKRclUvhdWzlVPuk20ocRI0eGPp4RjVQGBaVZEU2M4ZCZK3qYy
	oPljHMTHf+eZsHJ9HFyAAyt3iFCqPzmnjF4pkXNgKgR48jlluJXNKhhSG8ALkiKD
X-Gm-Gg: AZuq6aIVqJX2vHc9L84goQ/pyEaZoGhteh2dov9GBTi78AjqW+1EqpV1jtmEdcdoLxF
	wxNVPJJSHh5s5A/uUP2uUUJg6D7tCob5iyOeBSlPOT4+pESsAl6ex92/VDrAj2+GokfhkS6q1xO
	3UY97wE6tskn/x9331vC3U+Xbm5cALQrMymB1WJh1MBqw7DwztAkBvIF8M0+VAVwQHDQidaW2zM
	vEpuama5660Uisb7wnIgZ7vu6FFYZH1LdOE9/okGyp1nWgyNJTZ8HlQUMH6vzjuzFuaLNN8MPCE
	BHdhNEewhcl0iD5Fp62rr0Eq09fNuMfZbATLGBDxzzLaRV3RwCkybFqd6qV94AQzQQRBx5dMtQl
	HqxCf7TGtLP9EfRMuCf/VGGooYFCDf3b/UOLdRjKkomJQaLpHJz6xCemgTAUswXraxmwEJJlJce
	XaZpPynFtnW2GN2R+cZN/6ArmQVinIeRCUx33JPsZFbicaWgLJ0G+/0P7FDrJSsagzX8dfnwba2
	LOGtOvpHgKN+mdHjw==
X-Received: by 2002:a05:6122:2088:b0:563:6767:217f with SMTP id 71dfb90a1353d-56889b449b9mr4089981e0c.1.1771354590774;
        Tue, 17 Feb 2026 10:56:30 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674bff1078sm10420258e0c.7.2026.02.17.10.56.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:56:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
Date: Tue, 17 Feb 2026 13:56:20 -0500
Message-ID: <20260217185620.2461151-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In order for L2CAP_ECRED_CONN_REQ the given MTU shall be checked
against the suggested MTU of the listening socket as that is required
by the likes of PTS L2CAP/ECFC/BV-27-C test which expects
L2CAP_CR_LE_UNACCEPT_PARAMS if the MTU is lowers than socket omtu.

Link: https://github.com/bluez/bluez/issues/1895
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 390d25909104..c904e2f30637 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5116,6 +5116,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto unlock;
 	}
 
+	/* Check if the listening channel has set an output MTU then the
+	 * requested MTU shall be less than or equal to that value.
+	 */
+	if (pchan->omtu && mtu < pchan->omtu) {
+		result = L2CAP_CR_LE_UNACCEPT_PARAMS;
+		goto unlock;
+	}
+
 	result = L2CAP_CR_LE_SUCCESS;
 
 	for (i = 0; i < num_scid; i++) {
-- 
2.52.0

