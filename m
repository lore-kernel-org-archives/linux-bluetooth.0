Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8C4C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbjKAKNN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjKAKNM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 06:13:12 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0C101
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 03:13:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5ab94fc098cso4376691a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Nov 2023 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698833587; x=1699438387; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2qwXzsl4lFfCZNuHFafr1w/ZTVL+0DPvsbDagATcYU8=;
        b=ANKU/psRkh9N5dC8l9Mu1N+YlO++F6x86+7Zr6GyMvPX615k7HTxY071mVIJ/5LX5O
         RLaQenX50AFaEAQf1/nQ4MEzdpjRCxOer3RrVbkHSlflu1m0+fqv5zcZcT2Yg/o165Yz
         /k8e4B3mRIpeUPJZUFHGFl5lFxNkYoZ3BKjYj0cYkusyL3gqdlpr2rpgkNmJffR40NoV
         9HFtJt0mRfupkAZraISFQKuSNq1o0YLvBkU7Y6YLrQYGcjM5xSeX99AQxh9BVzRUW8pO
         1aHFtCa0oDNZlpExca2igN86cP3xshKpN0IbHfyvNe1C9SBzgmJ2MeHuXWC+hrnXFP+P
         QT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698833587; x=1699438387;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qwXzsl4lFfCZNuHFafr1w/ZTVL+0DPvsbDagATcYU8=;
        b=veXntX6lt/yynDIz/yjmAUa01XKsFCBERQ8fSd/e99ciZQQD9bkGrzde5WBb1bLwYu
         zKvxM1KsPPPXjkdtTV1ByVNFE5Rgs3x2nMMCNjo11teqq+QVzydboqW0wHmMM7W2ykCN
         +twS/upJua6yt1G7zoWiSmzK5alqQHGNLfuug636MjMONEfnztiCaW7PQqWyTdFOmTG5
         f0bcl1khwmbYmmBfTZ1adAyoWli+g4EtgGJ8yPBWkKDjWCR5iJev8kTA2UUHhmaonqLR
         cmKa/fdGUSvxDh95cnoAtw8TQymr+Sl5g8RmQjOzEHERh9pF0lExN3V6+EIigP8aqPff
         24Rg==
X-Gm-Message-State: AOJu0YznRZUPDEAAyayyWMj7ka5iZk1ILwb3bFdbxrSVU/RssAGv+bxa
        JgmneylcXg+H0pP4+INFpttKNrGYQU0=
X-Google-Smtp-Source: AGHT+IHDXaNlyOPZJNnsiUOQjTIUdZ5elqePgzxI50sX+6qw1dVqZRfFDgGzjDTHG1zqTND4D3PcVw==
X-Received: by 2002:a05:6a20:7d8a:b0:171:a8bc:74b2 with SMTP id v10-20020a056a207d8a00b00171a8bc74b2mr15338134pzj.7.1698833587582;
        Wed, 01 Nov 2023 03:13:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.76.156])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090a34c200b0027d09ba2f91sm616830pjf.34.2023.11.01.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 03:13:07 -0700 (PDT)
Message-ID: <654224b3.170a0220.89e94.1279@mx.google.com>
Date:   Wed, 01 Nov 2023 03:13:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5670480573075212373=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tom@baremetal.dev
Subject: RE: [1/1] Bluetooth: btusb: Add a new VID/PID 35f5/7922 for MT7922
In-Reply-To: <20231101094043.43294-1-tom@baremetal.dev>
References: <20231101094043.43294-1-tom@baremetal.dev>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5670480573075212373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:644
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5670480573075212373==--
