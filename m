Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91329C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 20:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487232256F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 20:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbhAYUKp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAYUIx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 15:08:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E1C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 12:08:13 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id dj6so6809794qvb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Jan 2021 12:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6Pbaiz0PKS8y5GA5nv0bRHHmM52T/fEIkvH6ODEgto4=;
        b=H4L2jifi5h9q6H35F/2xp+1Ury9xpDds7Bw10JZc2Hza7iMdMQ7oFLPuCKCwrspPAn
         RF54jhnatv9jlkUbebx5o/tXdTnyHh7ePprSexgGmwVm+Dt+M2b7ky78DoivHiLAkP3e
         xsr9U7Oghk+GTrBWAANqYo2/wbSE5PDafK/KBZVJE5M7G5xAINDekLMFmJ8tWrxzVpWW
         WiRTFHK5oO6VBbZfsHAIctZCzVnZdf1NCkhXoTBUfqT7dibzIYqyJ2k8J2f5BlQ481YE
         TiPpaCjM+8BMpPQjRptzebadMTbvvP5gtPP7C1AaDBXprC8OoSEaKy4pXTsZ3Rm92G5d
         He1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6Pbaiz0PKS8y5GA5nv0bRHHmM52T/fEIkvH6ODEgto4=;
        b=jQYsaahjLxN9hGFJqH0xroJmR7Zefs4zbeHax8dTV++BBu8nVlTd9mXmNBNDMcQr7P
         KGidDdT2qwrVRf7FVoszV7g1G1eNlkG+7bvtpZ9wrKK1RJQ7SxbMyyUb920MFcFPGHOo
         5YVRQ3cfCMth+zmoUemoDhor2+uvhAPS2nlNdr3btdm31xl6Ds40+a1LkDDgAK2HEfah
         Lsc74rDz47av63rIM3c4dYOlEaxp09X3d37L8m/DJlN6Y7lOd7CKiJb+yeiQbgiBxqvN
         ZeIAdCegiyh5cH6J1essaXKAmFqHT12KhF7qxf7h/pRDTdYbDha5J70SOPbp648pnCXf
         cHqg==
X-Gm-Message-State: AOAM532Crryy3U0V4a2/mxBxVh5emsuiLl/4YfKaral1I3+Kf20sd2h6
        OLvpN5zZzkDjye+cP9uHaRdAQEIZoU8=
X-Google-Smtp-Source: ABdhPJzNwGr43A9lvgXOxAOWBO7yHJA9aJB8op+4Fbsuz1enG5rdJjtcjdom/aYEiom9z0o+0vIYGA==
X-Received: by 2002:a0c:99c8:: with SMTP id y8mr2402135qve.35.1611605292326;
        Mon, 25 Jan 2021 12:08:12 -0800 (PST)
Received: from [172.17.0.2] ([40.70.79.89])
        by smtp.gmail.com with ESMTPSA id o76sm938806qke.104.2021.01.25.12.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:08:11 -0800 (PST)
Message-ID: <600f252b.1c69fb81.e1907.7059@mx.google.com>
Date:   Mon, 25 Jan 2021 12:08:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3013722095532034460=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v3] input/hog: Fix double registering report value callbacks
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210125193354.742-1-sonnysasaka@chromium.org>
References: <20210125193354.742-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3013722095532034460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=421289

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


--===============3013722095532034460==--
