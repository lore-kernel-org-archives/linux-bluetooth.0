Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEDCC56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 23:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892F42151B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 23:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svLWA02V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbgKXX2D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 18:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388499AbgKXX2C (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 18:28:02 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F70C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 15:28:02 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n132so1168335qke.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 15:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=K4GXyNkTIH9uKTXPUoZch9Ku81XMjzAVNkh+4Qm7/yg=;
        b=svLWA02VegYvvsgGh2ZVVJdf9rxzM4nn9hJSK/4Hb3juCqObXJyQ56aM8oup5fMP3j
         ryoeTXZyAI5A2WlK8N43+71Y4SmGJyBhLnGeuNlz56MqhrIc6GsvBQSPiRF3ngKZbVoD
         rVErV/1Qbb6caVt53Pxy5EVwog6Ghem7KRjnxdhrpOmu70bqyZpiz+5yHrzOrfdyjf2i
         swJHYQkKUpz145G4qM1Ema5wSSaYSR5nQE/mHfHU4gWQKyZPpKZmyxEt/c+7ietKVAdl
         ZJ0Yw12ozetZ5x6HNJWUe9pD0FBSD6FrGwGoI7YAMMQ5+0CrywIIqWecgMVcwqm74O7g
         +jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=K4GXyNkTIH9uKTXPUoZch9Ku81XMjzAVNkh+4Qm7/yg=;
        b=fUyaGuC7lx4fk5kacdZdqGJEC5krdmNs6Kj5K4JhSKSoBxatF/EdWJOrEehva/m4dK
         PkKLstbYx41B3hopJfWitTv4l+0clrruamTYdd1aT7U/lNvM0FDPnuJtIWlxfLVYmWjn
         XlqMsfmKnjiwwXLMaKwhzOZ9hzR8NYMOapGR84RiIQbpwf3vgMYFhIvsEda1Dkx4IODn
         l4Fej+D6mpcE/6/iPIUDy1aykxFd1BGisKVnRIIX2uBM7VZYX4pHJsc1ltOQ++h/SIAa
         3mqWlt3xmg3J4SNUt2NrZqiL+NYQ/MdU2iYwgZAgrcqEeE4eYBQyHRgj/WtQoch90R0R
         TUFA==
X-Gm-Message-State: AOAM5301BRluyXWkDeDXAKMvQaWuWoezq/JczU1cyoZahGK5GpfxI8ep
        Szkv7yvtQ5ujJcAf/c7klWjEJuoi6fNrZA==
X-Google-Smtp-Source: ABdhPJzQOU3LbQJ4ExeQI0x8WelCbH0boZng5h9Qj/gcwKCXMfdO6EN3vFuzMJ0dykPMbwGo3qtraw==
X-Received: by 2002:ae9:ef86:: with SMTP id d128mr686825qkg.123.1606260481822;
        Tue, 24 Nov 2020 15:28:01 -0800 (PST)
Received: from [172.17.0.2] ([13.77.109.79])
        by smtp.gmail.com with ESMTPSA id k128sm771528qkd.48.2020.11.24.15.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 15:28:01 -0800 (PST)
Message-ID: <5fbd9701.1c69fb81.12fae.4010@mx.google.com>
Date:   Tue, 24 Nov 2020 15:28:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6603422712466650437=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rpigott314@gmail.com
Subject: RE: [BlueZ] main.conf: use correct key for BREDR configuration
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201124224658.32605-1-rpigott@berkeley.edu>
References: <20201124224658.32605-1-rpigott@berkeley.edu>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6603422712466650437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390539

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


--===============6603422712466650437==--
