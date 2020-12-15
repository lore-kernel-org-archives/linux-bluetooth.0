Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B40C4361B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 10:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9682072C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Dec 2020 10:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgLOKiC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Dec 2020 05:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgLOKiC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Dec 2020 05:38:02 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64134C06179C
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 02:37:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q1so18737032ilt.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AnJsbd3ev89RNc9dS3Ogb8DlKThKoj0YaUygC1hEGAM=;
        b=dF3oNjdH5r03Vle6Jn+tgEopNwuxqCl3DsGiaU0feAZM4fL5pkkQjHDjfVxrLhDi6B
         zyr1qrYLGCZqv28lVj4PB8gOBy7YlWSdK4Ixt0pSuAnowb2610OpbWuN7pVxbdJZuN0a
         deQytB+WzI2PW8B63Krp5WQnruRsUE5Q078vwj1vjhapiuzQN1pqZKKmo78jpUDgdXOv
         ewz18x1zM+C4OMyAtBoLxkCWs7mo+VEBO1UCfYITIFCS7kCdjB1RzZjEeABHk0UeZhkU
         +XJah1BX0vMz1Kd5B/J9mZi7Cf03bVCBxF/DhWxkn6pEpyjFCiuCwT2uoZMK8IGkftPY
         6XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AnJsbd3ev89RNc9dS3Ogb8DlKThKoj0YaUygC1hEGAM=;
        b=WOknLdhuwKnUPK2nyYdyan0HCIYbbkZbWbr8GJpxpp/abgNV8fmbSsibDIMLIAfnvm
         8LQ9kyYhSWhr/2ItXUWWWejyA2M7rC9pEDdr8t6huRn3YkEeZPIEap0L5p8Ba1XNZqaD
         vqMfCl4A3vXwcL51Fa/ewn79hSxaGTvwj706YwkJHmBoMh5CTmL6QOTHzXAKJ3d6fvk8
         ZmBkokRIpQsp503V0LbF8Ub9xduisMZdmrgW1jRhTx6qiRd84n6BlJ5yfG9/9eRjgiNV
         aJK/lhv5CwhdpjvA+66VZBhkGhR76fFRDXxlIxaLBtDt3bYeSYAie+6SaokAXpzGRBwg
         bQmg==
X-Gm-Message-State: AOAM531tLBXR2nPPeLakg76zcT9GiNUp/+2DL7Mv+Vu2ZsjpPKScPwI8
        7yV7HHvx2sQM8mUTb8xkjoRpXosYqEY=
X-Google-Smtp-Source: ABdhPJwxng38Yf+41Dgj511GmEukpbKgZXkEk7xcZJeAGGiagfgasxdHHiNMtY631wGGuiwd/xZ48A==
X-Received: by 2002:a92:d151:: with SMTP id t17mr41646089ilg.108.1608028641172;
        Tue, 15 Dec 2020 02:37:21 -0800 (PST)
Received: from [172.17.0.2] ([40.75.108.239])
        by smtp.gmail.com with ESMTPSA id y5sm13171653ilh.24.2020.12.15.02.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 02:37:20 -0800 (PST)
Message-ID: <5fd891e0.1c69fb81.a0c25.6264@mx.google.com>
Date:   Tue, 15 Dec 2020 02:37:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8891260419891681362=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/2] doc/mgmt-api: Add opcode for adding advertisement monitor with RSSI
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201215181024.Bluez.v2.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
References: <20201215181024.Bluez.v2.1.Iab784797733f28413e9de4f0d7fc0d4e1a00d9ef@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8891260419891681362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=402125

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============8891260419891681362==--
