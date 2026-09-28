Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1B4D9F62
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616781; cv=none; b=Co4BwODflqiixU3vpl9T5je6RRWhoOn8vtmdJ2GeYMDs3UNOIcnUzJXaxV0TM6ctOjpLZn93SOmIF09ZOTq5WZv/SQBh9kha8eToLjJSuzL5NajIlICkq8HdTyJlW/jY+vixcrl8wfFxG9XY35NLGhmbyfzuU8NB9blJR4BeW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616781; c=relaxed/simple;
	bh=bdAagqAs0b1MGOUcgJ2e3vFE/avgZo8hvzyvybGoe4g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wcq1VMZXhLjobGMVqqdfgXN+vDy1CfL1/aDtElV6rjCLUl8tuatVrmNipRzy6f9a6unK0xV4Ms9gPmnnq149TlKSY7np1m+xQViIn82OQoKrPc8r9Kjapj25yTnuK7LTbFyAGHpvpFCQa0FsB5qT7bUSobWlL5CsqwVdO0E/78g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tov9Y58s; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tov9Y58s"
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7b47bba7c88so908669137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616778; x=1791221578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LnFmf7TyEvcV1AIaMAYFTJhUcAWz8WBQusWqysASTdc=;
        b=Tov9Y58sr/RaiuqhKZb2FFiBcPZQuGrv8DSd3tRTs9xnBvis8ZPC687yZoAcVFQXeB
         GwuFdCM3XoRCbPUMPpEPNpsqc/fIPdH6ZxLpICNNG9BpSwFcXWMn8jX/CnDMAksA0x6P
         wH/9JVPfPaUEf2pbnN5Aa7RSmEW1vfGO9+9eJmtzC11hnCV3WCJ5fA5prWh/2MCfqY04
         LE1ttyfaxu6OtpNFwb7NYeiZBZzkcZ706X+SP8HdVMlhr5XCf0TityzDcQV0pndfAG+h
         5xCYjvwr0F7vn+5io157eyd6c5EBofXInZMbtErdv2iGwfWC3Gz36xaq9OLE1McMHjHn
         mlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616778; x=1791221578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LnFmf7TyEvcV1AIaMAYFTJhUcAWz8WBQusWqysASTdc=;
        b=IFYcPM4WcDCdFRUuCzX66Fgco1nkM1I11Qyhyqi6xrbVGtkbP6FJvutcx7GQegaceq
         A0Dbi/FDw9NXC6gU4jUMPcMRfOvHJDeIVhskdTxMW6jBv7vRkOXF2hcDod+ucZCpSUII
         D4AxuBOLYpyA9r1iUmv05dC0bjuEberYSHDGFgOuCbGjwk8Evx0b0zXI//gzvXY0DGgd
         Q42VABO6K72rcnjDvLLKpnE89ebt61UqnqnIplXvRxDeLUkITDGm847dZGe6RXjnJmQh
         SemZ3rqmNIr+P1BV+x7wNC+4GIHDYbmSppOtt8SoUv9GRo1qeWkYcLeDOrcRT7zjeRxq
         z5eQ==
X-Gm-Message-State: AFq9FYJ9CqoqQ8Q0NHEnOvyyWQp6onVqRme/n7k8U4ISRwHoIJ7KBgJo
	pxdzZxPMYLa40Dy+HUu14aDI3AX/bKSHw8key5+D3BAn+OFjxNJIaXjyyrk1E86nmn4=
X-Gm-Gg: AYBFou2qX/sb3iGU5WAwlstU75byjklfjQ1tMhCdMlIkW1c98m2E5pxTJOsTtSL/514
	DytxtJVAIMgpChodf56McLM6LBW5D2+bVVtWV+7TjrGzoxCxH+q5RkmOoEKRqcxpQfkUNj/jnCZ
	9TsRyx1q4Lw+cvKilmAorl/8z5UhcKr+pJ0T7qClnUaN8l7jsoABokNcMudLF5Zn+F++vbfuddV
	viTjQdSm1Hz9h1DwK8cqdhNVyO5va2Xtxz3C7/Vd6JsmWEIh1zUd4KBAnXFMP1BPt1vJwxlaDvG
	tybqJv9d3sRM19jMe1Ldt9H/4P9X8vyPhgd6Eu55yRhpykXq0C7/9bEaNnn750da0YiNDLU9g5v
	r7jiFmOa0OReloyg85fmiPeXArMwsrhhzEMSwjZymy13s3L/+lqMKJDOh5/jNFrFLb/8jfoKpEe
	uua96y0/QxsBtSH/OxQO70275S7nmnSO9E0AB202nFLtORyVPAAjFFlO2e8xBEqqcRwQAG/ZYQx
	p90PUdHPJtNhpmnhi00pehdKR5XPy6Lh7lF6gjTO9cpb+2yurnZfnjHAE0/oKiEFVOPBlWmfF0=
X-Received: by 2002:a05:6102:38ce:b0:7a3:3d26:5c67 with SMTP id ada2fe7eead31-7af1e4f2ddamr4984581137.24.1790616778390;
        Mon, 28 Sep 2026 10:32:58 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.32.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:32:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 03/21] client/mgmt: Print Connection Subrate event
Date: Mon, 28 Sep 2026 13:32:22 -0400
Message-ID: <20260928173243.1073509-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.

Assisted-by: OpenCode:claude-opus-5.5
---
 client/mgmt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index cd2ef80221ad..a7069e5bbb37 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -499,6 +499,35 @@ static void disconnected(uint16_t index, uint16_t len, const void *param,
 			index, addr, typestr(ev->addr.type), reason);
 }
 
+static void conn_subrate(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_conn_subrate *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Invalid connection subrate event length (%u bytes)",
+									len);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	if (ev->status) {
+		print("hci%u %s type %s connection subrate failed status "
+			"0x%02x (%s)", index, addr, typestr(ev->addr.type),
+			ev->status, mgmt_errstr(ev->status));
+		return;
+	}
+
+	print("hci%u %s type %s connection subrate interval 0x%04x "
+		"subrate 0x%04x latency 0x%04x cont_num 0x%04x timeout 0x%04x",
+		index, addr, typestr(ev->addr.type),
+		le16_to_cpu(ev->interval), le16_to_cpu(ev->subrate),
+		le16_to_cpu(ev->latency), le16_to_cpu(ev->cont_num),
+		le16_to_cpu(ev->supv_timeout));
+}
+
 static void conn_failed(uint16_t index, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -6006,6 +6035,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CONNECT_FAILED, index, conn_failed,
 								NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_CONN_SUBRATE, index, conn_subrate,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_AUTH_FAILED, index, auth_failed,
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED, index,
-- 
2.55.0

