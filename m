Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF2EC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B614F2078D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 08:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwi6yygM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHUI3C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgHUI24 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 04:28:56 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B1C061385
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 01:28:54 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g26so733844qka.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7MQPpOTbX5csooEfwnHVSCw7zchY6zqWZMxc9Cy4IOw=;
        b=dwi6yygMLaNPrW5W0IcxWHdIDsGw7p3hdbaD7SpxcGo/dKwUvn18Cmu/uQEgDxboTT
         5LRNmRAyUv7fEoL1Rkak6Q1gga4eQtK+SqKURKokRgUkG88YmNdRETSs7O1KzMjiqB3e
         FLKvv6aQGyEN1Xbp1HYGD3fuTekreWtxI08jfEimlgysuvmFJl+w4UUohhhs7F23wf2E
         Rcu/dTFeq28/0AGEoyZe4JprH345RxNXyZkLXnDxR6vxm6C/bbQAWhQIPrShR4JcT0lH
         EqS+Qao78RGP/5kJoNmW86b5a6qyUHXgeUZoRBRqsrin6oPA5qAAwYAOp5GvntVIQ85A
         SrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7MQPpOTbX5csooEfwnHVSCw7zchY6zqWZMxc9Cy4IOw=;
        b=exAF7P8yh1Zvpx4L6RXcAdNCURUMxoMcIgGRyCIWimLdPeqWzTji/lnq6cMyA1zWJD
         MTASixR4nHDyOU8v5Xjmzx3xGZYw9Df/HPpnk0epiYxvD3VQmg67DUmwgPYgb3nC3xtb
         6sXhet1gCyqTLloSuxqmzJ8QlNv4rTA/wRItW7wcF0M1WZEdLMgrqrFUN+tbxZ2j5LQn
         uj8PxElapO/fbIAFsxnkj7REzbuI/o1cBu6Eg8+a9lIFvEfBuuXLa1wNhund0moXFUHe
         TvRbkKF1aGaYhkL6Yw/oORdGDYQ9tm2jfjbxZP3snnvHxI8wxs+/tvYspUPNb3+F0XP2
         GMzQ==
X-Gm-Message-State: AOAM531N3CaKykeAsuPsfsAnJvesyYUMDaSOZ9Amfeco3d8mTQrmb9O5
        A/aPsNBx9spYFxaqnpuaJ71YBCwQoXcuXA==
X-Google-Smtp-Source: ABdhPJzMET23NDbBd3/WGF8u3jEmLF+5WLH06XvcCMTYAaeerCg95/19/j4D6OHk3Gucj4itpWzW8A==
X-Received: by 2002:a05:620a:38a:: with SMTP id q10mr1783838qkm.382.1597998532276;
        Fri, 21 Aug 2020 01:28:52 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.173.203])
        by smtp.gmail.com with ESMTPSA id s124sm1103916qke.102.2020.08.21.01.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 01:28:51 -0700 (PDT)
Message-ID: <5f3f85c3.1c69fb81.b01a1.3a86@mx.google.com>
Date:   Fri, 21 Aug 2020 01:28:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3923685707088330364=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] sixaxis: Fix a crash caused by the return of udev_device_get_property_value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200821075514.20406-1-sonnysasaka@chromium.org>
References: <20200821075514.20406-1-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3923685707088330364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T1 Title exceeds max length (75>72): "sixaxis: Fix a crash caused by the return of udev_device_get_property_value"



---
Regards,
Linux Bluetooth

--===============3923685707088330364==--
