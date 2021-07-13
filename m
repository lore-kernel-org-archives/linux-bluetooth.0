Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC7C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 20:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657536128E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGMUhd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhGMUhd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 16:37:33 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C42C0613DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 13:34:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id m3so9204775qkm.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 13:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=c+42oEGWyA7d7j94XGkWBSI/MJNZPxcMjSiULWJmIRU=;
        b=J3V5deNju9glnY5Z1nAWFFM3Pr8XG91qC1f5/ZqaLFSHANe5zFk4+ZtBtmLRxAVDJp
         Lhbh+wWhmu1ikvczWxZsE6NasdEH/cJgiqzb6YQnh2RrY92LrZH2XJvGj2TcZgOHeXL1
         briz0eDbPToh77/MmQEYFKcAnd6MNNt+wGXGBC7/dAEG0N6h1ZOOH+8yROLWGlCmUMH8
         zQCG6mOorne8w62MiCEFBMJTHNOWPd9d7aux9JcwhS5bb32dCo7qIo5dfNlO3ayaDxWF
         G8D/N8STb9qddr5vhnHS/2Gd3TSvhoMyMOA185zOwjZRmFg3xDq0xlSnCbp/tUi0qpc9
         yf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=c+42oEGWyA7d7j94XGkWBSI/MJNZPxcMjSiULWJmIRU=;
        b=AWopSxTO2Y3c4cozrVcXbWmDGETkdoZwe6YRfgO6NBNzp+31NrENRuLfGL+HrrPExW
         vSVjC94KTqOeeF4pgZbxsLvb0tjJQhq/Z0LXWqWXCaUUdorAB2QhxKojKmWZtl7uDXpa
         mqaJGHA/8BmLTP+Dah1U3UGH0L9YVBQwcmNCpQ0cLTBPpkBqfvNrRy2aw6Il8nLheZ+/
         l4lrX9NdF0jWz6hrp/uVl5WGeVu38SQaPj4DdwsXpSuLTYfby3zoWDu3z1hJQXFfwpn2
         cxM4m8t6bgetK0AxAcw7ywU3C+sQS7A9Q7rPdUEVyJI0u283FF5GA9xCoGtiIo5po0tQ
         kFvg==
X-Gm-Message-State: AOAM532NL7HbFVfVcg0ryjKj383gDaS9Ue8E/lFlGAZSgnP4WjUWl44O
        MmgWNyv7g6FZtyjYMNFadJI+2/w6VUhI3Q==
X-Google-Smtp-Source: ABdhPJxDtiVX6zmq5lP739A5GR5sOqZakaAfECSdTywAw6mw+RcKpb22WZxXKL/fg1iXraLfQj4CDQ==
X-Received: by 2002:a05:620a:d5d:: with SMTP id o29mr6198967qkl.157.1626208481582;
        Tue, 13 Jul 2021 13:34:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.44.104.5])
        by smtp.gmail.com with ESMTPSA id o13sm7382911qti.84.2021.07.13.13.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 13:34:40 -0700 (PDT)
Message-ID: <60edf8e0.1c69fb81.8a415.e3ac@mx.google.com>
Date:   Tue, 13 Jul 2021 13:34:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7096005259069755916=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ] doc: Add kernel config to use SHA512
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210713202147.116261-1-hj.tedd.an@gmail.com>
References: <20210713202147.116261-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7096005259069755916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=514999

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.11 seconds
Prep - Setup ELL              PASS      39.64 seconds
Build - Prep                  PASS      0.09 seconds
Build - Configure             PASS      6.94 seconds
Build - Make                  PASS      172.20 seconds
Make Check                    PASS      8.70 seconds
Make Distcheck                PASS      202.76 seconds
Build w/ext ELL - Configure   PASS      7.09 seconds
Build w/ext ELL - Make        PASS      162.67 seconds

Details
##############################
Test: CheckPatch - PASS
Desc: Run checkpatch.pl script with rule in .checkpatch.conf

##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============7096005259069755916==--
