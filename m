Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC82AC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 21:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCPVd5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCPVd4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 17:33:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4016A28201
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 14:33:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id y2so3030732pjg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679002433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gkf8E2a1FwUr+ZRwdrXOmo14cK1nzu1COc1w5/ALe48=;
        b=CZcv4Q8Drwz5vSUi3OWxOuKw35BHeCKmA0EWRSfGtscEg+dYJgnbhq5j6yTKB0VvSx
         gS/sOCe7zAVJaaYvXrMVBmJdgkBH+70jqJRnA8Uo3Hz1J90tByzYHCwcp4TadhLQW44U
         FTotSpO4NTqPohnzdrMNBsnyvoz6/j/NzQhvF0f8fjIR7u8D33ROpAb5jv9Q6CkiWgVx
         3kX2zCJRXp/DZaXlSLua4LmxgnlyNAzGqJnpQ89t2XSWzCLqcN/B+Wv+TUFOe+i5Xj5x
         wYigXB8MJ//Z/vIs/YRvf2SPdWwS6Z0flXcKnMpkgJeXa7jCe752zGdN3Ck0RaWLIP8Q
         SdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679002433;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkf8E2a1FwUr+ZRwdrXOmo14cK1nzu1COc1w5/ALe48=;
        b=8B/nugJ1hXXxCFE7bMqUrvc/cMEVl0qM5ZKagCV6tR8/o7qyHx82lvRLKbhCwvCQFE
         eBCPnLze+PG9U+/3hNVqprmBuTyF6IQYmFLhZFncPhitqSkacwukbW9qIftrJDZNKAcn
         E4j9TcEfPaC3pJ4llf1R7/uYMarH9VZUXKjB4ej4g3w5ogvE0kc7zC7AAjJugC5F8pgm
         mWhgZD0k/yRt0tjHVtKJWQp0ptn3TX05n3C3/K0n0DOHc27IkIYpnM/knulW4Lf1KsKX
         BjJ6zZ6AHIhkZVuqLT9776NWl9K1mXJcTfT8RaOt7UnJLThczMrFaXnW5ead4oIVyf1g
         gPxA==
X-Gm-Message-State: AO0yUKWLhK0vukv46UyZtXI3hL4hV1qiUUoG8gqF4a/zkcOi9PvABwNR
        VtjLr7ETH1KjrcyZ/uYoIIGPHrTXnzU=
X-Google-Smtp-Source: AK7set+q5yCBhiPtT1/bJwesJl36bHQiWMbLPZFPRxNVaQNBXKxHEbQA3SwXpNjhqVL8lRPtHPT3lw==
X-Received: by 2002:a17:903:2341:b0:19e:2495:20e0 with SMTP id c1-20020a170903234100b0019e249520e0mr850416plh.21.1679002433401;
        Thu, 16 Mar 2023 14:33:53 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.90.99])
        by smtp.gmail.com with ESMTPSA id je19-20020a170903265300b0019f3e339fb4sm146694plb.187.2023.03.16.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 14:33:53 -0700 (PDT)
Message-ID: <64138b41.170a0220.6696.077f@mx.google.com>
Date:   Thu, 16 Mar 2023 14:33:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3467370190086467585=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-client: Fix not creating a request for notifications
In-Reply-To: <20230316193634.1195948-1-luiz.dentz@gmail.com>
References: <20230316193634.1195948-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3467370190086467585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730956

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      34.11 seconds
BluezMake                     PASS      1172.60 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      192.25 seconds
CheckValgrind                 PASS      314.31 seconds
CheckSmatch                   PASS      428.40 seconds
bluezmakeextell               PASS      127.66 seconds
IncrementalBuild              PASS      967.69 seconds
ScanBuild                     WARNING   1390.19 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:451:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:696:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:993:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1099:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1291:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1356:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1631:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1636:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2140:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2148:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3236:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3258:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============3467370190086467585==--
