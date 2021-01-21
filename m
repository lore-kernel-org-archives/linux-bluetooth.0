Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7732C433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jan 2021 03:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AB5238E5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jan 2021 03:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbhAUDzi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbhAUCAR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jan 2021 21:00:17 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99607C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 17:59:36 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d14so289012qkc.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jan 2021 17:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=YBCiRbxrDY8+Icfi3m4iMTuNQHIgK1EP9HEuo4jnKoU=;
        b=WMwAaHed6/YGkQ6B+8TsRc+a5jAothRIXsPlbv3FSWtaUpXI+EHxOQl+nY2zrAi+mE
         hy7K8Jww0ZpQbcUWGjAOVqEDpHZHAj/OOSQJbR7i1RB0ug0Gn55MEN7UJRrMXq49lb6q
         XCi/37HUT3MpBsq/5RCzdrK5KXgGRkaEKSbRSrzPnGLHn9xZPRzTxF4hBWGBISGZG06u
         pEQThfVwkC13h5zK/g4JuzpAQ2kmoLlMtq1hDlsfVW9F0ghYipG6hyGtkARbNhz68oH5
         sFQMCjNn5pbvy1CO7qJvRzMhCMWR0Lf1ZfmDNJNmA985Ho8zXiXxiuoD7aP5wWODdmw8
         txeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=YBCiRbxrDY8+Icfi3m4iMTuNQHIgK1EP9HEuo4jnKoU=;
        b=uI70KSnEslqhmq5MnX0nqwO7vgpxG0CSstgBWGA8ScjjVlslN9YMGVNPZ7oIZMdHMd
         v1pGKh52kXtXitFLZczktnqAW24lpeK5HZGTayIGqiHRFdv8zw4ZxZgnUoqHWKQt3XF1
         WlGWuK/b19FUzeab+9LWHHRfINRU54+S7VhPeuKVnQe1d/QfdqGYZ8TxhbDRNatbeowr
         uGVLNSRXibML2b397q5kDDcxhDCQclHXokstVGDlgzBCTR0GHJDjt76CPUfGEsccltrl
         fJOC29rfw9dx2x/TdLoATO2xV4nTUso1Vryv+fdpRd66pHm31zdlg7s6st/jBiIw6l29
         ZTAA==
X-Gm-Message-State: AOAM530tFYkH+VQZwxJpFiviKqVgoiCa70nGiMhjLlN3TnUCaoc5w6fw
        F+Gzxqmk6uNw3GXlsL/G0K32xhR35Mrr7w==
X-Google-Smtp-Source: ABdhPJwhnd6R0JDC/xbHGyZJRb4FsREtrzpnYHBE8Uh+eMSv6Ilfc2YHaJyNbvL1WZnBofkWRLhXTw==
X-Received: by 2002:a37:7104:: with SMTP id m4mr12779055qkc.5.1611194375655;
        Wed, 20 Jan 2021 17:59:35 -0800 (PST)
Received: from [172.17.0.2] ([52.254.87.186])
        by smtp.gmail.com with ESMTPSA id p128sm2691165qkb.101.2021.01.20.17.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 17:59:35 -0800 (PST)
Message-ID: <6008e007.1c69fb81.8873e.1167@mx.google.com>
Date:   Wed, 20 Jan 2021 17:59:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5108998175156914355=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] a2dp: Handle remote SEP disappearing
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210121010955.1193543-1-luiz.dentz@gmail.com>
References: <20210121010955.1193543-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5108998175156914355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=418663

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


--===============5108998175156914355==--
