Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE8C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 04:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiFMEUg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 00:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiFMEUf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 00:20:35 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFFDE75
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jun 2022 21:20:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k18so3147915qtm.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Jun 2022 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=zQagMORb787aJB0Kv25lsndXpaISHyfRKfVjsOSKCIc=;
        b=P7NR0HYZixRzPtBMt1Q0n5zov0m81lIPD09n4kAyvjIwQNVCtY4O9bTOXBO+hhJDNj
         NOLMauqD4/fa39MRIn4/JrYtHfmNMWqxcI32n4t1RejPTNCvrjT/cXefkosSEpk54Q9I
         9SJxl/pcrB2NX/zOp823FWWmKo9Yt6t2aUUuLsoFgeag++KwOW9wHjHiRXx+3V++R2Ct
         Ewq7UnhFMR2zFltBooG7B3dVfuXr4HN0LgFGT91gs+YLjcZYR/SIxQxovN7aIuzGUZ6D
         3ZAjSN6FubU6ttx7xgeOsH+iYQISQFWYctgY1FuuIt0Go7Q7eyf0c2Tfb4c60o0Uy1DH
         beDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=zQagMORb787aJB0Kv25lsndXpaISHyfRKfVjsOSKCIc=;
        b=DwjVdZc1EA1c/JlCawARQjf0Gt5UEdhZqfmmVlN10SMYcSKngJoE32DJtLDRfQABg8
         Ui4nFuCcsqf/Q0wQamNOIMK3H1+CYmGVAAxGiwskQot8LbqD3IXtl8nU5RwICgepZWf6
         Z0GyIJQ1W2BZqQYc/ScW+0/heYkoxM4yEda2WLPBMkxwM6oqPfl6wdNq4AJYeelaMHfq
         GFv3VcCMaABBlDF/R1UaXpXwGST01FUgWGkoOacGPh0x/VRNnBJZSrQ6R24WFGzxjxTR
         o8hclGjfHTH7fG5uJof2ftU/tfGNsDP2hCEqmfEA/CCgniCBkZwpYdXdFXOwQgEw9V1P
         /FOQ==
X-Gm-Message-State: AOAM531XcCxaRF//ibE0OeH9VCiJiVxR+iHheVlpiL6fetNTJLSYe7+7
        eSJryIDDgDtmeVqBS6ENvrl0wHq4ftO9UQ==
X-Google-Smtp-Source: ABdhPJxN8cgLfoS0swsd/+UL1t/sdOb5fDxlncwLPybrly7eC7iPD7uhXNSZw7QECU8wb/pyBtjejQ==
X-Received: by 2002:ac8:5dd1:0:b0:305:2475:33ed with SMTP id e17-20020ac85dd1000000b00305247533edmr7616617qtx.357.1655094033286;
        Sun, 12 Jun 2022 21:20:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.240.58.242])
        by smtp.gmail.com with ESMTPSA id z17-20020ae9c111000000b006a6f68c8a87sm5425920qki.126.2022.06.12.21.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 21:20:33 -0700 (PDT)
Message-ID: <62a6bb11.1c69fb81.10a93.76ff@mx.google.com>
Date:   Sun, 12 Jun 2022 21:20:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6224047688509747275=="
MIME-Version: 1.0
Subject: RE: [wpan-next,1/2] 6lowpan: nhc: more constify api
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aahringo@redhat.com
In-Reply-To: <20220613032922.1030739-1-aahringo@redhat.com>
References: <20220613032922.1030739-1-aahringo@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6224047688509747275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/6lowpan/nhc.h:66
error: net/6lowpan/nhc.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6224047688509747275==--
