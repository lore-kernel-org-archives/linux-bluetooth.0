Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 21:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442181AbiDUVpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 17:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442178AbiDUVpk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 17:45:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF454CD50
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:42:49 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id x24so4258373qtq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=5YLtNwqsF6hxwxpyHaCLGgEsjx5mYJ1vj/uZBrT9PqU=;
        b=K7T2m5BucSqNko3XUNLjvCzJluZ7avrdKwDrlHXNBkJDNjaE+Sop46tkB/sitcLLjz
         snpOPN+/ONosAmGrJK87T7TM+9OE/C5mnj3bvk+KW0/kJPkADRHvdmWbMM2GKNn/tfM1
         YlU9bkMNsu1tq6MZPlEaFPzlGu5zdWwyLGCt+MetEJ3t14tP4MXU37G2/DJzrM9yjCEp
         nQjZV1WwmYS7jskEOClBjnAKa2Jk4Od7iD1DPFyW3v7Ij4DVBDU6utUhiCb0Vpvs8zXP
         1gZTktMsb5z+47uNt+RRYJ2tdkiHqjUxfUcTEdotXdnOqq5ut+dg0acfsB8sb1Loj470
         m1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=5YLtNwqsF6hxwxpyHaCLGgEsjx5mYJ1vj/uZBrT9PqU=;
        b=m2cuRpaCRlsHWGSvKDR27sKpajjBod0aL8v3lPcBPN2VFkx6EwDlLCMdHQT9dAtl2/
         ruIvv48CEIqGDTCdb7m5vzKaSSkEm6HOdkJ30OqQ0LMb8Mij6g069HbchWpXXzu31yzW
         YQkM5Udw24xJDjPkCHn7jRgJtd/lwkezPCgrKHqbvGJlSxO8Av+laoE7Cw7ZSPLjqD8o
         ERdEJveeRThPmqASZcQTsBenQ9gpJOr4LO0bLZJVyFQb/Cy5r71b5jF/UKBvDQIGL7jV
         0fFZYOkFq/+mbUtFq/9wo9U8Y8jG46SK72WB+t8jfZ3wiDvhJoV7qdTKKcEnNWRk06+Z
         LM4Q==
X-Gm-Message-State: AOAM5324kJJTkJWx/GLfu6bel66rLmFdlrQPyXp+C0AU5lux/oK+JXkT
        wCZydsOf/R4rRAO3qwS6YZSU71M9bwNEQA==
X-Google-Smtp-Source: ABdhPJxnTjodjv028UvgsWlACRMLVD1frNDlxc5bzGRBHY15Uo+u9S6OYfgGLdbMpwJnaPQMuL/dtg==
X-Received: by 2002:a05:622a:214:b0:2f1:fcb2:1b9f with SMTP id b20-20020a05622a021400b002f1fcb21b9fmr1113821qtx.508.1650577367724;
        Thu, 21 Apr 2022 14:42:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.242.68.140])
        by smtp.gmail.com with ESMTPSA id i123-20020a378681000000b0069c73915781sm61228qkd.120.2022.04.21.14.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 14:42:47 -0700 (PDT)
Message-ID: <6261cfd7.1c69fb81.f0e15.05dd@mx.google.com>
Date:   Thu, 21 Apr 2022 14:42:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6226664464990121735=="
MIME-Version: 1.0
Subject: RE: Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220421213309.3304447-1-luiz.dentz@gmail.com>
References: <20220421213309.3304447-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6226664464990121735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_event.c:3178
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6226664464990121735==--
