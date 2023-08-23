Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70733EE49A3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 13:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjHWNPc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 09:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbjHWNP1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 09:15:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277D10D0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 06:14:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-410a67193a9so10248111cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692796495; x=1693401295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+tSIw5mv6fgYFftBLatFHSQzM3BYq0jT8gz0f5+yI0I=;
        b=Hu/uGiO6nz9x70isKmFnUbcym8bmR45nbZmtLzwXqCm3Olwxgeyb2efPwDgabEMyGe
         eiTXOoMJa2F/wlvOBBZj1szJ7XrtcB9fVJ+3SQFBZcenY5ITh7hxs46//9WMa5IJS3Hx
         kzPcpzLGAt5J4xykEXUvsD0gCjh5S+JBmaSSx/RkRPf+f6ay+rqWtBz1z2BUYYyMjRJZ
         Vzpngw4bAMofwJkEdkm0nXHI9fYsJbM5JamKmZNn3Wn6QPrHvIuQpckEwMVb/DPVpTas
         yTP09i8aSqBDbnZrpXUeFcL2wfoU4l0184r4yAl6aAg/Ys2lZrV706RQ8SU8kXFxwGCM
         kt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796495; x=1693401295;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tSIw5mv6fgYFftBLatFHSQzM3BYq0jT8gz0f5+yI0I=;
        b=UhBmKniFzMQmd9KAmF8blkfiSjB/4dRcbI01nj7tUWBJoQovfVgFrk8jQfALdRYg66
         ljpmIzSzHvszR+2YxVnss4TZNGi3PAo+0py+60Dzl3mqcPFe0/2jADrHPiTNr5cLNiVA
         AbWdJ55x0cfurotq2flxqSRjg5lOuWfLhaDGU465548kytgaxcR7xPr4t/Sxy87/xcFY
         XhJ98hB0RISqRFyD6aSb2/Ug37FmTRGuq48qpiJL0SBRh11nYIcAeWIj1crbCz3zzHgt
         gLJnO9e1fEAG28PtnXWe1yjBu6a7YXFeq1F5esmJ/PHwrgYJkc+YR4JN8RC85vVI5u7a
         nVHQ==
X-Gm-Message-State: AOJu0Yx7w2vJhXIV8kmap4vy4npoZD/Tb249Koe6DB7+1dKuMgcz3jwJ
        mpFmXs/8NWw73FvEdYN3zKKGuq+BVvA=
X-Google-Smtp-Source: AGHT+IF+MV5ZLhJE72phkS6FlQESYJTqARbT3FKUHYUbBblFguU6fP4u9oyq94MOiDOUY3TfDkGVcQ==
X-Received: by 2002:ac8:7d84:0:b0:403:df34:9575 with SMTP id c4-20020ac87d84000000b00403df349575mr13946663qtd.34.1692796495144;
        Wed, 23 Aug 2023 06:14:55 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.246.179])
        by smtp.gmail.com with ESMTPSA id b10-20020ac8678a000000b004009f6e7e7csm3687241qtp.31.2023.08.23.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:14:54 -0700 (PDT)
Message-ID: <64e6064e.c80a0220.5768d.f922@mx.google.com>
Date:   Wed, 23 Aug 2023 06:14:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6377231896421659983=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, by2239112@buaa.edu.cn
Subject: RE: net: bluetooth: fix consistent connection failure caused by the loss of HCI_Connection_Complete event
In-Reply-To: <20230823125214.5910-1-by2239112@buaa.edu.cn>
References: <20230823125214.5910-1-by2239112@buaa.edu.cn>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6377231896421659983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_conn.c:2886
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6377231896421659983==--
