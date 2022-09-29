Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DCBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 21:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiI2Vw0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 17:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiI2VwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 17:52:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D8B12756E
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:52:24 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s18so1637430qtx.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 14:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=TEbqd+9T9CrpzkZoxY+sWFzesC2SPCnI0ArGsNRMx6A=;
        b=lDSmumaVHYMt/YH3yXK0zh6W2F3ldG6yktoQhoDGzNn9niZC3r7NEP+0F5e9s7YZ0e
         JZTXxIldt2m6BU7D56Cl4lqp5gwx1zJVMC+n6dZcs5avLVl1QfNjQg7SpHsp5oFxp9Kd
         s1tMzBLoylKFufhNUBZN6Fcs/D1DsvgPK0Icob+yf8df7TYfHPXAhW/il3uHuEz2p60e
         1h8lvey3VsHxAdy/HCmZd+3HMmA+uncBAcBd4NqYkwSYruJLBZKUJvfy56Czak5pACbD
         1TSSDAtM1av7MNU5kJC8+sJLoFkaGkWModFp6A3iqc7Qpuh344IcZvIo6/rR/08IY1dR
         zUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=TEbqd+9T9CrpzkZoxY+sWFzesC2SPCnI0ArGsNRMx6A=;
        b=pIRO+Y9n/kkDACwOQit2soZT7OVrOJohn4J9po2mPF3pbdvfM7uXu+ESBHS3RB+X+v
         MB9Wc8rEzmvmOEoFnPj09mXHE9TglJ3AhVw6Ca7AHGEIsgKHOvdFOZU9Njjr9CA7yg4/
         7NFFoXpGrHYJ7oO1LYO+6SLeALqQXPVYBHk+ve3crS3wM4m0O/v6fltfOFFE//PAQrJb
         CePuwb9ysWY00EFo9C3NzZ73SAAaPl1QqiGyEaxuxQv6A63/lJngbKEj3z/zQaL3uXT9
         CC/A6i0p/F9B7AJAgDT1mLlYBNDqX3QtsXYLHky0fZtpikVy/733VPxo63YdkvCiKYwF
         KLBQ==
X-Gm-Message-State: ACrzQf1eusc0nFARcPfwBrr4BSz9fAxap21ejXegX6R1ZAzX4P0iNP1P
        9A745QoRKjwYS7aaakycS+31yrWns/qoFQ==
X-Google-Smtp-Source: AMsMyM7lZNPyyyZFj+3oXjbUvtedYnckB0hCIPsHH2rWrxJA0V438k0J4F17ZtDSTE8PY0faAxlkuA==
X-Received: by 2002:ac8:5f53:0:b0:35b:b155:1c1f with SMTP id y19-20020ac85f53000000b0035bb1551c1fmr4390607qta.148.1664488343204;
        Thu, 29 Sep 2022 14:52:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.70.189])
        by smtp.gmail.com with ESMTPSA id t123-20020a375f81000000b006a65c58db99sm537093qkb.64.2022.09.29.14.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:52:22 -0700 (PDT)
Message-ID: <63361396.370a0220.9819a.2064@mx.google.com>
Date:   Thu, 29 Sep 2022 14:52:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4136698689902185170=="
MIME-Version: 1.0
Subject: RE: properties_changed: check for NULL iterator
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ceggers@arri.de
In-Reply-To: <20220923145602.25872-2-ceggers@arri.de>
References: <20220923145602.25872-2-ceggers@arri.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4136698689902185170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: src/advertising.c:1055
error: src/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4136698689902185170==--
