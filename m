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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9725C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBE564F6B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhCDUZ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhCDUZq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 15:25:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF73BC061761
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 12:25:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u1so31915730ybu.14
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 12:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1PoslpW4l0xkZy0dHIQi6TTICf9LKwPQujXAUBIUG7I=;
        b=Q9h+JO4O6P1pviiq5rZy14T3Q6xmdGcexjPsKT+L13jWDx2D9EA3ifGLWv2J35zWn8
         xasliXWfDnCoAm5UxOHdEVYj9iRjaq+hK/bt/+FKoalRUyg9t4CVvpDQoGIoKP9yQQoo
         eb2FY2MVoWZnH3u9+e3Q5V1ZbWm+VvwyP5nmf5CEs9BoglsvkCDuMNYO/Dz1w4RnCJui
         RFpn5Tqp8vxisGmi1tXxLHP6cdkLZ61XzwCIf+a8G6Zh+OPOr0NCjtkb6XnC5AX6K7ZP
         cV/ycypW+F/5RHUaG7aYK7kB1/0lLZrNELIG3N6sDiByrT/TsqpS9WWZtJnAYz8gtH4m
         TXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1PoslpW4l0xkZy0dHIQi6TTICf9LKwPQujXAUBIUG7I=;
        b=k/gX5BgsjSVQuebfHgiaybd6QBfRXvnUu0IjZYt7Tb9ve/aV3MzZSZLM06ajwqbeZY
         cnaT3wqL7VS4ZbdiLxnXQxTuQmlwAe20FxSh+ACeQKZC1Rdny1806tcR90vrePEQDXpg
         4aSNFDtu6k8I5XTN1mJT4KbviMXaJoCVSR4+v1omK2Jkqkv9R5ZDROBhrlRncuEbehKd
         ljdZkFsJMPt/z3n46xJqADgSj6AWvlMSPEdQtwnlR4cKMwfx4rCAi4LonziVjZ1wX0XE
         bo6z5CcmAkQ+iFqMz8DSlCbVozd+CxMOLl+UoB2gPxFuYuquKsT7Q67AOdrhrf6Jrilt
         ULWA==
X-Gm-Message-State: AOAM5334pAREN+Z/uiibqnfpNIdlINBtul6qkl7vYZ3DF5BJ1g0Sb045
        58iHtFA30PMshbki8ypzJmQ9/4C60zTaTfCZoCNzFvWZ2kqbesx7MlgkLPWP3ALsw35CEhYGmiu
        9EohFTLo7qkymunr9B3OeIDmd2uRsTB7EF2ayF/FRZVZkWfKxTiUXkUyC94mnlXAA+co3ZbJSLo
        FTJo+KOufp58zGJRf/
X-Google-Smtp-Source: ABdhPJwFAem1+XgYuvZIppypCtxcUdFMxJRaxoSh20ipfhqzZskBi8GChVmFX2eoH6sR5vvuEt6x0c8XkE7j2FS92el8
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:a873:4408:c731:b8f2])
 (user=danielwinkler job=sendgmr) by 2002:a25:6952:: with SMTP id
 e79mr8730307ybc.142.1614889504958; Thu, 04 Mar 2021 12:25:04 -0800 (PST)
Date:   Thu,  4 Mar 2021 12:24:52 -0800
In-Reply-To: <20210304202452.1998022-1-danielwinkler@google.com>
Message-Id: <20210304122005.Bluez.v2.3.I87c7524ba1da470e9ff6ebdf9eef9ef715a9616d@changeid>
Mime-Version: 1.0
References: <20210304202452.1998022-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v2 3/3] doc/mgmt-api: Update documentation for scan_rsp
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

Changes in v2: None

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

