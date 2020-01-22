Return-Path: <SRS0=lsET=3L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6580EC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D3F21835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jan 2020 16:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="an2tVjAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgAVQJV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:09:21 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44839 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgAVQJV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jan 2020 11:09:21 -0500
Received: by mail-vk1-f196.google.com with SMTP id y184so52380vkc.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2020 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHF2IKiRh1iKsIm+VtNSl0gaZ27AZU2CCcJv/7yPvbs=;
        b=an2tVjAbutvzUxefOZCR27RXA18vElgnwg4dh1Nt2Lt0SyevoohnadHImvXEHHNBc9
         BVcxYEQ9t6Ef4h9A7d8ywoT6MpDVsIE7avWDhWxY1dNM4dgIPTSuseYgwSQccQ4Kd0AO
         upzif7rQFuvhShzbxoGXy9vdTHUob0JxY/VPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHF2IKiRh1iKsIm+VtNSl0gaZ27AZU2CCcJv/7yPvbs=;
        b=fPsHSN/HayLb0GHqMUXJjUPAQJnCSU8fvG/sKZMS+L1doYaSEqZ8u/VhvxnWfXRVBo
         eUHSJGz0+buwTSDQyy77TJnuAC7G713OQa6pFLxzBulm8eGvcP2L9MMsUF9wnIpPe8/i
         VMTPZXymcsU0dfU2z8qPLc9xQcM0ezAYm6rpxNTopPj21vb7GNUqUv6kCBG4GwyWpEMz
         SjBw3cjqgY72moo5oe2CutdNEGrzBLFs6zqxYzmz3NfkRoun0diVLyMA9gn0YKNf6vAc
         7UTA7WSwcSuyCqxM7levyIXbufjMVUshHWCeCqQCaSG/8T6kXecccd/RcwFqO4bzW7jU
         lsIA==
X-Gm-Message-State: APjAAAXqbpo783IlvPS6bc+3ClaIIWIZAIm8hT2XdXk6k4qvrqNl+PQE
        bHymmQ0sjxZVM8OcydpgRo0m2kLQneY=
X-Google-Smtp-Source: APXvYqzIvckql/3Dcv3hkWXeaxf3pWWxfJgP7LjX11iKPfC2Wl8yQ3vvMGGMRANAZce7+KDFtjFLYg==
X-Received: by 2002:a1f:18cf:: with SMTP id 198mr6590392vky.61.1579709359624;
        Wed, 22 Jan 2020 08:09:19 -0800 (PST)
Received: from alain.c.googlers.com.com (69.104.231.35.bc.googleusercontent.com. [35.231.104.69])
        by smtp.gmail.com with ESMTPSA id p145sm11983228vkp.43.2020.01.22.08.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:09:19 -0800 (PST)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH] bluetooth: adding missing const decoration to mgmt_status_table
Date:   Wed, 22 Jan 2020 16:09:16 +0000
Message-Id: <20200122160916.156321-1-alainm@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change simply adds a missing const decoration to the
mtmt_status_table definition.

Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0dc610faab70..3c68a366977f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -176,7 +176,7 @@ static const u16 mgmt_untrusted_events[] = {
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
 /* HCI to MGMT error code conversion table */
-static u8 mgmt_status_table[] = {
+static const u8 mgmt_status_table[] = {
 	MGMT_STATUS_SUCCESS,
 	MGMT_STATUS_UNKNOWN_COMMAND,	/* Unknown Command */
 	MGMT_STATUS_NOT_CONNECTED,	/* No Connection */
-- 
2.25.0.341.g760bfbb309-goog

