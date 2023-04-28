Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27FFC77B61
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 15:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbjD1Pwu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 11:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346032AbjD1Pwp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 11:52:45 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A584A524A
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 08:52:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115e652eeso13526306b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1682697162; x=1685289162;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m/pWtwRMSdHzOAQdzPOnWM9pGji63oojSzj+h5zQ7KM=;
        b=j00cRuy+9qBn28OPvUs8xevjt8P4eFWA/dLtNlLwZXdwODZk+GdiCnYGAdn/6aNK1F
         qDqE0UZbVNtSqRXN3d9I/qJlX9DCke+Dmnh+95WIolOeqdWVtMC1qBCK8qKAoDvo5b38
         iaBCOGfvWjCcJacYXQ7TUrOQr9l0Su9aQV4unS2KDbQquoVDxKUmZtABzfubRYiy87xN
         NMiAz3ovNo3rxGAmweH8OpZdobFfxb7wKbdOhGfeDiLWe0wmIRUzxPZrEqcm0Dtyz8KS
         TApbrci3NVEL/pG8tLSTXBPKdzC1pL0EaRQOcO4IghXMYTRCT9v4acYwfF5oMDocpDae
         I4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697162; x=1685289162;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/pWtwRMSdHzOAQdzPOnWM9pGji63oojSzj+h5zQ7KM=;
        b=dcKoRAs2JuBlHAUvUAObI8kfGDZpYCSn9vaICOgGhl1cD/vauqClId/Ze2P/LYvNV/
         0/PxUtvNLi8sfI4y7IYRUA+jvCdyKcHnPInIBEZucHZ1z11unCrT0Mh9z6s/qsAiS60M
         njUjzeMm2fyc9RAt0sleIV8uUFnl7nRFTVvoB+EAD1Ttbrfbg/f4z5sDs3+Y13PpJCTB
         TOcw3DLHvAkaRBmYfbcyvdXFAP0YjRxCYG3PV9TWWB5HalaMBpOUOzeOsL2f+x1V0q2m
         C7rENlS97uHY7SNT51blKGJfgTLmAg9u5r5eRJMn7gTtYpP7BgUCvlyZtyJKBirrigJI
         wupw==
X-Gm-Message-State: AC+VfDxUPN72/lYRHc4ur/uHfA5wilnaHvzc9HvZcy9FiICaz0DU3Rv9
        bsrFJ4ECrEYROvq0J3Zne5oBp93HxzJNH+qq/3O3ZA==
X-Google-Smtp-Source: ACHHUZ4xh1XZri6VpDUlfw9L40s00B9MJk9uFPlZw/lgxLuFHK64tlU9pofiNmLZ5FWjxtqnN90akg==
X-Received: by 2002:a05:6a20:3d03:b0:f4:c0d6:87c with SMTP id y3-20020a056a203d0300b000f4c0d6087cmr6980813pzi.14.1682697162162;
        Fri, 28 Apr 2023 08:52:42 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id y1-20020a056a001c8100b005a8173829d5sm15228452pfw.66.2023.04.28.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:52:41 -0700 (PDT)
Date:   Fri, 28 Apr 2023 08:52:39 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Fw: [Bug 217383] New: Bluetooth: L2CAP: possible data race in
 __sco_sock_close()
Message-ID: <20230428085239.1cb74647@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Begin forwarded message:

Date: Fri, 28 Apr 2023 10:22:28 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217383] New: Bluetooth: L2CAP: possible data race in __sco_sock_close()


https://bugzilla.kernel.org/show_bug.cgi?id=217383

            Bug ID: 217383
           Summary: Bluetooth: L2CAP: possible data race in
                    __sco_sock_close()
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: islituo@gmail.com
        Regression: No

Our static analysis tool finds a possible data race in the l2cap protocol
in Linux 6.3.0-rc7:

In most calling contexts, the variable sk->sk_socket is accessed
with holding the lock sk->sk_callback_lock. Here is an example:

  l2cap_sock_accept() --> Line 346 in net/bluetooth/l2cap_sock.c
      bt_accept_dequeue() --> Line 368 in net/bluetooth/l2cap_sock.c
          sock_graft() --> Line 240 in net/bluetooth/af_bluetooth.c
              write_lock_bh(&sk->sk_callback_lock); --> Line 2081 in
include/net/sock.h (Lock sk->sk_callback_lock)
              sk_set_socket() --> Line 2084 in include/net/sock.h
                  sk->sk_socket = sock; --> Line 2054 in include/net/sock.h
(Access sk->sk_socket)

However, in the following calling context:

  sco_sock_shutdown() --> Line 1227 in net/bluetooth/sco.c
      __sco_sock_close() --> Line 1243 in net/bluetooth/sco.c
          BT_DBG(..., sk->sk_socket); --> Line 431 in net/bluetooth/sco.c
(Access sk->sk_socket)

the variable sk->sk_socket is accessed without holding the lock
sk->sk_callback_lock, and thus a data race may occur.

Reported-by: BassCheck <bass@buaa.edu.cn>

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
