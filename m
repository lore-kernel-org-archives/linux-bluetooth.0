Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80374FA3741
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 00:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiKAASX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAASW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 20:18:22 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706712633
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 17:18:19 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id a13-20020a9d6e8d000000b00668d65fc44fso7661417otr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 17:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bKFR0OhgeMvZAp/AYYmSC6BD40pKIKbkiu8hagUtvt8=;
        b=TvSAaHxV327/3a3NDyxcYHOIqtxvW2tucBhk7+8Ht/kNYyyYljPo8/xLn5ga+FjPb5
         lFhHJa68I70kywJu/dcxZXI+11VRBTr04PAjRyXJcAv73+RQ4rggJaVQ2ZpGdMbFQ/H9
         8F3LvRSXLUDRcSg995ldKmN5pMd0Wruhp/ygS6puZ4w3VD01+lDlTDFGdrFKFyHjKorx
         2DFvX4qrvFZzPBvRHeTNRTWkX8uWKuNQol1cVhaZ/14fCthnxVtDOcKGyD03Rwj0ZWqk
         X30VooyScR9Xd4pLyksESFqXFQzuI51AY3JxBvzndqI68y12eAR8mwgHJlYN4e72UxAl
         kJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKFR0OhgeMvZAp/AYYmSC6BD40pKIKbkiu8hagUtvt8=;
        b=YwKBzYwxhpRUAgXGyy0z2zjTBYkSlI0pNyJk5D7b2gNGtR8kA16zGJxzvMs5o3WYj/
         zEWkp9T5R/bjZw26T9pVwZj2H00V1/E60ilgK/XLJqTKqaQ41pZdZzbwmRniLrvP+5kj
         V1ixKMiGNA1eyP9zmbGE5V68FDS0fEQHg3RNSrIDnv4BZvOy+6v2v3IzZFOeUSs+6MLS
         Hdbmhq+zCe7SjRs0VM7qRREe/DWE/I1l4xVN5vSMkJhjckVYy4Jda+YGRUAiuQg0IpVx
         eyx9iPJZqkx6NCQvE2KmJONX28CnVkAzUq6wWQ67pAfWr/LnHrnouz4nrfMcb4mBF5Jo
         P+pw==
X-Gm-Message-State: ACrzQf25RMrziWs7YaibmWNNHVIwCyVMv8rOzcc91n6TZ4SF/IaVwWt4
        cnlqVdd2csXlFQjKdaMRRS07Gh6SfuU=
X-Google-Smtp-Source: AMsMyM5X6Oi5gCAP02Qb0uXDVw/pqTFCw1hlbnyXx9RYlq2mqaZm4uP8k4ZyrXLesYps4i109NPFnQ==
X-Received: by 2002:a05:6830:6083:b0:660:d54e:583 with SMTP id by3-20020a056830608300b00660d54e0583mr7925289otb.282.1667261898483;
        Mon, 31 Oct 2022 17:18:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.179.74])
        by smtp.gmail.com with ESMTPSA id a18-20020a056870d19200b001375188dae9sm3740600oac.16.2022.10.31.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:18:18 -0700 (PDT)
Message-ID: <636065ca.050a0220.d770d.cefd@mx.google.com>
Date:   Mon, 31 Oct 2022 17:18:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0141116733637948121=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix attempting to access uninitialized memory
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221031231052.2718430-1-luiz.dentz@gmail.com>
References: <20221031231052.2718430-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0141116733637948121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690675

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.83 seconds
SubjectPrefix                 PASS      0.64 seconds
BuildKernel                   PASS      45.44 seconds
BuildKernel32                 PASS      40.67 seconds
Incremental Build with patchesPASS      63.07 seconds
TestRunner: Setup             PASS      702.91 seconds
TestRunner: l2cap-tester      PASS      21.89 seconds
TestRunner: iso-tester        PASS      22.33 seconds
TestRunner: bnep-tester       PASS      8.51 seconds
TestRunner: mgmt-tester       PASS      136.60 seconds
TestRunner: rfcomm-tester     PASS      13.46 seconds
TestRunner: sco-tester        PASS      12.76 seconds
TestRunner: ioctl-tester      PASS      14.63 seconds
TestRunner: mesh-tester       PASS      9.94 seconds
TestRunner: smp-tester        PASS      12.11 seconds
TestRunner: userchan-tester   PASS      8.51 seconds



---
Regards,
Linux Bluetooth


--===============0141116733637948121==--
