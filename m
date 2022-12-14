Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B2CC4167B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Dec 2022 00:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiLNAVl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Dec 2022 19:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiLNAVg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Dec 2022 19:21:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C7727E
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 16:21:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so5367805pjs.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Dec 2022 16:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZKN+1Y4USHKxkO6EJtuAshV04MjNaTp8m9Px1Ay59E=;
        b=mr/+fPk3vlGTsdVWdKKCV8s6rQFw7BqOW6Lv0nkrt2PgvnaCg8Yzol9zaKGKgeKPa+
         gSCvtpXVuEID4ZokJsTQ+AvDYq/ja/Vr4UGSNS5mZCO/arUwNhcXQyuSw2KGo7BNytbP
         TmHkzMSo07tn8MoElyyQZ/q6k0AkZs4ScI3XK04KiNrrQqyhHzWvjFeoEdiFAUpcV3mO
         NLwXgJPM3EnrXpOTqn+htXy3h0yBpmniJcuqP4PZvJ9snzcPfPXsj+HUb4SOKigtODzX
         /QiT1T5H/d96bFBhq2cskAZSXDWpuLQRg7fXqiFzrxpb3qtA7EsxCAQaIlDWIiVh+792
         7PIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZKN+1Y4USHKxkO6EJtuAshV04MjNaTp8m9Px1Ay59E=;
        b=H6xxu4CpbUwgS3KKCalXxQaTQur8r1ol4C5UjoG8mh+eoFUe7yMEZdMv2gNf6ZU3Oc
         /pf7cSXt0QT8IZphBCn/3xsPzaQR30lXvMToIgC7Iw8Buoeghgr50a+N8/XD91tMi1lJ
         dXp2H1+0Qt0XIeMS7Qr8TIwdrG5XKUOo4y+BVIUVs+ldesnaU2jSykpsLaqGCMgOvFDN
         6BnFXeSj+1POq1Yn4UB8+OiTSREbvWiF/G5OQVDm+AaeTd+Pz9SuxgzsgbsGohMTLsgg
         Sv3o4Y8eR6vGg7hA+QjjGN2QLappn09pOxv7QBzAByZBCXfBBMoYmg+Y9EiDvOHMWuE4
         R3Fw==
X-Gm-Message-State: ANoB5pm9vOU/C8W8ZjB1HlEnfXUq450pFNrlR379w3LaAyjMW5o1jlqt
        nqN7xpcvbie/W/rpFdV6pSLldae1n2brCmpY
X-Google-Smtp-Source: AA0mqf4IPHMWvGc40CyP+afzDrpNPx1enQgbJwPhd5dIUxCXLjU+iyMSB2SiuN03MyIEh1d+V+joAA==
X-Received: by 2002:a17:902:cf4c:b0:189:d696:63e2 with SMTP id e12-20020a170902cf4c00b00189d69663e2mr25885265plg.39.1670977294770;
        Tue, 13 Dec 2022 16:21:34 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id ij22-20020a170902ab5600b001895d871c95sm482446plb.70.2022.12.13.16.21.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 16:21:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client/player: Use bt_shell_echo to print transfer progress
Date:   Tue, 13 Dec 2022 16:21:29 -0800
Message-Id: <20221214002129.2105777-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221214002129.2105777-1-luiz.dentz@gmail.com>
References: <20221214002129.2105777-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_shell_echo to print transfer progress.
---
 client/player.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/client/player.c b/client/player.c
index 2c15fb0c2d01..259e0eb0933c 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3045,11 +3045,11 @@ static bool transport_recv(struct io *io, void *user_data)
 		return true;
 	}
 
-	bt_shell_printf("[seq %d] recv: %u bytes\n", transport->seq, ret);
+	bt_shell_echo("[seq %d] recv: %u bytes", transport->seq, ret);
 
 	transport->seq++;
 
-	if (transport->fd) {
+	if (transport->fd >= 0) {
 		len = write(transport->fd, buf, ret);
 		if (len < 0)
 			bt_shell_printf("Unable to write: %s (%d)",
@@ -3423,7 +3423,6 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 
 	for (i = 0; i < num; i++, transport->seq++) {
 		ssize_t ret;
-		int queued;
 		int secs = 0, nsecs = 0;
 
 		ret = read(fd, buf, transport->mtu[1]);
@@ -3445,13 +3444,10 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 
 		elapsed_time(!transport->seq, &secs, &nsecs);
 
-		ioctl(transport->sk, TIOCOUTQ, &queued);
-
-		bt_shell_printf("[seq %d %d.%03ds] send: %zd bytes "
-				"(TIOCOUTQ %d bytes)\n",
+		bt_shell_echo("[seq %d %d.%03ds] send: %zd bytes ",
 				transport->seq, secs,
 				(nsecs + 500000) / 1000000,
-				ret, queued);
+				ret);
 	}
 
 	free(buf);
-- 
2.37.3

