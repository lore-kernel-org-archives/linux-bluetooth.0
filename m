Return-Path: <SRS0=cy5f=Q3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77498C4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4800B2146E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Feb 2019 10:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="oEKTrhAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBTKOx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:14:53 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39268 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbfBTKOx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Feb 2019 05:14:53 -0500
Received: by mail-lj1-f196.google.com with SMTP id g80so20291954ljg.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Feb 2019 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TvL4lojscjufBCQahPKSudRpuzY9MWZTcTvqbJH9sVg=;
        b=oEKTrhANr4aLnSp4fG1uX0qpDcgHgpkNGupb3f8vw7G2vy6g2QMNzTzOSYGtiWOQGn
         DAqGwX+3NAesnzrjZyHGVOIVrdJuekwOb/I7N/DmIyROd24eFH/KkDz2wxk6CdoEWF2A
         bh4cYFklA8zCApwqpCxikFuR3vKxIAeY4v2VItOiv0tv7rq2t6u2IiLCj+j7pcqvxVRJ
         koN03sO1aHvu5rcf1m7AMB32n0tfpcE2JUTDLWu02Q8Ig3RxnmcVYDZxN79TK+y78Nvp
         bfW4mNLV5wu6SMstQA8VQS84OiNQIPjuYqY8j0ORKrf+9/An4M4ZxCUSVMUpMdWzMLXD
         VCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TvL4lojscjufBCQahPKSudRpuzY9MWZTcTvqbJH9sVg=;
        b=IvPEOZ/okG5heCgf1jUeR+rH8RDLaywyQ9dxA4lnyeLDimhY1/bL+vrNaPcpmZnuQq
         6H3m33mhAjulUYyPJlkbNk1jIvALPGZu9bW8THcqd9+zNgebq3hj4kGqHKyeiBUBmlzs
         +XZsi1H/385MIK/am8bq/zkcQ5fAeK0McQ+1dXutj72e/7Ts4owfIkz1k2Rm/7wHFNCR
         /7Pncbz3rnbSaL5IzImu6Yr+/Z4/s1wPOgWQsrgEocShLHurbxnFlSFvKi26R7lTWQUZ
         HysDyKbkvTA+argiBm66iXfaiBihlobCVcPZF5+eTZNu+BF9uyBi8nBC1WtR1KrZabkE
         T2EA==
X-Gm-Message-State: AHQUAuauqxmJMDLOBjLP5Y5m1/B4xzoNIZfsNnSZbaqIsI2yhu88GyJg
        pqxR6WKwn/85GcFLDcU3t3YHTAqU3j4=
X-Google-Smtp-Source: AHgI3IaMtXzLqTdcOHPoAqXffE4+9uruXsHbVT1JGcrLaPkuIVSyN0NbHdLxnBCvlMmgZkbGtYG8Rg==
X-Received: by 2002:a2e:6e09:: with SMTP id j9-v6mr19540151ljc.118.1550657691234;
        Wed, 20 Feb 2019 02:14:51 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id x19sm3856218lfe.42.2019.02.20.02.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 02:14:50 -0800 (PST)
From:   Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 3/5] Bluetooth: Allow new connection if already a slave
Date:   Wed, 20 Feb 2019 11:14:26 +0100
Message-Id: <20190220101428.3086-3-andrzej.kaczmarek@codecoup.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
References: <20190220101428.3086-1-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

With this patch it is possible to initiate new connection when there are
already connections in slave role present. This requires support in the
controller so need to check LE supported stated bit mask.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
---
 net/bluetooth/hci_event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 609fd6871c5a..d3ac83be0427 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5072,10 +5072,11 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	if (hci_bdaddr_list_lookup(&hdev->blacklist, addr, addr_type))
 		return NULL;
 
-	/* Most controller will fail if we try to create new connections
-	 * while we have an existing one in slave role.
+	/* If we have existing connection in slave role, check if controller
+	 * supports Initiating State and Connection State (Slave Role) states
+	 * combination (bit #41 in states mask).
 	 */
-	if (hdev->conn_hash.le_num_slave > 0)
+	if (hdev->conn_hash.le_num_slave > 0 && !(hdev->le_states[5] & 0x02))
 		return NULL;
 
 	/* If we're not connectable only connect devices that we have in
-- 
2.20.1

