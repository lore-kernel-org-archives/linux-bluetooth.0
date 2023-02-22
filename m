Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1ACC61DA3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Feb 2023 01:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBVBT5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBT4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 20:19:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCAD2FCDC
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 17:19:55 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z20-20020a17090a8b9400b002372d7f823eso2988347pjn.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 17:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Js7+BfOhG85O98wugCtiKVN4uAHZaaK2v8pFb32zZmA=;
        b=REIu9O7cFe+a3KObNeN28DsnjKcbLCoCXF9+KHicMPuVS5puGXjaOavmOkK9SRe7T6
         DnzDP6LNOlDYRqNBUBRLohLyZYmFbKAv70Ug+Xy4y+Cb8+9tQ24GnotWUTk6KR6FUNnm
         cMFwetjtrSTnFcAVmeHMyj3ZYZ1rlfjft5sCVtzSmq0q8XXcLZO3MLNsaA7MMI+uBQxK
         PHVM75m7eyBhmsQaOIvPq8Dvt1nJ2c/pWjJe4bHrYkV2mCvfmcveijhoi0ZHCmOqJ78Y
         epdpSzz5G76IsUdYPF1uQ/cDS2Lc4CRQmLt1gXFB3oniL5v94RCZ6bsJajmul3RBuIwN
         y3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js7+BfOhG85O98wugCtiKVN4uAHZaaK2v8pFb32zZmA=;
        b=pvgOcYOaRUYzq2szuIdnzjz6svl/oQINgVMTH5o9nfb7EhBTw5fGQTFlValNW3K+iv
         40MJ32/fM5YbK4Kxc9CZXinYJi7sgiF65L0UQILYC4gTww745AUCXHJ6ni2PZ2lupwC+
         TNkkO7pRJbDVfYD3IC0r1MDPjOOSK3poRGJTUBaA/Js2RkBEtklQR6L5mP+uRoq9c+8P
         405HOhDG3kTNAZ7ha0tt8a5GkKamLJ+FO78FBD7phJ4Oyk15gCMZUS/DGunv4W1ZWWkP
         YfSJCXY/vx5OQRZKq0cs/mr8TP3Y0sJscxnUcXiGRDrPUU9UZiVsg2abb03ltHeafjyZ
         lx6A==
X-Gm-Message-State: AO0yUKX93o699buZOxG1HyDABXbTAS059JlOgiQfZ0lwcngfpzVVsd2j
        bGhxYccPQk0qF4YVLCDzyoLUiqmAhUc=
X-Google-Smtp-Source: AK7set+SFokTz+tuH/Hz5ysjZdZ3gB6aFu4qmP99HbdDrjmyfG4fKYA7H915MTru6iJeId4W40Xj7g==
X-Received: by 2002:a17:902:e5d0:b0:19a:80e6:2a21 with SMTP id u16-20020a170902e5d000b0019a80e62a21mr11452042plf.33.1677028794494;
        Tue, 21 Feb 2023 17:19:54 -0800 (PST)
Received: from [172.17.0.2] ([138.91.71.16])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b00189e7cb8b89sm6060803plb.127.2023.02.21.17.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:19:54 -0800 (PST)
Message-ID: <63f56dba.170a0220.b8948.a988@mx.google.com>
Date:   Tue, 21 Feb 2023 17:19:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6477313641125639188=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v3] Bluetooth: hci_sync: Resume adv with no RPA when active scan
In-Reply-To: <20230221161749.kernel.v3.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
References: <20230221161749.kernel.v3.1.Ibe4d3a42683381c1e78b8c3aa67b53fc74437ae9@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6477313641125639188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=723909

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      38.99 seconds
CheckAllWarning               PASS      43.62 seconds
CheckSparse                   PASS      50.59 seconds
CheckSmatch                   PASS      136.24 seconds
BuildKernel32                 PASS      40.38 seconds
TestRunnerSetup               PASS      572.86 seconds
TestRunner_l2cap-tester       PASS      19.73 seconds
TestRunner_iso-tester         PASS      22.14 seconds
TestRunner_bnep-tester        PASS      7.31 seconds
TestRunner_mgmt-tester        PASS      138.68 seconds
TestRunner_rfcomm-tester      PASS      10.73 seconds
TestRunner_sco-tester         PASS      10.11 seconds
TestRunner_ioctl-tester       PASS      12.23 seconds
TestRunner_mesh-tester        PASS      8.68 seconds
TestRunner_smp-tester         PASS      9.62 seconds
TestRunner_userchan-tester    PASS      7.04 seconds
IncrementalBuild              PASS      36.58 seconds



---
Regards,
Linux Bluetooth


--===============6477313641125639188==--
