Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE2AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 11:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3108860FD7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Sep 2021 11:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhI0MAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhI0MAF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Sep 2021 08:00:05 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60255C061714
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 04:58:27 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id i16-20020a05620a249000b004558dcb5663so66500052qkn.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Sep 2021 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FHQuGPAsx7HYP87vGVnx/78AZl3+QiedtSpkbOjt7EQ=;
        b=PQ4wLEoHwibbQljKZZiGlG0QC+UQZ0CprAOKwd9fPGtN4DGicTZ+rV6TcK1FpX3B0r
         dSW4x/IRQBcxSHKTlFm0edXdUh4XHcwxEu2l/+vzYtdaeQeQp18tGGGNjmG/drcRaq1L
         lCU2NPYODwZkL/wtwQEPKbOhaL1rh0dwPIdophSYaLznP/0CNNXF+DFLffslQPwPWeD0
         Y4uFtw5VeD2YFPiLADaxQjd1Ox8uhjgj9crlLO5aul80Y9FdHATm41JEzAarFEpg7akL
         o6NAZtj+eD4CXXAB0CIf5BtovcNHAVjNhoeGlKR5yXibVTWx01pjTwALi/B4btMuJA65
         3SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FHQuGPAsx7HYP87vGVnx/78AZl3+QiedtSpkbOjt7EQ=;
        b=WQXe+6oDvRiiQVtB9qheJCPWO5hhHpqoX8gqqRIY9a0yjC0AC49b+vWAfFUhsGO/T6
         pFBTvlSFs0M4zjCSH0vWAFRP2EdJAysWEAo+/jMs79mFFcmzim1QBa36jM1DxdmWWaOa
         l9qaPuShJ6QWvv6gFt9mMlKsgRAKA8ey2fw7okXV9db8SSSx6v4sDzC45bFloixZXgbe
         pgTUnuvR0/FkBgNtDP88d9NIAipY2gjclEl5EMTq6ko6LvIZLIZy+EHAVWD/uGzX1rF1
         uyXhpW/o83U6ee2heTtUFtVAwq20sD05SYzaQqP4vy0K25AR127hje0rkfHiZmiluhvp
         cd5g==
X-Gm-Message-State: AOAM530MOzR6paHWOHzFsHrjGv62SLXwquQ2KlvBVQp+ONq607kF0a5+
        0DGmrNZ04TEorbTFfa50bsXmcHArZyu9U8y/I6EOGMcIfF8d0fkKgfHA/SYV1FLrTmfZFg1OXOr
        K+hM/6rysePaTat/EyIePBu4iqhgPjXMlbAuSjD7j+R9mWxj0cd+UOpHQ1kXU0Iqg2J7/ALrMBx
        Uo/DY/ikJyNRA=
X-Google-Smtp-Source: ABdhPJwxxL0oGSpJvwRblD9qlcbwwPQ+tDtlTTHiKbr8IQ3TpLAjYHO/AVzFhLwGY9EBaegrTxetCJayRzvfWAQQsA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9751:55fe:4e2:1c04])
 (user=howardchung job=sendgmr) by 2002:ad4:4989:: with SMTP id
 t9mr22237qvx.29.1632743906497; Mon, 27 Sep 2021 04:58:26 -0700 (PDT)
Date:   Mon, 27 Sep 2021 19:58:01 +0800
Message-Id: <20210927195737.v1.1.Id56e280fc8cac32561e3ea49df34308d26d559c9@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v1] Bluetooth: Fix wrong opcode when LL privacy enabled
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

The returned opcode of command status of remove_adv is
wrong when LL privacy is enabled.

Signed-off-by: Yun-Hao Chung <howardchung@chromium.org>
---
Test with following steps:
1. btmgmt --index 0
2. [btmgmt] power off; [btmgmt] exp-privacy on; [btmgmt] power on
3. [btmgmt] rm-adv 1
4. Check if the 'Not supported' message is present in terminal

 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cea01e275f1ea..87acf0d783a07 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8222,7 +8222,7 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
 	 * advertising.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_ENABLE_LL_PRIVACY))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
 				       MGMT_STATUS_NOT_SUPPORTED);
 
 	hci_dev_lock(hdev);
-- 
2.33.0.685.g46640cef36-goog

