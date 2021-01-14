Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B8C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 08:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FFC239EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jan 2021 08:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbhANI2m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jan 2021 03:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbhANI2l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jan 2021 03:28:41 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D7C061786
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jan 2021 00:28:01 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q1so9577227ion.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jan 2021 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=f3JZsAew8ChWTHVUY0ZqBgDBj01agJLhmkXcGdAumZ8=;
        b=sLCN1GE0F8Kxx4KxowaP8TN5BzApHU+cRivyaGhhbCiNHUy3ojNDZoF3tl0MCxA+N3
         p4WYHAuvp0+SIMPA4yxIJpjyOAvwPkcsIeeWjCz1QtsSnn5AL1WvHoWXghz043Ci5Sbh
         DD3pgQ0Pbji+K1NtgQEsbhbnHVckwhtwBbix6D+gRioR1taWCoMy/hk3DUAWGn64Ni/X
         Qhi23OvNJNTmxemJnoZMwCvBYNMOMh9eOIBSO/RDQay+ehgflALA7QdaXKGP1J+p7LcN
         41yXOQmnjTsC1pDSl2DmYUJ2YOC3J2WKE26MTt1Uk96tHVn3DhfUrizWrucCGdlzAVEe
         gw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=f3JZsAew8ChWTHVUY0ZqBgDBj01agJLhmkXcGdAumZ8=;
        b=ICpCbPoGnN3sVnffa3GMdTirep7HDn4Jvo26ev2w8XYtXGjJ//m/cULocLKqFLoiOz
         jEVB84xd5OBQhrpDSTeLv3Djs9GL5R+gMwjJVOHYRUTOywZHlCXqRJqo8fDszE6L7eF5
         tbsC3VJzPztS33o8Ko+DZM4EKcek1P4p3mueYnbocfI6LgUPLiwrujW+0HVKewTsklta
         uAyBIkMFANchy6ff3+jY5gAXSVJCi5V5zwzqYAhiCaP1VZbc5ckk3SuQGbF+1yswa8pQ
         Elbs82FOuusrBb0NFMdXFn6iiXMmysPiTvGFiQ4Ds1fS2hHSrVrcM/i8EKGQdr2KrftG
         AKAA==
X-Gm-Message-State: AOAM532pII/FfjNsMxrA4M8DozxmmoC3u8n4qZMqarcdYjN2YrptfD96
        +YfwrURo/IOtOevDTTwYHAxlX4/FawQ=
X-Google-Smtp-Source: ABdhPJwkYoPUqKKe/Ey+movZIguE5iw2BFgPikghOUNpwOGVq8ohja8eg5tVM5cThWcRwENMOVVSxA==
X-Received: by 2002:a05:6638:39a:: with SMTP id y26mr5618197jap.14.1610612880767;
        Thu, 14 Jan 2021 00:28:00 -0800 (PST)
Received: from [172.17.0.2] ([40.75.89.123])
        by smtp.gmail.com with ESMTPSA id e19sm2317916ioh.15.2021.01.14.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 00:28:00 -0800 (PST)
Message-ID: <60000090.1c69fb81.bf65a.a4da@mx.google.com>
Date:   Thu, 14 Jan 2021 00:28:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5808935614592467226=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Support advertising monitor add pattern with RSSI opcode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210114154405.Bluez.v3.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
References: <20210114154405.Bluez.v3.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5808935614592467226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=414351

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


--===============5808935614592467226==--
