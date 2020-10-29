Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6090CC4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011AC20838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s68fTeMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgJ2VYF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VYF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:24:05 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE71C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:24:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a184so4088367ybg.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qKOSAfxbo2WQ7eoCYPvc65pmopU6F6CL3Vl9PMf/9bg=;
        b=s68fTeMaWjls9cuyb2O73+E6i0w+Dx3Fh0grXjFRDPEIQrcI1xYcT0xF6RNV37j0iz
         X9ISzQH6KBzA7/0SZvlQa/2eRhGXtGLmMoSyNnL244Z0pvjZMzYOPjB1y07d5GBi/yzj
         n1lCu6PeFljn6xUVQjW7emKgDBzHIJvqcff5XwNvOfJT61e/+JxwY+dG8QDY014pn/4R
         6ieVI03c5LcT10YMmvJtzAzISbK1VHHgtuspqTkJrt9Ijfvs2YbF71uOZZCqTaacnGco
         chLbfxhdMwA5Pe8FXliOydphJHIFXIXUOK+SEQugoDpT0D0MkaV8Z96Pel2/ZC91EGY7
         Fjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qKOSAfxbo2WQ7eoCYPvc65pmopU6F6CL3Vl9PMf/9bg=;
        b=Vlfkq3Zg5Oqz6bUHb3+mAav0uMwqM6w01yg6G/8Iiesaxt+cOXLMwFewgQtEoqlT15
         LFCTRLTPcPGLbKN3A12ap31bRxzEMU29WoHCF+HqeKu++wLy7TUBXpn9PY+xq9PWlgEK
         fEPT/nOM0NPkZ4TdWcuqU7rHcUb5VvgOTl/bbNkz9IeUh0ZEC0bTKGZS1aWrD78684a3
         7DGb3USVWjn0qN3/PBbXdqYHM7C809ueVMCwnVf/7iv2FQJnXis1F4n9ZuqUpWl1P8Ty
         MMHKhyXljQg8P2C0Fx452a0Ioz4NZLbEmfezIkj8uQQXoQeECBPS0eAuYz41eivSvm+R
         7oFw==
X-Gm-Message-State: AOAM533nZ8qxW9zYapw1gPuYqThqhodaxY9wnUTBMjyYCcBns07k3lPW
        WKTvIn9eBIrUck8AHiSE8XIatdjZdyq83HRs35n/
X-Google-Smtp-Source: ABdhPJxzqbCSMXhotdsqw1DTmPWVdadxvszxewDwkXaPUvhv0nBL/3SD1OSimOfhShSMhnP/zL+T0JtDlFCjTyuzY2Ms
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:7306:: with SMTP id
 o6mr7942824ybc.310.1604006642966; Thu, 29 Oct 2020 14:24:02 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:34 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.9.Ic9eec7749b769aa5bf73a0d8e9a31be83f232f1c@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 09/10] client: Add SupportedCapabilities to bluetoothctl
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

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 60f1eb86e..9403f1af6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -941,6 +941,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedInstances");
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
+		print_property(adapter->ad_proxy, "SupportedCapabilities");
 	}
 
 	if (adapter->adv_monitor_proxy) {
-- 
2.29.1.341.ge80a0c044ae-goog

