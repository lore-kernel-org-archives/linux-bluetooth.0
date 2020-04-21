Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFBCC54FC9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C72206F4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F1gxhzRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgDUQAC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUQAB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 12:00:01 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A40C061A10
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:01 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id f7so1592194vkl.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyZeOTMo909iIDtiGgY+4UXtaFuUURwpMbiiJCWdJro=;
        b=F1gxhzRSqm2Th/Q1AGHftHDEIerGftzaOf4t9oVpwnwfhq/ksZsNPAMbZ1fnX4KmyR
         QsR8GQACVvaZwU4TbGwiMD9cMjLuao+QDabyru8D4dssOAy4wdsNyG0HAroovR0KDbsB
         K40nmqALKz2hGA+SXithwiKBuu39DwdSf1LQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyZeOTMo909iIDtiGgY+4UXtaFuUURwpMbiiJCWdJro=;
        b=V0PkPwwvFGgdPPqs84d3CHnjD/AcFRwrPftBdreGqeu7H6wv6WOXwL63TRdXw6buHc
         8pyihu5ve1VLGaZ5sycbuGwDf/9t5y5dYEZ4ESKEXK5ex8wZ4JO9PPwMyhY8NCq2oxjB
         TaCxCrrUiHfrJbFAUuk5Y9L2dzqyKuuXvU1Lp+6a24F160akbrdkbpvoLtnEAGh8Zjfi
         FIc6H/POA5k9M4JQoNfFAk8oaeoUnZb6SSPhv4lkQ2OAUL8a4FgLVgjmJjXWZXjCPOyC
         RIrxJHd8HK/56cDhFthCkXvE7eoeXSSr6KlWgHpWFmn0f+zbjb1thefN9FvsVugmRKfv
         wrmA==
X-Gm-Message-State: AGi0PubLYtMRKEUu6LHZPfHi8OgMwIoFRURbcj80rlSu9n9ABaDxq1XJ
        e+p6jwEAM8qDEG0Q+dF6rm4dQe5uNyA=
X-Google-Smtp-Source: APiQypLV/5ovYD3vmxvxwKeCHftGs8jj0mvScA4Z3P8n3qcBrylHgAMH0y7CFs1Jl759IbaC70Tk9w==
X-Received: by 2002:a1f:9645:: with SMTP id y66mr12898846vkd.40.1587484800553;
        Tue, 21 Apr 2020 09:00:00 -0700 (PDT)
Received: from alain.c.googlers.com.com (161.138.243.35.bc.googleusercontent.com. [35.243.138.161])
        by smtp.gmail.com with ESMTPSA id h16sm840074vkc.44.2020.04.21.08.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:59:59 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [PATCH v3 0/3] bluetooth:Adding driver and quirk defs for multi-role LE
Date:   Tue, 21 Apr 2020 15:59:51 +0000
Message-Id: <20200421155954.137391-1-alainm@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series adds BTUSB and quirk support for the driver to confirm that
the reported LE_states can be trusted.  The quirk will be used to
gradually roll out the feature to supported controllers without
affecting the stability of other controllers.  If all controllers FWs
are fixed or else validated, we can consider removing the quirk over
time.

Alain Michaud (3):
  bluetooth:Adding driver and quirk defs for multi-role LE
  bluetooth:allow scatternet connections if supported.
  bluetooth:btusb: Adding support for LE scatternet to Jfp and ThP

 drivers/bluetooth/btusb.c   | 11 ++++++++---
 include/net/bluetooth/hci.h |  9 +++++++++
 net/bluetooth/hci_event.c   |  4 +++-
 3 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.26.1.301.g55bc3eb7cb9-goog

