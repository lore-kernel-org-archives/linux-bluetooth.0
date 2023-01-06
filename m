Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51645C3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 01:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAFBbc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 20:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjAFBbN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 20:31:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE776160
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 17:31:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w3so203190ply.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 17:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLzSkZ8xWof6xtv7EQOlPDE/7XoZ0obc3Km3fdaeRVw=;
        b=nogMxnyXUqAvrPLA8YG7CoUkzQWnT2Uz6mQGAY0OGl7wrlDlTdMlJ9KLfpo4HupnE9
         6B8aTs9aUrxtyQOk15nn36J2SNGp4cWnD/GR72nwWcHRXXTHTUT7xFTvhx/ZFrKDPL9k
         X28Z47oLp6pX7r+tD/8OAR7owxRSeR5mUbzpCNeA4lH7arlvpq1lAH9xShu2UZS6RIUP
         FU1f7NU6vHJeAEUOlmj4rn3NpjcUvzlux8LMCXOo1DjhHwQixTGpxDum1lhBU9zhN5Dn
         JZw+x7bbm7O7rFxrEH5OpqCEGiTUu5u/4p/SESP5mIWltP2zj5Ek0qVNeUElhijVR4ce
         ejaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLzSkZ8xWof6xtv7EQOlPDE/7XoZ0obc3Km3fdaeRVw=;
        b=UZOr+HON5Rjsrw86Lg0YjCvo7WF/5G9g1yCu4lU2fqFkow7PpluPEorOzHESlvVzs3
         sG6iWaRjeucUjga/n6gUrvr8hRLuth/TVg2kpkcisBnL84O5U37i876l2Q7sv91Iux9H
         /zJNGcezKcP1etAK0gDvSDcgIpOB7CDuO9pz7Z4NDPyMTZDrJKl7gbKA3ZB6xmCwaM/Y
         cgIX0N4wASDg+8sUXkLtR1TjT4e6CCbrf879+4eHK9WBxTwd0cFdk/2dHhSs4V2KhnzE
         HvAyDBkpoYJPMFyJ7cfwhkjYXVSSltGZkiesYcHihkH21RTY0UIAX6I5nYtRUGgxfbJn
         xCTA==
X-Gm-Message-State: AFqh2krYz1iwj4sl8FKnGgR0xEdfr+/riURIbkZEiCSYePp/qUARGQ1R
        8S3qXo/JJ6/m+JS1HEP2kkwSD/lIkGc=
X-Google-Smtp-Source: AMrXdXtiy+76IvYUzTNIyFWgqpQnCNp4kexOR0EbvY32eJZsz1AI7KeoLkTTv2jNdgPdO5cODteJnA==
X-Received: by 2002:a17:902:e291:b0:192:fc7b:2bc0 with SMTP id o17-20020a170902e29100b00192fc7b2bc0mr4051813plc.13.1672968671651;
        Thu, 05 Jan 2023 17:31:11 -0800 (PST)
Received: from EDP-LAB-JQIAN2.PD.CalAmpCorp.com ([69.110.165.186])
        by smtp.gmail.com with ESMTPSA id z16-20020a170902d55000b00189db296776sm17421946plf.17.2023.01.05.17.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 17:31:11 -0800 (PST)
From:   Jing Qian <jingq77@gmail.com>
X-Google-Original-From: Jing Qian <jqian@calamp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jing Qian <jqian@calamp.com>
Subject: [PATCH BlueZ 0/1] *** hcidump: fix array boundary issue le_meta_ev_dump ***
Date:   Thu,  5 Jan 2023 19:31:00 -0600
Message-Id: <20230106013101.35016-1-jqian@calamp.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

*** BLURB HERE ***

Jing Qian (1):
  hcidump:fix array boundary issue le_meta_ev_dump()

 tools/parser/hci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: 4e2ae14ea31178ebbbcb0bc81dfe74bd56b4885f
-- 
2.25.1

