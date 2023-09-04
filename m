Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A661C83F33
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbjIDWMM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240559AbjIDWMK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:10 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CDBCDE
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bcf2de59cso277303766b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865525; x=1694470325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7D6jDdghy5xf6pMbgp+7uQJ09JEXfvhk/SVi6T9v3Ek=;
        b=WsoowIIwsTH6gDRPIEkDlBzfhAef6vHyYooPMNQ0/R7UHg4NZ3ymFQHYAF5qH6nN5k
         RMzOn18PqoR46Z5HBTFhZwZHEwfgye1gkuDaY5TdiTCBOR5/hueQ/nFQc96gILOg/+BE
         J/ziIi0f4S8Y/OLPHCiTngez4jqK/prKEx1c12G9LbFLk6k9s6avb4sJu/HB9afb6NfL
         rV48703CDaOAR6Z5etb7v2QeVvD+Zfi2xle3cHwOSUI6HKA9QzHw+TebZab6arybPAoj
         Vp1VlVPQ+imypGgoZy4mXU1KcJO2AV0tne/ixYIuteRXYBiOJOEV8SVteFSBiOiifDB9
         DvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865525; x=1694470325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D6jDdghy5xf6pMbgp+7uQJ09JEXfvhk/SVi6T9v3Ek=;
        b=QxaBH2cWzIP/dQChuiUkr95ca0BCYV46IMBGc0C3On4todXl+ei3FRfB67kAGZTDlN
         6NNiKf6Q2kz7OJbtULx+D90VHelzWeE4NOtmFrGxSpf6RyIH8QesVCz/maPnptiW5fC7
         ZkEHUxHQJbMnO7CKDc9/yQns37OzZFmvfCyfuYItePlHxzVJImG0MOJMFP1Gm/M+yzpe
         JwTQYbpk0TKOaKa9Q/NoyX/IB9mwFvqstZoBeaeV3X13j1yzai0hQAyoDlTo5P3lXlti
         iS9Y4T7rBYFhltYfWDOG0WEfPvzFlk2bzvtjTdSA6OvShG4xg7WFj1rHIe1GfxOhAy3q
         lpng==
X-Gm-Message-State: AOJu0YxQK2IpjxYZXzCBJ7Luzq7MMS/cGP1z9sB1loS0sAMWc/p55Mls
        SvZt/q27MfhK5ARj0HgTwtv87Q==
X-Google-Smtp-Source: AGHT+IFL5FtEPkDGuZTZWB/Nd8VBwJtn8Tyx+gwnrjOR4xJEYJCQ0t5YGJjf7AMvoxlFwcyUvL3I4A==
X-Received: by 2002:a17:906:3149:b0:9a5:cade:8044 with SMTP id e9-20020a170906314900b009a5cade8044mr7760863eje.21.1693865524929;
        Mon, 04 Sep 2023 15:12:04 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:12:04 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH 6/7] Bluetooth: L2CAP: inc refcount if reuse struct l2cap_conn
Date:   Tue,  5 Sep 2023 00:11:57 +0200
Message-Id: <20230904221158.35425-7-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904221158.35425-1-olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Now that the "struct l2cap_conn" memory leak [1] is fixed, we observe
use-after-free errors.

Arnout Vandecappelle has found the root cause: the

    if (conn)
            return conn;

at the beginning of "l2cap_conn_add()". It reuses an existing "struct
l2cap_conn *" instead of allocating a new one.

But there is an incoherence in the reference counting:

 1. In the normal case (no reuse), "l2cap_conn_add()" allocates a new
    "struct l2cap_conn", initiates its "ref" reference counter to 1 and
    returns it. The caller is responsible to eventually call
    "l2cap_conn_put()" to free the returned "struct l2cap_conn".
 2. If "l2cap_conn_add()" reuses an existing "struct l2cap_conn", it
    will return it immediately. But the caller, which can not know if
    "l2cap_conn_add()" reused an existing "struct l2cap_conn" or not,
    will eventually call "l2cap_conn_put()", for which there were no
    corresponding "l2cap_conn_get()".

Tracing the reuse showed the reuse was indeed the reason for the
use-after-free:

  [...]
  [  960.331756] l2cap_conn_add:7719: hcon 1f5f8bdf reuse conn b69c7ec5
  [  960.331798] ------------[ cut here ]------------
  [  960.339480] WARNING: CPU: 0 PID: 173 at lib/refcount.c:25 l2cap_conn_get+0x8c/0x94
  [  960.353863] refcount_t: addition on 0; use-after-free.
  [  960.362924] Modules linked in:
  [  960.368036] CPU: 0 PID: 173 Comm: ble-memleak-rep Not tainted 5.13.0 #19
  [  960.380245] Hardware name: STM32 (Device Tree Support)
  [  960.387449] [<c010e9a4>] (unwind_backtrace) from [<c010af48>] (show_stack+0x10/0x14)
  [  960.400742] [<c010af48>] (show_stack) from [<c07f98dc>] (dump_stack+0xb4/0xc8)
  [  960.413501] [<c07f98dc>] (dump_stack) from [<c07f6ee0>] (__warn+0xb8/0x114)
  [  960.425994] [<c07f6ee0>] (__warn) from [<c07f6fb4>] (warn_slowpath_fmt+0x78/0xac)
  [  960.439016] [<c07f6fb4>] (warn_slowpath_fmt) from [<c07d2690>] (l2cap_conn_get+0x8c/0x94)
  [  960.452752] [<c07d2690>] (l2cap_conn_get) from [<c07d92b0>] (__l2cap_chan_add+0x3c/0x1e4)
  [  960.466486] [<c07d92b0>] (__l2cap_chan_add) from [<c07da8d0>] (l2cap_chan_connect+0x514/0x9c8)
  [  960.480656] [<c07da8d0>] (l2cap_chan_connect) from [<c07e12b8>] (l2cap_sock_connect+0x144/0x21c)
  [  960.495023] [<c07e12b8>] (l2cap_sock_connect) from [<c065c5e0>] (__sys_connect+0xc8/0xe0)
  [  960.508927] [<c065c5e0>] (__sys_connect) from [<c0100060>] (ret_fast_syscall+0x0/0x58)
  [...]

The solution to the incoherence is to strictly apply the rules of
reference counting [2]. By returning a reference to the reused "struct
l2cap_conn", "l2cap_conn_add()" creates a new reference, and this
reference should be reference-counted. The:

    if (conn)
            return conn;

must thus become:

    if (conn)
            return l2cap_conn_get(conn);

References:
- [1] "ble-memleak-repro"
      <https://gitlab.com/essensium-mind/ble-memleak-repro.git>
- [2] "Adding reference counters (krefs) to kernel objects"
      <https://www.kernel.org/doc/html/latest/core-api/kref.html>

Signed-off-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Olivier L'Heureux <olivier.lheureux@mind.be>
Suggested-by: Arnout Vandecappelle <arnout.vandecappelle@mind.be>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f5dcb4a4fb15..5e4dd293b2a4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7844,8 +7844,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	struct hci_chan *hchan;
 
 	if (conn) {
-		BT_DBG("hcon %p reuse conn %p", hcon, conn);
-		return conn;
+		BT_DBG("hcon %p reuse conn %p with l2cap_conn_get()", hcon, conn);
+		return l2cap_conn_get(conn);
 	}
 
 	hchan = hci_chan_create(hcon);
-- 
2.39.2

