Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB3EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 17:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEBC61108
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 17:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhKERRU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbhKERRU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 13:17:20 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82443C061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 10:14:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c12so3138099qtd.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=0M2zMHwnX5wJECKTcKRcb23buj8KgWm4gK3WedpknOo=;
        b=H8alEKa0TAr2nNGfoLsIu+MuEarAbn2HHRE3knLC7NerPBO5YyRu5f6+tXr4XHMhQ4
         KMCwLKLqytppQLWZe3R+a7Ee40wc7xR77V2S/RE+FCHmIC2OLdSChT4HO/6x8n5eDQBX
         XpGXRFwK94+iBdC1feRjK6iXaJsJqSLuuWU23CxARXc+J1/tVXJTV6zMDOyIC8bo5w4E
         016SRTezK4K1zXx3T/LPfL/O9Xq0aCGfhCAeHEG8QPpq6DJE5on82/3fTQML7HmBI6KU
         6raCnj4boTxl23F9F0Hr9hc/fUyiLU7jt9jfTbxki5+Ne7WddJ8o0ugDlbNnNDMeoxXQ
         zA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=0M2zMHwnX5wJECKTcKRcb23buj8KgWm4gK3WedpknOo=;
        b=WghhYKAK1iUNbnhrACgitj7T8fdg4A+8BRmywcJhQddpze8XKu4IxRCk+jwL0zaqbU
         jZflkbRrq7YqD1shDnKbTD/eV9mzclb1Vfyn16y0sKd6MSuFF5ijpJ85iFpyz6ndJNaf
         POt51oyiBY1wgUK3diG6a6luREGmEQnO9z7aGDEOFyxQABECMa42v4uCh69sRqaxPguN
         +eEHEfXExV6GRBBoL3yHoT7zR7Rf/rNLE96WB1stZw00UAYER1vekWA8ZHgdKAaY/AWc
         +cGMby2qZp0j9undsKq6ruAla/KEs3UqA6t609mR1mvwLxttgA/2Moad/Ocmj1oyFdza
         ZaSw==
X-Gm-Message-State: AOAM531WF+wLOxxJsfRk6EZxmcRCKeyDybvTc/HMFXyfqyX0G3vckzbr
        m10HZvknavAuMjdwv9syHqFzJG58hEyEbw==
X-Google-Smtp-Source: ABdhPJxzAfvcr3VbPgL8qTIzVGmpjT4NJU46kwX1JHfScjneoX3aBWenjaYkswJlTFxdMy+im8khsQ==
X-Received: by 2002:ac8:5a8d:: with SMTP id c13mr5741101qtc.321.1636132479462;
        Fri, 05 Nov 2021 10:14:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.182.113])
        by smtp.gmail.com with ESMTPSA id x8sm6296971qtw.84.2021.11.05.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 10:14:39 -0700 (PDT)
Message-ID: <6185667f.1c69fb81.28e20.4613@mx.google.com>
Date:   Fri, 05 Nov 2021 10:14:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6074044347654072928=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, goodgame13241324@gmail.com
Subject: RE: *** Meshctl "sub-add" command oversight fix ***
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211105165735.13606-2-GoodGame13241324@gmail.com>
References: <20211105165735.13606-2-GoodGame13241324@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6074044347654072928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=576179

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       FAIL      1.01 seconds
Prep - Setup ELL              PASS      42.84 seconds
Build - Prep                  PASS      0.50 seconds
Build - Configure             PASS      8.04 seconds
Build - Make                  PASS      181.53 seconds
Make Check                    PASS      8.99 seconds
Make Distcheck                PASS      216.82 seconds
Build w/ext ELL - Configure   PASS      8.07 seconds
Build w/ext ELL - Make        PASS      172.39 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ,1/1] FIX: Fixed oversight of not supporting vendor model in Meshctl tool's sub-add command
1: T1 Title exceeds max length (97>80): "[BlueZ,1/1] FIX: Fixed oversight of not supporting vendor model in Meshctl tool's sub-add command"




---
Regards,
Linux Bluetooth


--===============6074044347654072928==--
