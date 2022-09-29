Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4A6C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 23:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiI2XkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 19:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiI2XkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 19:40:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507193CBF3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:40:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l12so2561516pjh.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=hcZLh3dKCV9FHtk8/zluaalyQmEQTCqMTl8M07dwnN0=;
        b=RVcQZshZQRhXLQSQHktPloBZYnKfJM9p8ojTQc7j+maMUhaJNthauhVlDPJZUKizhM
         kR3UsELQICXLrgiD0i1PIUKkMWmwfFDJtJtE7qm7pPJqGQupqtTNg5ftvtqEpfum8Ism
         Jq8q8LDtG8odYuWpI9bLIwT9gncbsDMDWDhKdnXS+CznCj7ZkhHkGjSj4WMX38Wllunj
         1DYLIkJUcrZPVZnyJ7HyQeSD/H09CFawr+QUqIZzv8e8U0YRyoe6M8ZfvV1qObMmbr20
         Eid74n0HS+fbKkzfGN3dkY283okwucODE9LFjVEfNd0Xmgb58jZLD6dQOgDhPv/75u0Q
         Z1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=hcZLh3dKCV9FHtk8/zluaalyQmEQTCqMTl8M07dwnN0=;
        b=ejXu084buSsR5CCAg8JSEFDsZZchNjAVyGhdWLZBxhX7GJbM1eVT/FDnArD5fzZg+F
         fsNswHFDDGY1KDgaWlghZPP2AaVtv1cOeNzkMxvPttoVH31BRqZXnATaFzR+IGoHdmYL
         b4fenElGDs17r0R4YltMW0V1swN9BPEWaLjUgLbZFEeOHBmW3IAmDfkgeBlF8yR06AGw
         Iz5fRdnlDgCNH5IDl6z6in73xo09WFktF7Qg63y7MAzqFqjDiLpJyYLpOj7UI0wM4Ss0
         SiSegUZZ04m5/Ai6ZR9Z1o31B4asUDs7OqQtEd122pc7c2mP+Lo8xGNXbrsp0VYQ1Lnh
         OxeA==
X-Gm-Message-State: ACrzQf19magtQkrt7g/sD6M1JvqpT9HhXDpjp8g36e2ZcSKGvJmJGGdU
        5w7TjcjBNXUrcpIFOSy/ScXs98GIuxs=
X-Google-Smtp-Source: AMsMyM7voO8EwTpMG/KGIFafR1uyems0+s07xFHNoeznMTeko3q6JzTIEZUl70IX5A6Gpy7yvpVhTQ==
X-Received: by 2002:a17:90b:4b03:b0:202:eab3:e174 with SMTP id lx3-20020a17090b4b0300b00202eab3e174mr18434091pjb.12.1664494819470;
        Thu, 29 Sep 2022 16:40:19 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.213.49])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709026f1700b0016d5b7fb02esm470090plk.60.2022.09.29.16.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 16:40:18 -0700 (PDT)
Message-ID: <63362ce2.170a0220.836e2.15d4@mx.google.com>
Date:   Thu, 29 Sep 2022 16:40:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5302021729638443234=="
MIME-Version: 1.0
Subject: RE: plugins: Do not try to autopair with Nissan Connect devices
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, florian@ubports.com
In-Reply-To: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
References: <01070182f561c630-852e0333-6f04-448b-b064-46a2f000e860-000000@eu-central-1.amazonses.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5302021729638443234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: plugins/autopair.c:66
error: plugins/autopair.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5302021729638443234==--
