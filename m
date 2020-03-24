Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C2CC10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 03:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C7E206F6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 03:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVSpXz5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCXDVy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:21:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41138 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgCXDVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Mar 2020 23:21:54 -0400
Received: by mail-pg1-f202.google.com with SMTP id m25so425033pgl.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 20:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5E7xY/NOYeWP3NRxLDQ373vARFYRr0EF+Npf48/Iquw=;
        b=tVSpXz5vBOR4q2GjPTpDQRlPzT5Rk+cHz9qZFySufYVV4nWhImNZLsyuks/LorC7t4
         +9pdaKhyB/dhjis9m8MhP2WQsaUcujrxIPP4CpHSCoTYvGD8ZkDTyoUjTj+9zxa44UT9
         PGdzVHKT40Apsv9+DYO01N7zTYXEQa96lrQZlrzf8H/ueykC/cTxeGT9VE+U51ZwFi+Q
         1rUmBbBxPhnsI1QT4PKiWEpipAHNAqHUUv1ez6Jxf7rV1QpVBFfxrg0V1C0KTAdgKd5S
         4FTpMQUl4X+JE0JS3nTvsPf6IVW7GBo4BaEfxPH2pPIJaW26guGV0E6VHaskO9qlEMyC
         VabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5E7xY/NOYeWP3NRxLDQ373vARFYRr0EF+Npf48/Iquw=;
        b=BoC6KOFHs8Z4p+DCfR4FqRsQNVK0asEFKDBbD3pSk5yqX/JV0ZHeMWrAC2UldW9umA
         j4drS72gnumXzyLqFvEzi/zDSuOkLk7T/gcE99lNqeT8kzahB+/hfhpzPZSbJyfjq39G
         NiIKZ199EflI8QXPxdyF4dv4AcS5vWOOvIo2tlR6PIHEQfqxtyXZPQ80L4H1khq09dSP
         Sm/axiGihvBebDNZPNio4zN1V+N7VteD4SGuSFhkQHk1F0GheFqZWF9CmiPvfOBwbF4b
         0wFCw2MQFtxgJbnTufJUagetFQFvuf7tjzrdFTDA2oVwexkAonVLbQW9bkslWMxjW/ek
         Zgiw==
X-Gm-Message-State: ANhLgQ1rJdhKli6t02Zvm3KZUDre5JhlYpSstxmZJ3e44PZn5ciTkipZ
        LgmhivbSM8sX9aau0CybxYCJyQEFdKZuJtiuLgDT9RCshxp8XTYAojRlhAaPJJDJW3HSir/3AAU
        cv1xYb0LnF3QIUi5RbAGsM34KvPAhsU1sUuKZIsyouzHHtN7JSKtj2bp0hFle1DqTptJUHxP7mB
        U83qZago+4/WM=
X-Google-Smtp-Source: ADFU+vs0GhuXDUVv6YWGRJqAXVhE0/NQABMRsBt4BJgni9Ryhp2X+d23RQBCollDJkZ0ictwxQEdPyBEAqAAYGUsBw==
X-Received: by 2002:a63:257:: with SMTP id 84mr24751234pgc.304.1585020112687;
 Mon, 23 Mar 2020 20:21:52 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:21:45 +0800
Message-Id: <20200324112129.Bluez.v2.1.I6c78c0eb9826eb17c944c4903132ee75c1324136@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [Bluez PATCH v2] avdtp: Fix crashes in avdtp_abort
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In avdtp_abort, if setup->stream is NULL, trying to access
stream->lsep will crash.
---

Changes in v2:
- Remove variable 'sep'

 profiles/audio/avdtp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0e075f9ff..aabc5ce51 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3566,7 +3566,6 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct seid_req req;
 	int ret;
-	struct avdtp_local_sep *sep = stream->lsep;
 
 	if (!stream && session->discover) {
 		/* Don't call cb since it being aborted */
@@ -3581,7 +3580,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (stream->lsep->state == AVDTP_STATE_ABORTING)
 		return -EINVAL;
 
-	avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
+	avdtp_sep_set_state(session, stream->lsep, AVDTP_STATE_ABORTING);
 
 	if (session->req && stream == session->req->stream)
 		return cancel_request(session, ECANCELED);
-- 
2.25.1.696.g5e7596f4ac-goog

