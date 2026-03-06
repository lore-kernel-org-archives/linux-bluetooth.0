Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E370F36EAA5
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822311; cv=none; b=cCU+SxQIRx2FqE+3zDX5bIIgGQFCxNiyZhtONSVbq7ayD6FqpKepottChiEHfEB2IVuCl1f6crmirDafufyKsqnS1JCL+E/FoNMcCHhtZVXHDP3ytMkAM0XtYrY99TZgKmRRnW7DEYYMCo+nFuC/OyMb6LF5mDkZtmV5UFkoKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822311; c=relaxed/simple;
	bh=mvycBNAyygUBmcrD0SMHcqi75AnwK0ydgpbV+qJdUs8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KM1louwzWF3Q1gdqBLAml7lL4tXAfLgXZBm8CiSdjNXSfqQrbzoGvkUUcF5ZWycNUanGWZY0G83YvlpDXiLVQbvgb2CXrFxfEPhCk8VIWBukSFrPtf29WcxFQOz6gY5pYiomJl2zhah7wKGjj1HP/PvDA/fWPl8RkFfC6HYFq3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkossh0L; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkossh0L"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-94dcf70af41so2160048241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 10:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772822309; x=1773427109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeMBv9JeUjnt5YPIIs1zlxXyKKzmWN8/yfPbnKwn0nM=;
        b=mkossh0LRh8aFcxVm6Nv9ts6Rtf/4b5pvAaNtOaYok3gBLHNimGL2Ihy5aA7UN/rBg
         nRIVStr6uacKHotHXFGtepD8Teqmj9lOtJ8w6DIuiT5yPuyRXQOGu0Kkx27CvAtOg4eC
         bYirfP+74yDQIi0ixBuw4vQXWOkPjnOttoF9CfeO6YxEaks76O+W7CLjXOV1r1Mk4ckh
         kX2IP2d0uMdk0qiG90Pc5CDMeDyDJ0hiPWVQS08EJ9zP7aglGZDBvq2PWvTKKsduw4hm
         oH4n7Fwqhr/E8KnVp3DfsbRWj5xjdsLP4whwjXQMhRqSW0IVv97YFp7CnGtxoyUDcpR4
         JxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772822309; x=1773427109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeMBv9JeUjnt5YPIIs1zlxXyKKzmWN8/yfPbnKwn0nM=;
        b=kRismyo/CeRMTisRuSvWhwAjvuds8gJACqSEwrVvbhNSMmjOekQnK30sCIbK9yt8bu
         JTjNupLLZq4B892Xc2+ozUIkP2pnvNjtaPDzf5RpwvqYM2xLn1k049zrXpbdqXwiKKIE
         /tpKycODKtkfueDCNC+ZZXvmWx1KIDGR8Yx/kHGIQq8t3kqjGpoRYEqIGRw0PcbrmK6C
         rOErBvUjX9F630H89fRf8iX9Wys08MKGOjDZrcbx4o6S9SCTSBOfLS4hiGjaZsRaNCbG
         zhQdwJvCQq0IbLNGzqJu1ADoPGoyIesG7yT7hbl26OUclDDywA9mpB0E40zkgz7mMDQ1
         nTtQ==
X-Gm-Message-State: AOJu0YywRCuOKjcz194u0LcJu1CL304CXLihuD/NEHte6lK3MaSG+8Ej
	+0k0ovrnv2j/dB8LUP8bJJnHEOwM/sb7a6ze5CcqQAgAHDketwXkDLo+ZgTbzw==
X-Gm-Gg: ATEYQzx8A8BAHgZDN+vG0OaHpkiAsMqMpUDtR7xBIOqoAaQupeWD4qBWO9ShopELzxv
	X/ThQxcEKrdttSeoNDIVeVPKpfqYQkdgGTq3F5xR+CRTckIcGL0X4rHmVUs4YiBbGFSA6xZ7uJr
	V29xykiplxEaY8d+ZIB8Icnvm/AD3mAgFHdDAT4IZmDYmLMvVthZlgd2ORBplQY5ZCvN5OF6kmu
	fXAyL2kwXsSfeKAp6KATGt4buIZOKzsr7MkDPA2rgWnbuQvsIOK7jcaCE4sebpAlI+P3hHqk13W
	+q1M/o56Vnac/gxY0eaFIH9kAARAcDKxqX2dc39JtODDzJV1hDc6SdOayCFD3Dfy7p5dv/3S6gK
	0tb2aOb6aacPdE5XyLZRs+lvsFOwdymnQlzFCIW2uv3jKsilPKHSpSDb+f7KoZ2btbBGDUWummT
	STBeNymZDOFBoBSV+GN6co7mmVmWEm8K3o41rLf/Ei8IWBV2fpqFBI1eXa6fXTkmEyK+rw2nZ6P
	6+Kl0VuaVtoX1YXiw==
X-Received: by 2002:a05:6102:a54:b0:5df:b5d4:e45d with SMTP id ada2fe7eead31-5ffe62136bdmr1219163137.33.1772822308664;
        Fri, 06 Mar 2026 10:38:28 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b12e0a6sm2462757241.0.2026.03.06.10.38.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 10:38:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Fri,  6 Mar 2026 13:38:22 -0500
Message-ID: <20260306183822.630588-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Currently the code attempts to accept requests regardless of the
command identifier which may cause multiple requests to be marked
as pending (FLAG_DEFER_SETUP) which can cause more than
L2CAP_ECRED_MAX_CID(5) to be allocated in l2cap_ecred_rsp_defer
causing an overflow.

The spec is quite clear that the same identifier shall not be used on
subsequent requests:

'Within each signaling channel a different Identifier shall be used
for each successive request or indication.'
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d

So this attempts to check if there are any channels pending with the
same identifier and rejects if any are found.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 14131e427efd..f8f0f6f455c9 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5072,6 +5072,13 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer, &result);
+	if (result) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-- 
2.53.0

