Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39943C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123D02077D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OWr9gi0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE2PiU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2PiU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:38:20 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E2C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:38:19 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id k3so1753564vsg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIVyaPrMnLKXr8E5UBrkKsc/WrG5o+j+XVU0uMFBAPo=;
        b=OWr9gi0gCSJctQxQQQKdk/z2s7NyM0M91LYu3sdso/DAwP6MWpwqlQUmxnJoq5s7Mx
         PJ9qMnItTbqbTSV76UrYfJlYR/GWO6Jk1JNlGFbonBt81dzafkUnwPhmZjPsCAmnPgu7
         vvGBgzVrziQwExWbthUclXDYHuhju7u+QJEB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIVyaPrMnLKXr8E5UBrkKsc/WrG5o+j+XVU0uMFBAPo=;
        b=TUh2RIaXb6z23eicPW5lP49JEoaKELj1cwEeGkIpe6b5ZzOQ7dgGeGRoe4DXRIItbX
         6TdwSOlzFgbNAK6GOvyAyybxJPkqOCHXjrd8vatettFY8le6HCLFpXmkqN6w3vtfStSw
         oiOOt4LS5nLoMZZCa8MJBPjr0o/+W43O5n4e0CDLfVL92bTAdOxUGVMcENZ8dA1KWfve
         TAIjOaHKqtI9RwvoEZ8Gpb1zhmEg71htz2NCCBQGoiV3hlfqzuH1xptppkQuO+gzUqGf
         6NLLrhyQhudzFt6nwLoBXY5yVV03j4xJCOfYGgSoserqo9iFqkPn1QgGnwpYLixoIPOa
         T5zg==
X-Gm-Message-State: AOAM532mJ7davVWxMjEK8H4gH38RTkv+U6DCAkJusGFdAnT6nrg70c04
        ZC11E3ryi8dWvO0LV2FgBjDzhJKYbQU=
X-Google-Smtp-Source: ABdhPJzin7abxiOEehC0hTQ7Q4gdjQsIBu4wjD4sayV3q/YFGyvku64jC9hlvTdbBPuRP9rxzUdevA==
X-Received: by 2002:a67:6441:: with SMTP id y62mr6283940vsb.145.1590766698114;
        Fri, 29 May 2020 08:38:18 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id o2sm1309494vkl.27.2020.05.29.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:38:17 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH v3 0/4] Load default system configuration from file.
Date:   Fri, 29 May 2020 15:38:09 +0000
Message-Id: <20200529153814.213125-1-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series adds supports for reading default system configurations from
a configuration file.  This allows a system to override what are
currently kernel hardcoded values from a conf file.

The dependent kernel patch will be posted after some additional parsing
validation on the tlv is completed.

Changes in v3:
- Fixing const decoration warnings on options.

Changes in v2:
- Fixing checkpatch warning that are applicable.

Alain Michaud (4):
  mgmt:adding load default system configuration definitions
  adapter:set default system configuration if available
  main:read default system configuration from the conf file.
  fixing const decoration warnins on options.

 lib/mgmt.h    |  20 ++++
 src/adapter.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/hcid.h    |  39 ++++++++
 src/main.c    | 174 ++++++++++++++++++++++++++++++++--
 src/main.conf |  65 +++++++++++++
 5 files changed, 543 insertions(+), 6 deletions(-)

-- 
2.27.0.rc0.183.gde8f92d652-goog

