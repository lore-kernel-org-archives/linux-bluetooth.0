Return-Path: <SRS0=5gFq=DX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038EDC433E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 23:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9725920878
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Oct 2020 23:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDBRtHLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411410AbgJPXaM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390881AbgJPXaL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Oct 2020 19:30:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4665C061755
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 16:30:39 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r4so6048639ioh.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2020 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RnmtMqvHW6gczKYRGOHkjzg7odFQaaMtmasYI7PP53Y=;
        b=NDBRtHLJRGxuYgIbOSqPPiof+0B2vh4M/6q0sJ8X2YkLv88VX4Zns7Ix5cwjxqgAMQ
         c+tw4fiLKrsRUe4kKLxFYCDHpKDRJu/E8WWszaXSQYaScusZ6iLFNyT8Zrwb20+WOdXO
         ydKYVmh+pXQFpU6st6biE56dHjGo0PQ8dP/JojrSaRx4g4jvrX0sCbFRh3tRqPlaccE7
         4QV2jQdAjSX0eTGQnvAFBuTv9vt1f4VeHWWH2G3LdMpPftt1DWuYz+py/+N/ejfGuyev
         151EidpKPUOP3n2i2Rs/y10HIwvGms58tb+UKIvEeXGIpu4PxcU3ZIhAtzAXOeqoRsmh
         JfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RnmtMqvHW6gczKYRGOHkjzg7odFQaaMtmasYI7PP53Y=;
        b=KXuCu/w1ZrFxWl1/iHYm4hn5ZYKjKaxw+N/fD8YQg9wzBcfpKm7Pjyrkt/qqk/C82z
         1Ai1Le9PNuxHn2vDRIJO757+xp3xyLauKL7Ny1aYw+1AxfLtIjDfaQULQo4OrL/erG+a
         vcl5c2S5s0yHWCL3jxMYJEW1c8OharkjJ0wbJv005dDzwB5yeq5chp2lGp41yIILwBG7
         GgM2ejqcOl7qvfPUOdknWLxanXzb6nY99E0oJ9i3cDu/9QkbyLTrs80ZpwNH8HYT31gL
         oURY7H1ga3qvzQwPrWlVRCvrFbvaOhOTxolhLBJA34FhiWCn/Mwhax+QPLMXHmHVPX9a
         ePuQ==
X-Gm-Message-State: AOAM530FzERZwMp3K+vBibE2EKSVkc8huwnzPiEr3Q542uO9HBB2Nvoi
        F1dPfM/BGbYqL7JRg1GKU5PM5Ebs6A4=
X-Google-Smtp-Source: ABdhPJzcY31zFa7SIxxGEWOY332vSz/9NH7vxTA7LlglXQuIPtRVJ8Rtaa0fxCWH1UGF3q5Sb3ftQg==
X-Received: by 2002:a02:b187:: with SMTP id t7mr4585617jah.18.1602891038917;
        Fri, 16 Oct 2020 16:30:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.176.140])
        by smtp.gmail.com with ESMTPSA id y6sm3220208ili.36.2020.10.16.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:30:38 -0700 (PDT)
Message-ID: <5f8a2d1e.1c69fb81.e4762.36be@mx.google.com>
Date:   Fri, 16 Oct 2020 16:30:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0519711399190256196=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, danielwinkler@google.com
Subject: RE: [Bluez] doc/advertising-api: Enable new data sections in adv data / scan response
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201016154739.Bluez.1.Ida2ffbf34e18b5a810dffd2abd2bb9e431df3ae4@changeid>
References: <20201016154739.Bluez.1.Ida2ffbf34e18b5a810dffd2abd2bb9e431df3ae4@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0519711399190256196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=365969

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
doc/advertising-api: Enable new data sections in adv data / scan response
1: T1 Title exceeds max length (73>72): "doc/advertising-api: Enable new data sections in adv data / scan response"


##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============0519711399190256196==--
