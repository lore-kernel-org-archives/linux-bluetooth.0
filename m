Return-Path: <SRS0=QcUl=BD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CDAC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 05:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE19020748
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 05:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wP6ZaW7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGXFlR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgGXFlR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jul 2020 01:41:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B00C0619D3
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 22:41:16 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g7so449431ejw.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2020 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ni/bslctWqoe3AamxXYjt+xMiBuKfxjdPfgujWLM3fI=;
        b=wP6ZaW7Ysf9t2w8NQxpKWB3uSs/oKLLZWZhl4pu+NWA6XWzbsAdTx9RUiPKx1axfDR
         Uy25g8hnPQpALpnXgXG6Mot68vVIxSYyncvM3RzIqJXJEEtt59yNjYdgYgD0G9HRICic
         VlGhIUC+NAtdhxl3NsujuwcfLZKQTgWjrHfvrPy9XMMDSld7FWgr/jVyBgYrrpxi101/
         6mPA6iTqEP/bz23KIDtvjkHRm/u7IXOfE6AdQytZ5STPr4gn0EFT+q0gYeGNGgCjGhsN
         4ErO6AJS/Q24kMDk/Hp7pSc0StbWNiUL30A0W7l1qdLC3etHaW/zgUoqWiR2P2pGl5xZ
         fP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ni/bslctWqoe3AamxXYjt+xMiBuKfxjdPfgujWLM3fI=;
        b=ED0jUS6eeYEGlYmeYA9rrN+aaaosjtlKGSc0P0oK9ytuHARRW/Q1JbpffPDn0KdwqW
         xzNKsLz5z1jJD6IXmt8p2vwwT1PMjoJDOIX9gKZ2EWaR5iqcTgi4it+ADGcsxromsbg0
         /t6SNI4NOMDDqgLy9lz4QxLhh3A0Sf52pFrreWwiibUOk6U8wEoZ/jBpfaJVPSVqsihm
         zWIDVkeBqZecq9rTlOcbyNCcQQ+fRCJS7TYtK2nVk/yV8jB8szVJlmHDkYTT87iaSn+I
         zPAJ1gTWbfI5lejh+jnMDXracBKujjU+5OeMMyy6R1+ZM2HyeZblNQvWkZBFEAizQDq1
         Rr7w==
X-Gm-Message-State: AOAM530lCpuLeru8yi9Xye5ydyAEgiXBx4P2xPxzPJewIi4CjU/tWvM5
        sVtpLm/m/nwAE/TWlHjLYDZvtirqPyMK3vrWYhvSDwO/uSy7zQ==
X-Google-Smtp-Source: ABdhPJyP19B/oIry0JfCJBkdBQpAI5pWgWggGgO/ylXYUHO4mBvGUxx0IWjuH24wIykQIooKuaHnk/vvvH+v3M9qqjo=
X-Received: by 2002:a17:907:2170:: with SMTP id rl16mr8006251ejb.422.1595569274883;
 Thu, 23 Jul 2020 22:41:14 -0700 (PDT)
MIME-Version: 1.0
From:   Yun-hao Chung <howardchung@google.com>
Date:   Fri, 24 Jul 2020 13:41:03 +0800
Message-ID: <CAPHZWUdDpnSdhA9_iceKfQB08vMVPsGpKu8LUWoXvrsu1wf=jg@mail.gmail.com>
Subject: Advertisement monitor interface in bluetoothctl plan
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Miao-chen Chou <mcchou@google.com>,
        Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-bluetooth,

We plan to implement the advertisement monitor interface in
bluetoothctl, here is the plan.

All the commands will be put under a new sub menu 'advertisement monitor'.
New commands:
add-pattern-monitor <monitor_id> <type_of_monitor> <list-of-patterns>
<high-RSSI> <high-RSSI-timeout> <low-RSSI> <low-RSSI-timeout>
              //where the structure of a pattern: (start_position,
AD_data_type, content)
remove-pattern-monitor <monitor_id>
list-pattern-monitors                     //list all monitors with
their id and attributes
get-supported-feature                  //get SupportedMonitorTypes and
SupportedFeatures in
                    AdvertisementMonitorManager

What do you think about this plan?

Thanks!
Howard
