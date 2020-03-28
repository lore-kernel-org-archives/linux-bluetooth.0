Return-Path: <SRS0=vtF+=5N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E731C43331
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5D52074A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Mar 2020 00:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V/6t1/wr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgC1AJm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:09:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33705 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgC1AJm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 20:09:42 -0400
Received: by mail-ot1-f65.google.com with SMTP id 22so11722078otf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=WJms91HXX+7xCzd5cTG+KTHXD0CxMdfmfzkjjKZXMRQ=;
        b=V/6t1/wrlarhTiIIdVrvDjExNcUDgrd4tll2blAqdX17YlLRQQcyX90GqLFnaromP9
         LuDqJKQPQmH4Wq1aN4HCEWzhvPyHAOwgi/G9WQ3WYMff+SLL156lecVLTscduGJyrOCn
         4t/07LVPc/OVTyrevCAxHfBaSE5k6rRWbfRN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WJms91HXX+7xCzd5cTG+KTHXD0CxMdfmfzkjjKZXMRQ=;
        b=XN+h7ybevMhqpBNIL6kj8H/kTgKJh43KY+Pom4XPGDM8cUSw1jusgb3dR0kCAlwFmT
         9Verh+Nj6vrj7c+MgeNSnltNBI3gU8HIGn7fSLXzH1Ri9CnzBGsYyBL3ACHDjlW9Gq9n
         ajckHlvzAQ0BOwVf0C4f4isYxLl+nbOGYl4Aymz0bOs/8PmAlsyhjGcSqKd4euI0gwWs
         yLdgOPrL5uvSIx8g0MKccN5CKaZ0LER3XsEAbMPuChAYEIpcPPGvqqL1j0rf7pK0Lli8
         LI97cTQCfpVMwZNtwKaPTgG5DnyPWUrJw6HnjrMPhnphu29dWynl8CjsO+3vstStWwrr
         VsAA==
X-Gm-Message-State: ANhLgQ1BzgTYLUKJPKqdmWYbbFZRqj+yXl3drFhMXhWRk8NtO6EsAhTD
        o0xrKWE9tdfv8kwfPUQCNSze/R0wnaaE23wH8chv6pA2xAY=
X-Google-Smtp-Source: ADFU+vsUoPbZyYmAPY6zPEa8D8V8r34NlO27ZLbFg5aD1NKsCLwXxMhLogvsM3WkuVv5ryAVC+Ow44codWt1AWkQ9CY=
X-Received: by 2002:a9d:1b6d:: with SMTP id l100mr946856otl.70.1585354181011;
 Fri, 27 Mar 2020 17:09:41 -0700 (PDT)
MIME-Version: 1.0
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Fri, 27 Mar 2020 17:09:29 -0700
Message-ID: <CAOxioNnvHMgHyVxbt2Oj+FeHcOT8MdxYtuv_s0PPd_YzkvuxGg@mail.gmail.com>
Subject: [PATCH] Bluetooth: Always request for user confirmation for Just Works
To:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To improve security, always give the user-space daemon a chance to
accept or reject a Just Works pairing (LE). The daemon may decide to
auto-accept based on the user's intent.

Signed-off-by: Sonny Sasaka <sonnysasaka@chromium.org>
---
 net/bluetooth/smp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1476a91ce935..d0b695ee49f6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -855,6 +855,7 @@ static int tk_request(struct l2cap_conn *conn, u8
remote_oob, u8 auth,
  struct smp_chan *smp = chan->data;
  u32 passkey = 0;
  int ret = 0;
+ int err;

  /* Initialize key for JUST WORKS */
  memset(smp->tk, 0, sizeof(smp->tk));
@@ -883,9 +884,16 @@ static int tk_request(struct l2cap_conn *conn, u8
remote_oob, u8 auth,
     hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
  smp->method = JUST_WORKS;

- /* If Just Works, Continue with Zero TK */
+ /* If Just Works, Continue with Zero TK and ask user-space for
+ * confirmation */
  if (smp->method == JUST_WORKS) {
- set_bit(SMP_FLAG_TK_VALID, &smp->flags);
+ err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst,
+ hcon->type,
+ hcon->dst_type,
+ passkey, 1);
+ if (err)
+ return SMP_UNSPECIFIED;
+ set_bit(SMP_FLAG_WAIT_USER, &smp->flags);
  return 0;
  }

-- 
2.17.1
