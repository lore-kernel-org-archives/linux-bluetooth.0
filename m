Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D113D6CDA
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779811; cv=none; b=PaNYU9pEP6vyfDpUDnTk0nYRMtk+QrOQEMTj/KGYhR1fAGt8FO7vWckXKFYR6NRGLbNeh3fSR1iRhEFuEObJLsp+/5h++CxoU16Mw8D9eJ2dRpOUxoE3rEiAx/yo6hyg8hMqE+sM+mlA8L54Iq6+Cq6PBJRdGwkEJiDPy1Q1u+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779811; c=relaxed/simple;
	bh=nYU4fnXvJnfceEaKFU1kKDN/vmUIeBcyup447IWCgFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbTESc6UF5hUf5Cxq2hoDkYf/Nutcc7omVOAMDU/PDsFEK/3rD0QTeTTue9BzwaqwZf9Qhw7dTr1zXFI+XHwO+Q9CfoxxZHe//O9muJ3KZ4D54eZza+oS7RzJ7y2LOx6MO5Rqcd+tCkZ12kDyF99L8qiRjojc8KOv5hkIH2uI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHovYTnk; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHovYTnk"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8ef0ba61d46so31186485a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779809; x=1777384609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rq/HLyYIOXuijt0EBIF+AOgprIQBVUvhx8WQw17WEI=;
        b=WHovYTnkYVZmumgh7eRmBSiCT5Mz1bn0Ozk7hgB5V2vNWqzJKl1URmX1+Ii/vazqym
         teUEXQ9fgIqyC4hUREvJdNCkNMz73wEEs2F92XRVJrIss+6E9Z/pw0t7guNJTdzU8luT
         EhZkem+GNwsk55OzOeeUTUWX01QW4PRGqWde+jBS4BNZS0SQ7l+gIxd8VmOOVrazQxrB
         +dV3zxWFdYp7Dj6+lvnioCeuOPpOHSj0Te7U/L0tTUi/xcLHqD2nNMyfXWZIcAv62Nr+
         /YF9yGL167xsAsaTZw+4tCoA/bu2imgstHrC//WzZCDYmIcDNCpOOPsuqVdB1qV3Yqik
         r8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779809; x=1777384609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Rq/HLyYIOXuijt0EBIF+AOgprIQBVUvhx8WQw17WEI=;
        b=lcBuOrMf3zyHom5tYAKebXi51P9cWMkJ/FQI/2VKu5+F67GNbeVV8AT3lpCHe9lz89
         +9F4dVbgMxtJZpHD4uciBf5ydYk/soDv0fIw5CNJdKeHuMXrUQF/cb7qugwxfSI6ds84
         MT8ApO4pSoNInmBcK+FJTY8ClCbdAHXRPUhQ55Elql3tJcNAjy0CeK4hRLbMLbg+TZq0
         ghPp/MN2+ScOxiQ2M8Vmmj/qM3saTqOKefp48qMvfV3Xjc0Z029BmOO309A1w85c5Iyb
         rJJ84TMOsk3ZyLgxwvBDLeZBEzZQUJ60YvDHhEXIGEAWigNlC+yFPbLzFtfIjzurqSOC
         4+Yg==
X-Forwarded-Encrypted: i=1; AFNElJ+z4V0kGeWkxCUXfFbrPqJ618dvzOjcSXLB+aLgrKr3BoM0w4UC4+Ii/DCYQ2Pu1fK0pzOIkcrtaoWYVEaF7gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGgcpTBVsRK+8nGdchsaI+NH05Eyq9EvxN/xxBZQ/DDJ59r79
	zGs84Muyrr91Wnb1UtuYeNbp7WCcUyNlEgPTplFkyZSZEfRHFbqPAmbC
X-Gm-Gg: AeBDietjQOrZujNX9DsWoFIVmHCJXCnflhXh/cMzv+p9EBXgUeFfKRX9BQvhtzN9pnc
	lf6ASKFI0/2WtBVI33LzF2rnSZY7Zpw68mMhJRlCwPOx81jC6toICh850WjjwEf7F7WU6Yxw/Ls
	zi9fA+xrtqvUeFzjlz+3a8pKeRf7SnyQDZB8kZ8SPNVHFNwTogqdJqUl+uLg7h8kRPcxwuNAN7c
	TZdrxj3TTCFu+ulEfck7fdFS0aQpW4kwzQN/oJms1rIcJcCNk6ZHi8sWtzKBvYt20foAYYI7AcS
	MiK3pPC2YiUlh5uYl1sC3hcFxI/OVjRe+zLdXevqX8UrFa30tt83lMmIVJkbyZSNXSOxGjBgSwn
	XVfybc8utMAdBZzk8Cli68S/VLUPOHjjyor1XxCIbCXuQAwrO7Ihv0WyL8iSThwsGaBG7lE7jVc
	Pqu13XBrQtCt0eSmw3KtlHFgbvT0efb9QJs9s1wfRaUSaaFvIt3hizO8Q48I54088AVxLTum398
	09nwXw/q2hVu3ItpJWowKqxNwV/lnw=
X-Received: by 2002:a05:620a:4722:b0:8cf:db04:8a31 with SMTP id af79cd13be357-8e79295cffamr2554011385a.55.1776779808936;
        Tue, 21 Apr 2026 06:56:48 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69ad48asm1033231385a.19.2026.04.21.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:56:48 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: L2CAP: handle zero txwin_size in ERTM RFC option
Date: Tue, 21 Apr 2026 09:56:38 -0400
Message-ID: <20260421135639.3185653-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
References: <20260417221628.1674866-1-michael.bommarito@gmail.com> <CABBYNZ+f3pur4cSsanQ1kvv-yORp2E0qmVLt9si_+FnnJup4Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peer-supplied ERTM RFC txwin_size = 0 can still propagate into the
ERTM transmit-window state, and the same invalid value can be
introduced locally through L2CAP_OPTIONS. In the request path that zero
reaches l2cap_seq_list_init(..., 0); in the response path it can shrink
ack_win to 0 and leave ERTM sequencing in a nonsensical state.

Normalize zero tx window values back to L2CAP_DEFAULT_TX_WINDOW
wherever they enter the ERTM state machine: local socket options,
outgoing tx_win setup, incoming config requests, and config-response
parsing. Also make l2cap_seq_list_free() clear its metadata after kfree
so an init failure after freeing srej_list cannot be freed a second time
during later channel teardown.

Fixes: 3c588192b5e5 ("Bluetooth: Add the l2cap_seq_list structure for tracking frames")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
Changes in v2:
- drop the v1 `l2cap_seq_list_init(size == 0) -> -EINVAL` approach
  and instead normalize zero tx window values at the socket /
  request / response inputs
- clamp the local `L2CAP_OPTIONS` txwin_size = 0 case back to
  `L2CAP_DEFAULT_TX_WINDOW`
- make `l2cap_seq_list_free()` clear its metadata after `kfree()` so
  later teardown cannot trip over a previously freed list
- split the repeated `CONFIG_RSP` ERTM re-init fix into patch 2

 net/bluetooth/l2cap_core.c | 23 +++++++++++++++++++----
 net/bluetooth/l2cap_sock.c |  3 +++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 95c65fece39b..7ffafd117817 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -345,6 +345,10 @@ static int l2cap_seq_list_init(struct l2cap_seq_list *seq_list, u16 size)
 static inline void l2cap_seq_list_free(struct l2cap_seq_list *seq_list)
 {
 	kfree(seq_list->list);
+	seq_list->list = NULL;
+	seq_list->mask = 0;
+	seq_list->head = L2CAP_SEQ_LIST_CLEAR;
+	seq_list->tail = L2CAP_SEQ_LIST_CLEAR;
 }
 
 static inline bool l2cap_seq_list_contains(struct l2cap_seq_list *seq_list,
@@ -3234,8 +3238,15 @@ static void __l2cap_set_ertm_timeouts(struct l2cap_chan *chan,
 	rfc->monitor_timeout = cpu_to_le16(L2CAP_DEFAULT_MONITOR_TO);
 }
 
+static inline u16 l2cap_txwin_default(u16 txwin)
+{
+	return txwin ? txwin : L2CAP_DEFAULT_TX_WINDOW;
+}
+
 static inline void l2cap_txwin_setup(struct l2cap_chan *chan)
 {
+	chan->tx_win = l2cap_txwin_default(chan->tx_win);
+
 	if (chan->tx_win > L2CAP_DEFAULT_TX_WINDOW &&
 	    __l2cap_ews_supported(chan->conn)) {
 		/* use extended control field */
@@ -3593,6 +3604,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 			break;
 
 		case L2CAP_MODE_ERTM:
+			rfc.txwin_size = l2cap_txwin_default(rfc.txwin_size);
+
 			if (!test_bit(CONF_EWS_RECV, &chan->conf_state))
 				chan->remote_tx_win = rfc.txwin_size;
 			else
@@ -3715,7 +3728,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 		case L2CAP_CONF_EWS:
 			if (olen != 2)
 				break;
-			chan->ack_win = min_t(u16, val, chan->ack_win);
+			chan->ack_win = min_t(u16, l2cap_txwin_default(val),
+					      chan->ack_win);
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
 					   chan->tx_win, endptr - ptr);
 			break;
@@ -3756,7 +3770,7 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 			chan->mps    = le16_to_cpu(rfc.max_pdu_size);
 			if (!test_bit(FLAG_EXT_CTRL, &chan->flags))
 				chan->ack_win = min_t(u16, chan->ack_win,
-						      rfc.txwin_size);
+						      l2cap_txwin_default(rfc.txwin_size));
 
 			if (test_bit(FLAG_EFS_ENABLE, &chan->flags)) {
 				chan->local_msdu = le16_to_cpu(efs.msdu);
@@ -3970,10 +3984,11 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 		chan->monitor_timeout = le16_to_cpu(rfc.monitor_timeout);
 		chan->mps = le16_to_cpu(rfc.max_pdu_size);
 		if (test_bit(FLAG_EXT_CTRL, &chan->flags))
-			chan->ack_win = min_t(u16, chan->ack_win, txwin_ext);
+			chan->ack_win = min_t(u16, chan->ack_win,
+					      l2cap_txwin_default(txwin_ext));
 		else
 			chan->ack_win = min_t(u16, chan->ack_win,
-					      rfc.txwin_size);
+					      l2cap_txwin_default(rfc.txwin_size));
 		break;
 	case L2CAP_MODE_STREAMING:
 		chan->mps    = le16_to_cpu(rfc.max_pdu_size);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 71e8c1b45bce..3b53e967bf40 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -765,6 +765,9 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 			break;
 		}
 
+		if (!opts.txwin_size)
+			opts.txwin_size = L2CAP_DEFAULT_TX_WINDOW;
+
 		if (!l2cap_valid_mtu(chan, opts.imtu)) {
 			err = -EINVAL;
 			break;
-- 
2.53.0
