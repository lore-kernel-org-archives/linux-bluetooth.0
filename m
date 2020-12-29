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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5023CC433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Dec 2020 06:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BE121D1B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Dec 2020 06:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgL2Gfa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Dec 2020 01:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgL2Gf3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Dec 2020 01:35:29 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5FC0613D6
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 22:34:49 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id n8so4135352pfa.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 22:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=kZeYTPlj8uQqFyLvshCBQ8f93M1/eXFlqqM0NsH7FYY=;
        b=k07v8icFoz4Z7Ar0qQifUZdoIQ/nHjrkR9BEfSyqTdSInfJTihIyZp5hr2PFSz/B9d
         bNvblKntJmaP+U8VIGhHZLEFWOF89N5ssSJ158hRYVspV5tWkzJJIIno7vpNzPLSQxRc
         wZYTYqdD4KrtFDxO7gAuYZsr6S8OOSghGmmq06hfQNGJcj7vGuq2+/keoFWyf02my2z1
         AVi0xZ2AqQGuPPMYnqf3boBpvun2N4By+soe56F9jIMx4AF7NQo/Jo1TEkhD4FMqOywh
         kYFK8wBH4mj375rzYl0d/SaTBRIIlJzTeEi4ofa2/oSG7bmwC5IXmQYYb727UtfyzbFn
         kYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=kZeYTPlj8uQqFyLvshCBQ8f93M1/eXFlqqM0NsH7FYY=;
        b=uj0KEcm0TVqJtby9lwxNEzK9g+xWfmGUhiwsmPeZwGQlDstQzmAskpP+vSfkifE8lt
         1yQyM+LUMprP6v65qOWKqhTibp8NDmUqnDUanOa3DCVBi3BkINwI2zwVISQkwvV/m/YY
         sr+t0o8Neksc41gWVb0QiWz6O1PVahi6qPWR7RFA4y750d6P1jCFh0+Oxq1TP287o4G0
         Zd3gE1pqj9WE1yGarOM0apBeXUbAaYIc4D5ud9V9mn7mDiNyYCirZBqLpOCK2TbnoWSW
         EPRjUKTq3GSJa9Eb01wJK0SdMNbD1suqYoFlsisxITB8L3aGpHQDDgJ7L1xmgdRCLYyV
         RxtQ==
X-Gm-Message-State: AOAM530+b8bpUeyK3XqPsBkN96R35dlW974M9eR9k5h29u5O+tdAz5us
        FEaV2EBPWVeFgtUpO2oAF79aE/BU+qCfkzQX8m4LhX6OUkBquX5eBM2POHI8V4NgoXnwyuGtUC4
        RJrf/0TqYPUBw2H7S8tvIrfmBAvxSq/6CRQHJCCbEby5rPNp7T2MxkL/rQFPp1l9bJkPCCQAaaF
        Rt
X-Google-Smtp-Source: ABdhPJwB5jGMVqNi5Hb2vr5d4aXcO/O9YFEAL9WECQNg0UB1OLJBnwNgMxVfEIFUJ/RVIPXmcjJgGeSMKaeV
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a17:90a:8b94:: with SMTP id
 z20mr326271pjn.1.1609223688559; Mon, 28 Dec 2020 22:34:48 -0800 (PST)
Date:   Tue, 29 Dec 2020 14:34:38 +0800
Message-Id: <20201229143408.Bluez.v1.1.I7978a075910600058245dc6891c614cf4c7b004e@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v1] adapter: Don't remove device if adapter is powered off
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

If adapter is powered off when a device is being removed, there is a
possibility that the kernel couldn't clean the device's information,
for example the pairing information. This causes the kernel to
disagree with the user space about whether the device is paired.

Therefore, to avoid discrepancy we must not proceed to remove the
device within the user space as well.

Reviewed-by: Daniel Winkler <danielwinkler@google.com>
---

 src/adapter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index ec6a6a64c5..a2abc46706 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1238,6 +1238,14 @@ void btd_adapter_remove_device(struct btd_adapter *adapter,
 {
 	GList *l;
 
+	/* Test if adapter is or will be powered off.
+	 * This is to prevent removing the device information only on user
+	 * space, but failing to do so on the kernel.
+	 */
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED) ||
+			(adapter->pending_settings & MGMT_SETTING_POWERED))
+		return;
+
 	adapter->connect_list = g_slist_remove(adapter->connect_list, dev);
 
 	adapter->devices = g_slist_remove(adapter->devices, dev);
-- 
2.29.2.729.g45daf8777d-goog

