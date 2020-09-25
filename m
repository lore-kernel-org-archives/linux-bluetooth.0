Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7364FC4346E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A82B20791
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4DlHLXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIYBOP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgIYBOP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:14:15 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2090CC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:14 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l5so698147qtu.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3Gdq9VuigZfds+CT9PEgYHOOo5l2gIAoVL+igARcbG4=;
        b=C4DlHLXefB7nw25fHcVr58hgQSK0/0oFuFRjEEdYf8/sBNgdObOyxalPWuEWO9xUlP
         oiNtBaEttqVEAMLTxr2pybgpYTRExMzsOxl4aPKueZeG8vC1F51A+ck8htMkqhJns6Ja
         QtAi97dwx6ORyzseRulNl6nZ6jeFGgm9gN8qRdq72Bn00enfXz8cM2Mnf6sqtdhI68lu
         hKIVZZS9TihPjHBCQX4rbhxbhOYNqHXsuMEIrxouPVYHX6x1QHkmKAnMKEdcraSss0EY
         zWQivi1rA6kyESsCRdLskWmujojI4ep3MeWPxwhrlDJYi5/RMQsEqkTkvx+C6GTlBJbG
         n51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3Gdq9VuigZfds+CT9PEgYHOOo5l2gIAoVL+igARcbG4=;
        b=tcmLhaz+Cw5Nk86enTXYS+vy8mNBOnwjVJFuIvgbIXHQGGlzcUFXLOoObpp0rE4MEh
         fYiU8TJAIavMfRuUD2iAeZXHxu9Ju5MbcvyW5Z4QsB/zwu3bY3PWNA3y+am1zdQLuBU1
         9XZsABUIWwivBIqkhrxlShUhX41Pko8htALzhoULn25aTgJm1RsNuexiZuI3TIiPuoAp
         U/ba2U/09G02HMHxxqmzks02RTi/+ZhuadCR7FDeWHO3nf+BAZf2bYt39VMy0FPcYIqy
         PALqE27p1o1eTQw3SugOaCK6SHbFGoX2zjcCQB2sKqsFPTnj1ZfOLpBnUMBDqbS4iEwu
         wCFA==
X-Gm-Message-State: AOAM531WXfkHASxdXyvlmltam/myt1Q7rHCHHXYSDw96J/3ON5kjgKUp
        Nb8gSGNF6s5EYQnkn0Z94lIG3/mgD2+IdneVHjIo
X-Google-Smtp-Source: ABdhPJxdv5HyA17Yd69MmNhCqMYDmuNNSnaVXu9fDchyBvVJvqnAwHsDWZOASNOfsrHXc6PuauvnysAk6GvRsZ8etp6g
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a05:6214:d6b:: with SMTP id
 11mr2197744qvs.30.1600996453278; Thu, 24 Sep 2020 18:14:13 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:46 -0700
In-Reply-To: <20200925011347.2478464-1-danielwinkler@google.com>
Message-Id: <20200924180838.Bluez.v3.8.Ic9eec7749b769aa5bf73a0d8e9a31be83f232f1c@changeid>
Mime-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 8/9] client: Add SupportedCapabilities to bluetoothctl
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the new "SupportedCapabilities" property to the
bluetoothctl "show" view.

The change is tested by verifying bluetoothctl shows the desired
properties.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3: None
Changes in v2: None

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 2b0243308..cb8ef54ad 100644
--- a/client/main.c
+++ b/client/main.c
@@ -954,6 +954,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedInstances");
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
+		print_property(adapter->ad_proxy, "SupportedCapabilities");
 	}
 
 	if (adapter->adv_monitor_proxy) {
-- 
2.28.0.709.gb0816b6eb0-goog

