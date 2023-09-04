Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9473CA0FF6
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbjIDWMM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240571AbjIDWMK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036179C
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a1de3417acso593231166b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865525; x=1694470325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpqCu60Uo5ndUxfDHlk2SXzECf518yYJiTvEcId+jnA=;
        b=XqGf84x4l5RD19E5+3QyNHR6O5PPfUBUXaWD9BqUBfbyVVq8O0NsqL86k4cTZfixbe
         YJtUY44domy0EXH6nj+AcWyIKYy9Da4hO+b32RzxEdxyrdCszcrIgkVUBQEeB2e2NMlT
         qZvgpWf9JHIxwrIEZJyNVq9vRcKDyiRPLDsXzTxJ3mDtPpzHHAcvVMxkcilvG0ogFhGQ
         xldRfYcN5bzIKpEkHla1ok5LitlbnVG8jKDOy/gLa6Eprd0He1MXe9zAFIP4mv97k92T
         zm1tywjdm/YVrQ9PNaYDHFW+Bf1hEIxl67zkTEvVms2gGt00n0p6tRZjlNG9YZlA1N5t
         23kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865525; x=1694470325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpqCu60Uo5ndUxfDHlk2SXzECf518yYJiTvEcId+jnA=;
        b=EI+r1knWss1KMc1McoHd335S67UckHh4IHYGma6yDsjoU6E5i/V2Mesgo7zEDNJyz1
         HkQQG9zchRlX0mTSnSoz4JWdCL2eAxmIrNbMYA/10qphawQD7oKjuOGIIxIIgSwsBNwH
         MeWFjqHk9fsLrR01+FEU1qsWO2SEqMWtRLu0P9wTD2u6XzlvBmGc2t37jKQjqdjMEBZ5
         4rfp+X+ulSVLvQETNy6vW7mnaAy1C3/K/+HoIDTxqh9MuUU/e1RvLtvLMcqnxp+WkZZ6
         SdoWsTRI3Vzfygxd05f+j2tp26Ce1FV5WqnyY4cmkzoCJQbEfGw/l3YcuhH+/y4wvqa/
         EUAQ==
X-Gm-Message-State: AOJu0YyGYrrexkcc3zdBoN0LuKhbi7RHfRjZeCvp12JHbPYND+rxWeTH
        rnilhLEEocWpoXxTmSy1zmqZfaVtYfr07kW0S+0=
X-Google-Smtp-Source: AGHT+IFytbEuoX+aHbLBqnNp4Xby20bgkTcZIp7/+iC3zlDrNfJDcNflr9qVByVIv0wjXq/xJdWA9Q==
X-Received: by 2002:a17:906:3010:b0:9a5:bceb:1cf8 with SMTP id 16-20020a170906301000b009a5bceb1cf8mr11139118ejz.3.1693865525645;
        Mon, 04 Sep 2023 15:12:05 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:12:05 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH 7/7] Bluetooth: unlink objects to avoid use-after-free
Date:   Tue,  5 Sep 2023 00:11:58 +0200
Message-Id: <20230904221158.35425-8-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904221158.35425-1-olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While stressing the Bluetooth subsystem with constant scanning [1],
we have observed use-after-free in a "l2cap_conn_get()" called from
"l2cap_chan_connect()". Our log could show "l2cap_conn_add()" was
reusing an existing "struct l2cap_conn" that was freed, and which
reference counter was at 0:

  [...]
  [  782.314141] [166] l2cap_conn_put:1940: conn cb471e8c, refcount 1
  [  782.314162] [166] l2cap_conn_free:1923: kfree(conn) cb471e8c
  [...]
  [  782.314693] [166] l2cap_chan_connect:7829: 00:00:00:00:00:00 -> 00:22:a3:07:0a:00 (type 1) psm 0x0080 mode 0x00
  [  782.314721] [166] hci_get_route:692: 00:00:00:00:00:00 -> 00:22:a3:07:0a:00
  [  782.314745] [166] hci_conn_hold:1152: hcon bb2debe3 orig conn->refcnt 0
  [  782.314766] [166] l2cap_conn_add:7719: hcon bb2debe3 reuse conn cb471e8c
  [  782.314786] [166] l2cap_conn_get:1931: conn cb471e8c, refcount 0
  [  782.314802] ------------[ cut here ]------------
  [  782.322645] WARNING: CPU: 1 PID: 166 at lib/refcount.c:25 l2cap_conn_get+0x8c/0x94
  [  782.336633] [57] le_scan_cleanup:156: hci0 hcon bb2debe3
  [  782.336669] refcount_t: addition on 0; use-after-free.
  [  782.344020] Modules linked in:
  [  782.349187] CPU: 1 PID: 166 Comm: ble-memleak-rep Not tainted 5.13.0 #20
  [  782.361524] Hardware name: STM32 (Device Tree Support)
  [  782.368778] [<c010e9a4>] (unwind_backtrace) from [<c010af48>] (show_stack+0x10/0x14)
  [  782.382160] [<c010af48>] (show_stack) from [<c07f9868>] (dump_stack+0xb4/0xc8)
  [  782.395026] [<c07f9868>] (dump_stack) from [<c07f6e6c>] (__warn+0xb8/0x114)
  [  782.407785] [<c07f6e6c>] (__warn) from [<c07f6f40>] (warn_slowpath_fmt+0x78/0xac)
  [  782.421203] [<c07f6f40>] (warn_slowpath_fmt) from [<c07d2400>] (l2cap_conn_get+0x8c/0x94)
  [  782.435352] [<c07d2400>] (l2cap_conn_get) from [<c07da654>] (l2cap_chan_connect+0x278/0x984)
  [  782.449802] [<c07da654>] (l2cap_chan_connect) from [<c07e1244>] (l2cap_sock_connect+0x144/0x21c)
  [  782.464717] [<c07e1244>] (l2cap_sock_connect) from [<c065c5e0>] (__sys_connect+0xc8/0xe0)
  [  782.479054] [<c065c5e0>] (__sys_connect) from [<c0100060>] (ret_fast_syscall+0x0/0x58)
  [...]

Our proposed solution is to avoid such a situation: the "struct
l2cap_conn" was reused via a dangling pointer, since the "struct
l2cap_conn" was freed. The pointers are the double-linked pointers
between "struct hci_conn" and "struct l2cap_conn". We can at least set
the dangling pointers to NULL, just before we free an object. This
will avoid the use-after-free.

Done: just before freeing a "struct hci_conn", set the corresponding
pointer to NULL in "struct l2cap_conn", and just before freeing a
"struct l2cap_conn", set the corresponding pointer to NULL in "struct
hci_conn".

Note that we take care for NULL when dereferencing the pointers. In:

  struct hci_conn *hcon;
  struct l2cap_conn *lcon;

expressions like "hcon->l2cap_data->hcon" or "lcon->hcon->l2cap_data"
could dereference NULL pointers, because "hcon->l2cap_data" or
"lcon->hcon" could be NULL. Indeed, "l2cap_conn_free()" and
"hci_conn_free()" run in different threads, potentially in parallel.

References:
- [1] "ble-memleak-repro"
      <https://gitlab.com/essensium-mind/ble-memleak-repro.git>

Signed-off-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
---
 net/bluetooth/hci_conn.c   | 7 +++++++
 net/bluetooth/l2cap_core.c | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 755125403331..86446f482b9f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1136,8 +1136,15 @@ static void hci_conn_unlink(struct hci_conn *conn)
 
 void hci_conn_free(struct hci_conn *conn)
 {
+	struct l2cap_conn *lcon = conn->l2cap_data;
+
 	BT_DBG("kfree(conn %p)", conn);
 
+	if (lcon && lcon->hcon == conn) {
+		BT_DBG("conn %p conn->l2cap_data->hcon = NULL", conn);
+		lcon->hcon = NULL;
+	}
+
 	kfree(conn);
 }
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5e4dd293b2a4..9c2384c32d93 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1949,6 +1949,11 @@ static void l2cap_conn_free(struct kref *ref)
 
 	BT_DBG("kfree(conn) %p", conn);
 
+	if (conn->hcon && conn->hcon->l2cap_data == conn) {
+		BT_DBG("conn %p conn->hcon->l2cap_data = NULL", conn);
+		conn->hcon->l2cap_data = NULL;
+	}
+
 	hci_conn_put(conn->hcon);
 	kfree(conn);
 }
-- 
2.39.2

