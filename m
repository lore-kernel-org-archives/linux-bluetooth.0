Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F37C4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAD723A3C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Dec 2020 23:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgLGXuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLGXuN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Dec 2020 18:50:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29574C061793
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Dec 2020 15:49:33 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q3so10512917pgr.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 15:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZA2t8hqswIuo6uu8EztKubCmJnN0R+7r1kvJEd2dug=;
        b=gJw6T5Qf060s475ErPJdCCAvJ65GyWlp1RlMx9ZIVKmgQqTypkHfNackoOqnT4Y3Fd
         tqi24dd/BVgnOBBdvcJ1DDwR0CyG9pZ6HiZYO+YCfudPaRox81FG9104a185i+uGi9Kc
         Zg3lbNixfpNkXpDK6DnajA1OZIg3ink1/xcw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZA2t8hqswIuo6uu8EztKubCmJnN0R+7r1kvJEd2dug=;
        b=kXi0pgMX96Uy3Q0crWyRRJaUSkoq3rFiD2KegwxlZ4paRSMRl2VrXsvnOBHjTk7APp
         0B/apsXSmL3jkEu+1DKI68u6dIQYuzsvBP8SogNH5fvOpt30QWulxy0QiQkDwUhOw76t
         ztPkizkYtISUXtXUu7F6Ww54DRjcK0t+3qoUD4QOQSDJ5NNClKAs+las7AmwMMsMjpoO
         mdOjGjbJF7RsBCkRBJPqwSKxxnDHeVBslFVUxpob2ue4voTOoSKkTXWaMiZB9P4wlyXg
         FOKVfgiO3OmCrw8FYRI7Buy8TwH0edIelQVJIi4ALmSkZxF0IuvrcsMtLv189a36IKgn
         hGOw==
X-Gm-Message-State: AOAM531Cw/+kf4eLei4bzAXkL/QjEdHRyCyvw2UKduZ7qO6HPgtGVEcH
        TCKM0VhQ5ADu3wFQOgyScWZcwQ==
X-Google-Smtp-Source: ABdhPJzl4Ub8Hv7F+iT1wihJRc5685VEJ2RM51P5Pt3UDC3fPgsVEq2897sA4P9qTwrWUdVPWC9oDA==
X-Received: by 2002:a17:90a:520e:: with SMTP id v14mr1195693pjh.9.1607384972455;
        Mon, 07 Dec 2020 15:49:32 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id g16sm15062041pfb.201.2020.12.07.15.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:49:31 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [bluez PATCH 0/1] policy: Fix connection stealing with Airpods
Date:   Mon,  7 Dec 2020 15:49:23 -0800
Message-Id: <20201207234924.140606-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


Hi Luiz,

When a2dp-sink was added to the reconnection policy, it exposed a bug in
Airpods which were incorrectly emitting Connection Timeout when
connecting to a new device. As a result, Chromebooks started
reconnecting immediately (link loss) and inadvertently "stole"
connections. See hci trace below:

> HCI Event: Disconnect Complete (0x05) plen 4                 #1680 [hci0] 62.656436
        Status: Success (0x00)
        Handle: 256
        Reason: Connection Timeout (0x08)
@ MGMT Event: Device Disconnected (0x000c) plen 8              {0x0004} [hci0] 62.656510
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
@ MGMT Event: Device Disconnected (0x000c) plen 8              {0x0002} [hci0] 62.656510
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
@ MGMT Event: Device Disconnected (0x000c) plen 8              {0x0001} [hci0] 62.656510
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
@ MGMT Event: Device Disconnected (0x000c) plen 8              {0x0003} [hci0] 62.656510
        BR/EDR Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Reason: Connection timeout (0x01)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          #1681 [hci0] 62.668156
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    #1682 [hci0] 62.670442
      Write Scan Enable (0x03|0x001a) ncmd 2
        Status: Success (0x00)
< HCI Command: Create Connection (0x01|0x0005) plen 13         #1683 [hci0] 64.090171
        Address: E4:90:FD:7D:E7:5F (OUI E4-90-FD)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                      #1684 [hci0] 64.090446
      Create Connection (0x01|0x0005) ncmd 1

This patch separates the ReconnectUUIDs by adding a ReconnectResumeUUIDs
and distinguishes reconnections that occur on timeout vs. resume.

I've run the following tests:

- Check that Airpods changing to a different device doesn't cause
  a reconnection with this change.
- Check that adding a2dp-sink to ReconnectUUIDs will cause the original
  issue to be seen.
- Make sure Airpods are reconnected on resume.
- Make sure other headphones are reconnected on resume (tested Anker
  Soundcore Life Q20 and ATH-M50xBT)
- Run bluetooth_AdapterSRHealth.sr_reconnect_a2dp (ChromeOS end-to-end
  test)

Thanks
Abhishek



Abhishek Pandit-Subedi (1):
  policy: Refactor reconnect policy for resume

 plugins/policy.c | 72 ++++++++++++++++++++++++++++++++++++------------
 src/main.conf    |  9 +++++-
 2 files changed, 62 insertions(+), 19 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

