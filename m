Return-Path: <SRS0=pby4=AY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2ACC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E772065F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jul 2020 06:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mniONp8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgGMGS1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGS1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jul 2020 02:18:27 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878BBC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:27 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m22so5585411pgv.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jul 2020 23:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lSPwcC2DR49/2//P8zU4LAtRpkobwSTOzg0X78esOCI=;
        b=mniONp8yZbx4LITqr9V3yBGfDgQX26QyIhgcZzrx25zC1gpUB8sxP+pQgDaBlr7W/t
         smjErQXwCpFEoniH/5Ab8scCETmz8YbMVWpwjcgCCee4pnSEqQsa8f9ZlCEDQnyQBG6V
         m65xm9ik+t0v4cO9x5sIjfvRNyXYT0rY72b1KkudZiOK/a5FNwpVVecVtEWgwQii5wDs
         g3nct6gGK1z2vtsqoL2EP9bGybOpbMZASCwDECZzuBS6SSxkaxq+Jyv/oQreNb+FpeBZ
         oVKpI4DJvjhfja4ODiN1q4IcNQSghSp9GTBwzmTnBZEdhtqaCwKyDyF5CAZ40fneF7FN
         RRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lSPwcC2DR49/2//P8zU4LAtRpkobwSTOzg0X78esOCI=;
        b=BTC+f+TXGYzQ1GeIBtDr20rklEOXT30qXDP5ZIBfzVpcasDSCxyWibJ9+ShTW0i2Ju
         L06Jrf5K2tM18F632DHhZ5ZYRIYFeBt6uSzHFNcCGjw371/zRQHcJpMAVTL0STkxGVHh
         RNSg/hZflk6533yraaSKDKl4tPD80c3X+xvE2tQtzN+fHyjXsuyTttHb1KrTBipStcRR
         0u5bZOB73tYw4dbdI6kBYcWxBW9sqpt/qfg2YjbrGu0JdXrWZZokRrwvvOpCj3AFzdhM
         ds0tFwlYBr42YBCmouo7OJDT0xuwi5THZ9HgBagISMh/RC9sr9f9clnvj4mUquB4JkmL
         z8yA==
X-Gm-Message-State: AOAM5327VjnGR4uIK6tcIPml0SdPbPJcrj3PdnVvVVMtG/1US/q0AqFS
        eAm8dCdaama6vl/c7zSdPxax3ANwly1BWQ==
X-Google-Smtp-Source: ABdhPJxbGOrzD4wzLJHfLQ1sD04msuAiIZuypAPQfHnp68ikFUiaLz2l3tZeLXssBylLBqzj1BX/Nw==
X-Received: by 2002:aa7:871a:: with SMTP id b26mr66248001pfo.294.1594621106690;
        Sun, 12 Jul 2020 23:18:26 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id 204sm13096371pfx.3.2020.07.12.23.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 23:18:26 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v4 0/8] LL Privacy Support
Date:   Mon, 13 Jul 2020 11:52:05 +0530
Message-Id: <20200713062213.3692-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

V4: patches are rebased
Added support to use set Experimental feature to enable controller
address resolution

Marcel Holtmann (3):
  Bluetooth: Translate additional address type correctly
  Bluetooth: Configure controller address resolution if available
  Bluetooth: Update resolving list when updating whitelist

Sathish Narasimman (5):
  Bluetooth: Translate additional address type during le_conn
  Bluetooth: Let controller creates RPA during le create conn
  Bluetooth: Enable/Disable address resolution during le create conn
  Bluetooth: Enable RPA Timeout
  Bluetooth: Enable controller RPA resolution using Experimental feature

 include/net/bluetooth/hci.h      |   9 ++-
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_conn.c         |   7 +-
 net/bluetooth/hci_core.c         |  17 +++++
 net/bluetooth/hci_event.c        |  21 ++++++
 net/bluetooth/hci_request.c      | 120 ++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.h      |   3 +-
 net/bluetooth/mgmt.c             |  54 +++++++++++++-
 8 files changed, 213 insertions(+), 21 deletions(-)

-- 
2.17.1

