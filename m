Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0669C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6207520707
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naNt3icr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFPAD1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFPAD0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 20:03:26 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDADC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:23 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 140so15524267qko.23
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bvv70ySE2kGaWTe3hi2XH2e2escaSetwJoff/dLUEkY=;
        b=naNt3icrQQV3V8h4cS6mFVqYzmchdRXR67BAKSnJSON8Y/ThhkNngwKMMjRcV3/E3h
         yFYxk+gzGPhr+sAhNDZK8qM8g0usFeom+HMEs7CfT9OnLE27hA7rJ7j6iqrMKNPSKpZm
         8PBeHTeq4R2wBHa+sGjiflCxxnZModh7B49hnkdy+teiSSmRiaPGHYovx3QO0gWillAw
         e82YJzEtEx3HZ6tWWCdepgwqx+/a8d7VfNJPdGu4pDuaO3Ye6FVTlzcOZ4EVjCufWxRM
         K7zYbG/G4Pel751yrn0ZidBofiMdrJ6RZKMxhjrK4YR2FAx+F13dRfLJFucyE1l01nM+
         xfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=Bvv70ySE2kGaWTe3hi2XH2e2escaSetwJoff/dLUEkY=;
        b=bYveXIEebQxvwyxOHCMLc2DStWKk9oA+MxQpodFn0ACfHjc8WL23HYlLUwcKdgYPod
         8z5vf2gLjYJ87RkBM94EqeOMDIely0xIr/4FY5OMhcouozqBN7lakqzMi4yHpB2+owSv
         VivwNd/efco8mkUPRZ/iLoRveUHxnBXsUFjzwJx1MmZFCoh5ddFtmXU1yUYDTTPMIMVB
         f6RiOeOotoJUk6n6OI7qpooPJjDvp9IZmZmX5kGLRa/hI2xy/4CFEaoc0tYl4F7dm5e+
         4kDbGqMhcXYMeR38sV6efetORyB540syXCUP+bb+XciI/tHJMFrrQkQuRMKGL0uy+Yje
         ajvg==
X-Gm-Message-State: AOAM533MoCV8AL/weeNPjjl/0Z9DxoiJqX+uwNPNff2efcgZBTAquEIo
        pRSGyPV6jxQ85JoApUqEtZqQEDoV6UCKqt97zlJDcJWuA9p1l2ZMRecpAvW1ov3c+PfVojICgEg
        l2Olfnbe+lxicSg7WMoSO4tt/KyY72zvYv6oRyDIl6elaMZ9WbYQhSNztLKI/uuusuItUXFzvwO
        qguQY0fgVOQ6E=
X-Google-Smtp-Source: ABdhPJwvWds9q8ASgikgEafyYhc1zMJQb7cUBmeUmMrecc00dgLHkCvkh/DkJdtAWK1lxYKz4zFOQoUdQ+4E+V0S2A==
X-Received: by 2002:a05:6214:b33:: with SMTP id w19mr260605qvj.7.1592265802732;
 Mon, 15 Jun 2020 17:03:22 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:03:15 -0700
Message-Id: <20200616000318.42664-1-michaelfsun@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [bluez PATCH v1 0/3] Add new commands in btmgmt to support adv monitor
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com,
        chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        alainm@chromium.org, Michael Sun <michaelfsun@google.com>
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


Michael Sun (3):
  btmgmt: Add btmgmt command advmon-features
  btmgmt: Add btmgmt command advmon-remove
  btmgmt: Add btmgmt command advmon-add

 tools/btmgmt.c | 294 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 294 insertions(+)

--=20
2.27.0.290.gba653c62da-goog

