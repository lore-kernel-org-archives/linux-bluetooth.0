Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C27C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 06:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8859461921
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 06:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhC3Gn1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhC3GnN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 02:43:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3260C061762
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 23:43:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y5so14903747qkl.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Mar 2021 23:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Kec1FpOZXWrbEQ1bDJLtJqXTKQngl0kjSBNanAS5WRY=;
        b=IT7q3ugJtr2PWm4j5d6LtsEEej0LChja2GmrmizFLwnOJVFe8sSKzzwePMFZxWxlk0
         FG/8WvW40FHx4LRlh6L8OUX4e/XLtiYWBJ635jSA8XivVg2UdWhqPqqg6JbubAi+Bxzo
         TSE7LS+bCk1IFBqbd/lLbqlnSxY8+DMtZRBVuhzbRz39UCioDgWa1IVj7/eju562SEHm
         3vORYKuD0AeS1SJ23GeQVNXzUhQtDV51a5qCZWS9NH2i6IJaRujU8PkhBg8Co7C6BPd5
         ChXYnA0aPYYhRF1QbtmQ+awJpQVz7rSfS9gGqVAA8AUqgEvYnXRry+cuEzs7979l3/YM
         dnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Kec1FpOZXWrbEQ1bDJLtJqXTKQngl0kjSBNanAS5WRY=;
        b=WhK+PCN/LxVQppxMXYrjT6BiqBMjcTVVre8xZU6nBZZgzTblj6cZSApgU23O2tB3/X
         49oUri8/x+6Sjb1GaVWbNLErCZqFJSWHMlu7ZyfqFSe5O0ZORs2zGXaEBYYsnZoVqI9n
         6CawGxUAbM4Bi5zxkUZS6ZqAW+rCjeHTNei1n65JwqgW+0hM+yAojaAaUygIGgFKZmVg
         b5sHiURYt2XJj1LpsOYgcnjHiJpmyu3fg+ByU0EFvQ53/fuE+5ZDj7/rg5yl/TC4ZxSk
         0mVSR7tiHD2JaM7IVOP968tnSYlTLmLMeHpILrZDLufAs8toN6GaKHHKsWfXksHwkkpl
         TSzA==
X-Gm-Message-State: AOAM532qlrlAzxkN2n3s8toUSTLaKYmRbLX/ukExXzlVsh0Ydhvkrt3n
        XWEHUM+CuoP2mpNqctccwtCKUYnxJKv1Og==
X-Google-Smtp-Source: ABdhPJyEp1hLzSYKZ6iqlkKJGt9TKYJ157MNHVN4RYJvv0+LbRIRFPJL8h4a/66obkIVFZlc3WJEJQ==
X-Received: by 2002:a37:9e50:: with SMTP id h77mr28754979qke.138.1617086591923;
        Mon, 29 Mar 2021 23:43:11 -0700 (PDT)
Received: from [172.17.0.2] ([137.116.47.68])
        by smtp.gmail.com with ESMTPSA id 84sm15268688qkg.8.2021.03.29.23.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 23:43:11 -0700 (PDT)
Message-ID: <6062c87f.1c69fb81.a55c6.d49e@mx.google.com>
Date:   Mon, 29 Mar 2021 23:43:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7784942613921554966=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [bluez,v1] test: Fix AdvMonitor RSSI filter properties
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210329231544.bluez.v1.1.I18e234e0b4d11e2ee24a699e70bde7e0a84b0be7@changeid>
References: <20210329231544.bluez.v1.1.I18e234e0b4d11e2ee24a699e70bde7e0a84b0be7@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7784942613921554966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=457825

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============7784942613921554966==--
