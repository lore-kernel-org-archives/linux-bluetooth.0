Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CD3C4332D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E20664EF4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353520AbhCDAeE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244594AbhCCTV1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 14:21:27 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B304C061762
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Mar 2021 11:20:29 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id o8so20977679qkl.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Mar 2021 11:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iOlfJEi5k3wqYXNF7r3Ckooff1wV0NURjlQcBH/Ykzw=;
        b=J5GifKajtDsQN5Cqs499jOKp5bqzN0irXospmXUbGtI/fJzYBA8ljJfBO7JRv/uCmR
         Sif0UYrw0UlLco/ywjKE3a4ujZxN/PeLCuCtvlMn6OcvIHj1UMiXt8nPhhQk96qctUed
         tTx2wIWWhfcwCXT0TDZk8cw+95jXsoHrd8jvUzM+QFv6gI3CEsSH1hZoykQsPMiOxW2y
         2HHYEV0JsslpfWivPIunCcjhR1ReciQWJVlVWBI9Sebu+GUdKVAm5YPYm7425EOfwBbX
         svSGIkUSed7wPBkVk5obbszFyp7TpspTdCqjy+q1EBCHsgR/IzE9Zvpb0tu8vD7FGHaU
         BKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iOlfJEi5k3wqYXNF7r3Ckooff1wV0NURjlQcBH/Ykzw=;
        b=ZQLWbcs0OhaUjDsCOaPYmD5IDt15pFVIOO1XQ7E4tEBuJofRh8+SpGJhNEp53yZEuz
         lQPc91HkJGZVRw5+ZLIcxTFDWcrg16BKoN/YWWzcfQImKt8ZGruMLUWTsnmfYqbK+S6J
         9WT6A4Y6F6V/FHZu6uLRg8+X1nTDP8rCI8euQaBQbWEZfATxijyGPdtnP+1TKOQ+oRbf
         4jZPM0NMXTbOGYF/lBmAQqO9FZDSa7bjFdY6hDf4L3QuaUgVpUIsSu3rabQOPozTwUDF
         ZtCS/aKtzA0FKQVZ2erCBKNRCG7nMS01I7dZVEX+Rj43jhrrTziIu1fqRCwpkfQizkYD
         g9Eg==
X-Gm-Message-State: AOAM533glX8Yf/nbhRC02wCEe/aDwpYvPB+5jpZZ93A236shJ++U6E8V
        M6Da1p0Z1lIZuLEGHfXPqYHI+UmarowBFMQ3Cx2rl6t2oHiwnYJFjDXT6yvTENL942pynzsbMcI
        l8vpVEGHnY1BbR3wivwUu0YvMPtTKUFwXZ1mcIBvCvOlMDAjfMix4tpFEm9GyGv/Z/U6wRk/2B0
        04Q+Afj9mpSWi153Pr
X-Google-Smtp-Source: ABdhPJwuUiPVtWSwTXxmAFAkQ4OAD/0pt75IS9hDFxdxqJkQCBJS2ikCBW8dV5lbxfn+P+BxG5zQ40aNUYg6KSX+a0Hj
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:45cc:69de:aba1:a948])
 (user=danielwinkler job=sendgmr) by 2002:a0c:e788:: with SMTP id
 x8mr736299qvn.48.1614799228305; Wed, 03 Mar 2021 11:20:28 -0800 (PST)
Date:   Wed,  3 Mar 2021 11:20:11 -0800
In-Reply-To: <20210303192012.1695032-1-danielwinkler@google.com>
Message-Id: <20210303111817.Bluez.3.I87c7524ba1da470e9ff6ebdf9eef9ef715a9616d@changeid>
Mime-Version: 1.0
References: <20210303192012.1695032-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH 3/3] doc/mgmt-api: Update documentation for scan_rsp
 param flag
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the new scannable flag to the Add Extended Advertising
Parameters MGMT API documentation.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

 doc/mgmt-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1736ef009..cab1fffc5 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3632,6 +3632,7 @@ Add Extended Advertising Parameters Command
 		13	The Timeout parameter should be used
 		14	The Interval parameters should be used
 		15	The Tx Power parameter should be used
+		16	The advertisement will contain a scan response
 
 	When the connectable flag is set, then the controller will use
 	undirected connectable advertising. The value of the connectable
@@ -3708,6 +3709,10 @@ Add Extended Advertising Parameters Command
 	chosen by the controller. If the requested Tx Power is outside
 	the valid range, the registration will fail.
 
+	When flag bit 16 is enabled, it indicates that the subsequent request
+	to set advertising data will contain a scan response, and that the
+	parameters should set a PDU type that is scannable.
+
 	Re-adding an already existing instance (i.e. issuing the Add Extended
 	Advertising Parameters command with an Instance identifier of an
 	existing instance) will update that instance's configuration. In this
-- 
2.30.1.766.gb4fecdf3b7-goog

