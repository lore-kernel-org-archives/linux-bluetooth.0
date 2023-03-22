Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C386C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 14:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCVONo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 10:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjCVONk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 10:13:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD4A5FEBC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 07:13:39 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a5so1079810qto.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0gOsqLtDbEmigJ3EC1RWtG3hqdgj+dqkkXfINa6dc8=;
        b=R7BXqJWPzwxULxl9D4nNPOrLNa3l3leZIekYJVwPxaeNR1FFnZQD7ElANJwnkgYTxo
         FEkbJcFkT+Rf83CJSozd3Q1NPJi6Eu37DDliSevFCGufvw3RKDtxx/L6od1bREASCIMe
         cZI5yFlL1bTH0xlyzZT83yMkWO1Qy7OWkijHb6y+uojNWIQiG7ZGjitJsYU/k5v+rNIJ
         vdyE/NbIphnIziXAsbNf6w9IiekwJa1L5UXxRrL1+SIoVx+BNGQGSHD0Mg6ll4pK5JmJ
         O1KdC2Ynl9aKFxLDBen8dffPfOOTTuLoa75uvbkPB+ffdYXU1JiPzRWm0oj2FNNCtK8l
         LfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0gOsqLtDbEmigJ3EC1RWtG3hqdgj+dqkkXfINa6dc8=;
        b=5B06UhA379e2ib332RPVXtGoM0a4+2ducXBqS+kVyyMxcbbqVCYaATVx8M81215RyV
         OUPDHcIR3zG3HztJAY1ID1l4h9+zuSDKfzECbWYNsTZ3Sg8Zf8BkRHYK+Zbqf73QAO6Q
         p75POA6iiCf5QlfgF0Naam2yEpYMw8s87cstvMNW8z4rd87H7Lqu+7tc0u01bk2CURWw
         YAeih0MtQ/2QuqHUJxCtFgMsZ/lI/sbxefP1bckHp0uzg/TG+yS/E25ZO9IeTd/sPhe6
         FOH1gtzeMyDBDTt2hg5lyQ8HNz1j3UIUQH/by1AJT0nXLMO2kc3bNw/dMyHnfs9oaOel
         5eOw==
X-Gm-Message-State: AO0yUKVZsVWHgmoUkuzHqzXgU5xQ+HYMeAGGXCEM9gC8yWVfd04WZkJM
        7846sBvqZuqrGY+un2+q5N/J3dN+l1M=
X-Google-Smtp-Source: AK7set/JIFwjMvJGuFWbtL3tgUShyG5m+jreCDZ4ifFahKPwbbFSuPVwpu5ABG/i1c8lK9lk8U+QGg==
X-Received: by 2002:ac8:570e:0:b0:3e1:7bb5:f0c1 with SMTP id 14-20020ac8570e000000b003e17bb5f0c1mr6618140qtw.4.1679494418744;
        Wed, 22 Mar 2023 07:13:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.156.91])
        by smtp.gmail.com with ESMTPSA id r9-20020a37a809000000b007463509f94asm7525381qke.55.2023.03.22.07.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:13:38 -0700 (PDT)
Message-ID: <641b0d12.370a0220.58a5b.a2fb@mx.google.com>
Date:   Wed, 22 Mar 2023 07:13:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8031494243607578676=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dhowells@redhat.com
Subject: RE: [RFC,1/3] net: Drop the size argument from ->sendmsg()
In-Reply-To: <20230322135612.3265850-2-dhowells@redhat.com>
References: <20230322135612.3265850-2-dhowells@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8031494243607578676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/xen/pvcalls-back.c:200
error: drivers/xen/pvcalls-back.c: patch does not apply
error: patch failed: net/rxrpc/rxperf.c:507
error: net/rxrpc/rxperf.c: patch does not apply
error: patch failed: net/smc/af_smc.c:2653
error: net/smc/af_smc.c: patch does not apply
error: patch failed: net/tipc/socket.c:2781
error: net/tipc/socket.c: patch does not apply
error: patch failed: net/xdp/xsk.c:629
error: net/xdp/xsk.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8031494243607578676==--
