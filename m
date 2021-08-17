Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CDBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 19:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7861060EBD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 19:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhHQTNZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 15:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQTNY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 15:13:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69739C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 12:12:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so164795plh.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MBsWNFkhIMUBFoI9YTzfePmiLn2xI7as3ABGeK/kjqI=;
        b=O1LZPXuIeDzn3YOmcIi6N1JLPB7lHdRXDl+5IB4D79u04evRc1uStKAvdF7B3LGg5B
         hxwKPQ8hFMx6ibvW2+YFYjm7ar4bfKLdrIHbnzGWe9bwgY4FBibyONbHzrK9rf2sN5lD
         QE0VyrTbKG6AsbTsg8bvUAiqm4G4KfhuCH9Qh4iftVjs+A017DfLyjy8bbx6VFeHUudm
         2SLBGU+tXIsVP9M1+NYLuzmwA6Fmi6cYRBHwjTzVVnMT2ZQffu2USj+PD0k9QqR1NWBq
         VLr+wMEFxlKQLS3e2Vi+RX8yU8jelHqoQDBruKmhyN2tINtf+4tNe47C4837I7jQ7X2k
         2MxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MBsWNFkhIMUBFoI9YTzfePmiLn2xI7as3ABGeK/kjqI=;
        b=Z0uyLfLTL65ABQAXRIQlwosRL/BkvTsTTpWb2WAD9TVBsnde9kqv/bfDZD9FOmPIN7
         8T5KZ5nlKR5E2E8aocdm5XdbaumM/Es+zkPOxx4x0jNBGQeFMEhWwl2FVXkYk4DXvS7P
         HO9Qv4aamGYagQE8RP3X2iAAuzZauM08noIdvlmsU2BG/wMwHxko1HuyeCjtMDn7T4uV
         JF5udkT3VBFWb1svLOIWFUzvQfPvF4lpB9B9QY6cUKZmQAFEFJ38r7wHh0DclmorpoLF
         QajbIcuQXItVWzJwpEUl/vYJtz67l+fualcKeInyp1eb3KUQxZHl60+5Qc3nJl6HrNs7
         dW5Q==
X-Gm-Message-State: AOAM530R19fyEF7dFfGCr56hbXofDGl3Uc364oXWpgcNFY9QUWx7sN7G
        29KuougGwMfbh0yXkoO9FqDUzzlT3R8eF7VA
X-Google-Smtp-Source: ABdhPJybK6McIiYqEY1NpqD1evT34ASZs9y6gffZvyh74Od7O/c9Jc6rLwmKgC0EOojbGnH2TjH6Cw==
X-Received: by 2002:a17:90b:f10:: with SMTP id br16mr5122210pjb.65.1629227570559;
        Tue, 17 Aug 2021 12:12:50 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id ob6sm2814461pjb.4.2021.08.17.12.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:12:50 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.net>
Subject: [RFC PATCH BlueZ v3 0/1] method to notify/indicate to one device
Date:   Tue, 17 Aug 2021 12:12:44 -0700
Message-Id: <20210817191245.10846-1-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello maintainers,

This is an RFC for an added method to be called over dbus by an
application to be able to notify/indicate to one device rather than all
subscribed devices. 

This is motivated by similar functionality in the corebluetooth API with
CBPeripheralManager's updateValue() method as well as the Android API's
notifyCharacteristicChanged() method.

There is a prior patch I submitted with this feature (12439517) with
style issues that this RFC supersedes. There are some additions missing
from this RFC that I can add if this is a feature the maintainers are
interested in the form of added documentation and overall cleaning up
the added method.  

(Also my apologies for multiple versions so quickly, working on setting
up dev environment to match style rules) 

Bernie Conrad (1):
  Added GDBusMethod to notify one device of characteristic change

 src/gatt-database.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

-- 
2.17.1

