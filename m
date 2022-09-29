Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED075C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 22:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiI2W4U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 18:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiI2Wzy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 18:55:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3B11ED48
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:55:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y136so2709733pfb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=OZyAEByqmxQXajemeHLs7IQKuIHmW2sx7CZZ3YegkYA=;
        b=pV7YZSBcqikMYThdaYwc05/iXdE82tTnouctNnQ9Ejv39j3GVoLYps3VDA6pn1bGEt
         gowmR5epjMbLkS7Go3z02fcgfrTg8lXT/QQw7uw6CLaxP57TxAmt1414k7U8ItvUiHAf
         EtzcuSjdqCdPO9LJzKJdwO7Lkiq4Ky5eQlfIrMTQJrcf9TfdS58ggjUyPPXrY0PZupT8
         l6+7UKnuuPqSfXgkWYDENNKRinvilbI2YemT4TREu7Oa8yB/sYingOkLWdXxa8xBZmup
         N4Js+H722D60UcNgbWaF7ZyOS/CJEoxXxCFdj/xM6LqRmLUlby4gwqX3hh7YIBcA9wDJ
         WLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=OZyAEByqmxQXajemeHLs7IQKuIHmW2sx7CZZ3YegkYA=;
        b=1AEYd24s5JAScUPP7D91j/r+T+g8/IiG6h41roO07Dc/mEAJZQSznAWb03328vhcg4
         qfc/+DnUj58phh30wJePkA4Stat1vn3YIDzGttz7dhulMJ00jby+dp6qrBrNud6BWw5j
         EyCFS+C3IGgRrlak/f/E7izDR6IaxcaZ+Mr49tHqtDHJa5F4GdTSRxkW28SvhcUdftvi
         uw8ZFEhAV4OBSqvKDJ1wL4mHH9HJvRovtFwIzN/xgom6zQ5FrD9Ogh9SSvHQkHu4hYcj
         Sn09iOLCB6Pq8Qnz+L8IXDRnS43esH0A6vwnsHXg/zusML2A0gtwydnstCRzDDtbFIpY
         Knag==
X-Gm-Message-State: ACrzQf23aMP78d6z6yr5NO7h7w9W72C/gZtjycB+dWTol8eZBfUH/a5r
        DYN59HzMiJYHCFIOYKk+Tl/u0xou9c8=
X-Google-Smtp-Source: AMsMyM47jrtBwNZkW7X/5A16mavK4OXaiMngzt3Dst3jip5HIBwwBIRLROi2xObDnVa+RobM4zmQfg==
X-Received: by 2002:a62:2983:0:b0:54e:7cd5:adb3 with SMTP id p125-20020a622983000000b0054e7cd5adb3mr5739963pfp.38.1664492133515;
        Thu, 29 Sep 2022 15:55:33 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.38.202])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b0016c50179b1esm411601pln.152.2022.09.29.15.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:55:33 -0700 (PDT)
Message-ID: <63362265.170a0220.2d0ba.1094@mx.google.com>
Date:   Thu, 29 Sep 2022 15:55:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3697506807229639617=="
MIME-Version: 1.0
Subject: RE: KASAN: use-after-free in __mutex_lock
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
In-Reply-To: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
References: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3697506807229639617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 6
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3697506807229639617==--
