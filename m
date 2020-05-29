Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218EDC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A08207BC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 14:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lBhEchyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgE2OuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2OuM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 10:50:12 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F0C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 07:50:12 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id d8so865372uam.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COVUHSxTCMj2isyY9J+v1mwEZIAcu4F6fY+gjyNQtIA=;
        b=lBhEchyZ/Q+vBamZ8g8B1Ns1tcncpcr7wwFG8Sa9MfKrvob9qneczS4Hf2PwBZng6R
         OmBAB8BeXjiRd08pQY+50fyteHeI1hNVir0Im31sNws/a3Wnlaox5JX9ZMl4rtcCWkJh
         UKpHuoSWT/thgKAagSTVcWBcpBlIm1RXW9Qzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COVUHSxTCMj2isyY9J+v1mwEZIAcu4F6fY+gjyNQtIA=;
        b=LAtXFmrnNHDGq0cXKrjOUi8dzo3dAvAJzsqUFN+nsnva5XLfIvvuJsBo/qz13G9A1r
         6bLcUX9gkF2LZWciF/k6R7DOzvzq0BgxSTImGa3qj5MMq+FljwyN81cCmWWvtclFz0Ao
         rbmJPb+uCMfKXntlYl8BhlnqcVRevPld6C+Q+N/WVD+SpcxrEq9zq6Kg4USOfYAVkIj0
         HocMlRp5HlKT8pAvLofXReqziyi0wAJrsk7Uio8qTT9VjdpMFreBir1OPq0BRykTlw4q
         ZPpBtggMGf39Af1c055C7FwrwCjOTEMTmaW+bj4J5+UloUl/iQVBEyljhbrbkQuGjDf1
         KLJA==
X-Gm-Message-State: AOAM533zsSkXBbjKlvCFqZIGWQWhStZAVh0uHgzDHeMNSd/Jw6rzmiU4
        WTcjboJu0Kt/ID85wCF3qe6myXCVy0U=
X-Google-Smtp-Source: ABdhPJxuEseucJQAptA+FOj62Sg4NbUXcPGjT05iwLFnOlx8nbf4cM/f/dFaeREScUqnZXlsh3ZBpg==
X-Received: by 2002:ab0:6642:: with SMTP id b2mr6137692uaq.92.1590763811490;
        Fri, 29 May 2020 07:50:11 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id c65sm1196998vkh.32.2020.05.29.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 07:50:10 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH 0/3] Load default system configuration from file.
Date:   Fri, 29 May 2020 14:50:04 +0000
Message-Id: <20200529145007.198906-1-alainm@chromium.org>
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


Alain Michaud (3):
  mgmt:adding load default system configuration definitions
  adapter:set default system configuration if available
  main:read default system configuration from the conf file.

 lib/mgmt.h    |  20 ++++
 src/adapter.c | 251 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/hcid.h    |  39 ++++++++
 src/main.c    | 162 ++++++++++++++++++++++++++++++++
 src/main.conf |  65 +++++++++++++
 5 files changed, 537 insertions(+)

-- 
2.27.0.rc0.183.gde8f92d652-goog

