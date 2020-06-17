Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD1AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982B7208D5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwQ3g4dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgFQG0v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQG0u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 02:26:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD5C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so1371304yby.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Qyil4q/UzGjpvUQiduvVBBTtHYLFbl04WZMRl4NcETw=;
        b=QwQ3g4dk/G0CqRQ8ycbhgIS3+PWROeMahJJP7ET9mtwdCZGnFYfFwVdQoRyww4cyRG
         hlQfBA4xt6R4xjyrOUvd7pIFH53lMJlY3VxJDMDRfqrPQSoeV2WUuAIiSwyCJYnSbGyZ
         lB1S4pV9l83VKPbV1ja6ybiLj7icd+GpxyVJTlWdCx6tcqVA0NWc0Mvh2FPkAcf/blFd
         /VWEnYTqYYI+oLBsvzdC51/H1bJuq/9pUBXDTQT6uGqdubNVOhcYnT3C7QrQAGM6MZ6f
         dJwS5/2muINlRO8iMSMvN2D+OR7s6bJk3mezBgpaMGqodQHAkCCHUPWSv9d02o6ALR27
         H7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Qyil4q/UzGjpvUQiduvVBBTtHYLFbl04WZMRl4NcETw=;
        b=XFMyjhKEESd/Gpp2LMp20X7lh+R5BUQE6QfNxT/tCdlyFtZJDxZ1juTp2E92kKzP35
         5uvV26Dnegz1t39qhar+ey8Vh1/j7Xf9rTTBv1ixs2WqiSuO2dLLoDSbJ/iXSfUnRMwl
         08SnLO71zcfgo1kKmS1KNKeHHXDYswgfRZmcL6xSrOQsOKAyVRJ3MOHFdRuxN2AtCzK4
         jc2x+EG8heIeZVVPrT6IfYa3UBrfS5NJt0ET8ZSeL5yiCi4XCYfLc5MsxosOC879avcV
         DfKcNnM++dxvfnQEjwx9megmBuCKjQp1YiUm5HUwYW8Y6mu7RcpQ10gDd+ahQsdrHez5
         Acpg==
X-Gm-Message-State: AOAM530AwkoK1V3NiCG/IRI76YKh9BGZ6XJHP3fNsjvSxsJhzNYo2FCY
        PGXibsdymcQzGB3Tu+1B5+rdgy1jS2c8sFreLFNJcEm3HJ9uKg/IMZxjjzdJty6meNSYRwS/4rG
        eEWrrue8mBUuXYx1h3wjj9jt/rZXPatSfR+CquKK2ychWWymB4UgF3NKf57ltdfUGWEMgIPzVHe
        Op/c8HTIqlFpw=
X-Google-Smtp-Source: ABdhPJyhB3mTjVr6+t+x/NG+HdZneUbgP7wNj6sPTifZUChNfWPdddG3X/g882W2EML8dP8U7MUPCnB6ZgQKf2j71A==
X-Received: by 2002:a25:ab12:: with SMTP id u18mr9558253ybi.142.1592375209493;
 Tue, 16 Jun 2020 23:26:49 -0700 (PDT)
Date:   Tue, 16 Jun 2020 23:26:43 -0700
Message-Id: <20200617062646.165307-1-michaelfsun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v2 0/3] Add new commands in btmgmt to support adv monitor
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, mcchou@chromium.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        luiz.von.dentz@intel.com, Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-bluetooth,

This series of patches add support for new advertisement monitor mgmt
opcodes by introducing new btmgmt commands. The new commands are
=E2=80=98advmon-features=E2=80=99, =E2=80=98advmon-add=E2=80=99, and =E2=80=
=98advmon-remove=E2=80=99. They provide the
ability for users to query supported advertisement monitoring features
and add/remove monitor filters through btmgmt console.

Changes in v2:
- Move advertisement monitor commands into monitor submenu.
- Fixing build warnings.

Michael Sun (3):
  btmgmt: Add "monitor" btmgmt submenu and command "features"
  btmgmt: Add command "remove" into "monitor" btmgmt submenu
  btmgmt: Add command "add" into "monitor" btmgmt submenu

 tools/btmgmt.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)

--=20
2.27.0.290.gba653c62da-goog

