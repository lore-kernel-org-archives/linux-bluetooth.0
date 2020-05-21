Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F91C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23EF207D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVJ3HlET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgEUSHx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEUSHw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 14:07:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803EC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id m64so6246772qtd.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=InRHJD6A4p9nf1l6nnGE6qapJmU67IU+yXKURYzepa8=;
        b=uVJ3HlETLFOp7GO9tL85gBpozguRh7v6OZbUxBmUF99HD51Q3BHxCTJzf8/tgDoCFg
         aAg8lHd+92AS79LKJpSnBWZUMLhG51SKXfXBdC4P/3Jy5dpFlH5/ArEfIAgd2QqkUdpd
         66MZgBgP11i/9+6vKhSejkuHM1B1BTXkAXGlde8A7nm+mHw073epk7C2NDvLfsPBnyRs
         D7HrQBO6V85sv8bpTU6L4EHsszQMaHy2o/2kUbA8ob+XVvb0iPEAr5eCJB/Fkm50MpUG
         Vs2Qn0k4jQ/fbU8Sro81Z3k23Mit1Bx16GU24azEy//ubHhDcU8IX20y0+yMFRDjYQaE
         Y84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=InRHJD6A4p9nf1l6nnGE6qapJmU67IU+yXKURYzepa8=;
        b=aUvgtByqmn72KDu8z93/gVgzPLpw8JdsQWn6D+Lt3bCqDwz/GV0ImkpRg5GS0+oV5b
         HwqrLrw+gr0Cte680itwjFc65EvbIB1tlu1zKUI8tDifcEISu3yN9hGO3YDmfxNaaS6p
         Je3JY4qusnjmIQzQLGLJnzxYmz1k1Ym0c2L6DtG0Ey0G7NqKxXplI+EWCz4jXgyxIXrP
         UlnHN1ZhkslIYe/omy+yeeLNiN6HvkNcC86rlYmZ9j3rXNqAP2+QGhL1tOt1mlHPiyN5
         oudASaC6uKKC7mDsmKx9Y/jvLUq4jBtLmJTVeruEyKF3disiwXU7EcHXGmKkdco33kay
         MOTg==
X-Gm-Message-State: AOAM532oW6/oIhezkl7xfTRxJRQRvzjUJR1Ap1Spocaq4JjB74a6BQ2Y
        kZbjJ5xGt4aTvs2kYQxzx7grpJsS
X-Google-Smtp-Source: ABdhPJyTSIXWbJuJL6o3qSD4ehILlnik0fBAYeVEEZPYvbhsNibC+vMBgAm71Lza6IwFYx1ArxYXWA==
X-Received: by 2002:ac8:6159:: with SMTP id d25mr12099754qtm.70.1590084471765;
        Thu, 21 May 2020 11:07:51 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.124.4])
        by smtp.gmail.com with ESMTPSA id r14sm3772563qke.62.2020.05.21.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:07:51 -0700 (PDT)
Message-ID: <5ec6c377.1c69fb81.7e460.607f@mx.google.com>
Date:   Thu, 21 May 2020 11:07:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5015515417313274027=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [v3,3/3] client: Print device property "Types"
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200521180101.8223-3-sonnysasaka@chromium.org>
References: <20200521180101.8223-3-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5015515417313274027==
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
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============5015515417313274027==--
