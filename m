Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DA4C7619D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4A524670
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qigpnAhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBTAzZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:55:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40078 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgBTAzY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 19:55:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id a142so25829493oii.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 16:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5iyro5dL5q833u0D7Sw6LWpoy/E1PZqzaXCOHpKQVQ=;
        b=qigpnAhTJOkcq1xfHS7s5SvkNY0jlbhvJ50iRgkksQmFAjFCjLnat2yaLdS8HlUEbn
         61AhaZhgohzRRDf+N/dpyCMtr1lC7Y1sxyGIDq/xiM2jSeeyhGs7MgSqVft18U9o0rwV
         RAnTLlbEMmkRL1kdC3UnJVsSXon7Vr25SpgnlmU4j9BIvGCj6/OeRGYMnN/62IPqBnYS
         1hSS8RMorAO9Y/mE40YOOkmPhH6ohy1V3GG8kfut1noe/p+NduO99PS3Nt7w+G9GqYRX
         +xc0i3z9ThHKfLfNDFKrB2lbbkKOKctj1582iHP1J5VIXpajGGXCA3Guvcj68gtvVF5Q
         XLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+5iyro5dL5q833u0D7Sw6LWpoy/E1PZqzaXCOHpKQVQ=;
        b=MzPACCblvrj38YjhTqTbNTm71jTxLGRkxRwAsc4mnq7jSiZ9K+xXrVz6GNnjDiwnWU
         UGF0d6o/y9qxlHZ0VZrTBTqEmsQs4mgDjg7jel1DThIzQO0Ytf9MtA6wnFM/qH0vAAwi
         1VSaCdRGlaLN3xq88j4RWIuV98n/tKsB6mOKOUhT3WziPWfJCf/nJRT5Bbn/l/5wkT3i
         lSDW7QuKZGQb1SyfmhgR56hx+p3y+pKf05ccOFnAi6dDGRMciqVtOPY/pO8jW9Gsg8/f
         0b7PaU5E1llVaUCke8BwAO6XRT9UpMeTdJNEy9ne7mXyrGUpbCVRumpGgVSfN5LXUzH6
         bt4w==
X-Gm-Message-State: APjAAAVe/riIM1WzMwHx0IsxxcyQd0mJRZFgiO3ZCFrcPUqi1atuYx4T
        3qvR0GViRCqje0Rp1PKe6bDfW73btDU=
X-Google-Smtp-Source: APXvYqy0KX9BEPYKEZ0SQaD0+OPVJ0mmMR6x+VQnbTJNctvIDTfAjo2ec/QEaBlOn7i+uixA4lKRIw==
X-Received: by 2002:a17:90b:11cd:: with SMTP id gv13mr484574pjb.94.1582159682769;
        Wed, 19 Feb 2020 16:48:02 -0800 (PST)
Received: from vudentzs-t460s.hsd1.or.comcast.net ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id y15sm855680pgj.78.2020.02.19.16.48.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:48:01 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix crash when using new BT_PHY option
Date:   Wed, 19 Feb 2020 16:48:01 -0800
Message-Id: <20200220004801.19944-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the invalid check for connected socket which causes the
following trace due to sco_pi(sk)->conn being NULL:

RIP: 0010:sco_sock_getsockopt+0x2ff/0x800 net/bluetooth/sco.c:966

L2CAP has also been fixed since it has the same problem.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 2 +-
 net/bluetooth/sco.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9fb47b2b13c9..305710446e66 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -605,7 +605,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PHY:
-		if (sk->sk_state == BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED) {
 			err = -ENOTCONN;
 			break;
 		}
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 29ab3e12fb46..c8c3d38cdc7b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -958,7 +958,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PHY:
-		if (sk->sk_state == BT_CONNECTED) {
+		if (sk->sk_state != BT_CONNECTED) {
 			err = -ENOTCONN;
 			break;
 		}
-- 
2.21.1

