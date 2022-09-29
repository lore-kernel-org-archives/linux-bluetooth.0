Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A77C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 20:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiI2UxI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiI2UxH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 16:53:07 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832871869B4
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:53:06 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-131c8ccae75so3247088fac.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=c8a08Gz9RgKO5AfCFUcRVBE4yD7p4b80Dln/YbtLQTo=;
        b=llHa9byFrH0z8OfDe8f8Wd31yxKKxqb3ZsGh5hjvKuhC8rJAhnSJlOGeltFY5I3Ubv
         dsr82hc6EHuf+1uM+yhLifHqChSKWHDqVrxqkYQBJzMPYS7zZqVvAgmp1qFP84ysxuOh
         Sw8LigNUzC9IHXbRa3Q6+1nTRzo4o4xBZNrPoCfE10jL+UBxYw4daQ8BXWrTroN5wohx
         ZHZ7WHfYASeLcgqQzIR1qSThDrnjhdJ8P/2AzuCMoQqyZPC7zmwbcrDiwCMUCg9+tNFt
         +g/IHOov7WTLD9l1Pn6us87YD4abHFYcuRR4fXVY3kIhsfJIijXkV8V3r4RXBjrWk4t5
         9hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=c8a08Gz9RgKO5AfCFUcRVBE4yD7p4b80Dln/YbtLQTo=;
        b=PnQPolpgGLC4U3csuz4BuXl+MyxGQxVWoizdbBAgXS073GhlBalaPnTld3PKqTD+L7
         B2xSEtcY92QkEat85of3+YLOGrcGq+Q15KsiBWj00iRt+4B4fQYHbPWLgcjD0c5WUQyn
         w9jbkvjSi+BX4MPO7obtvea+rLrmpIB7wUWFto9erYHm0EhInIi8CMTIg+DdzEBK3BdI
         NTXmSx0kZbmzx3XnV+fKvT8QbVa1pbFTy/aqhHM7tvfJX1siDa/zxX/URhKRRuUvFSTC
         CeK4hyd/AvwRzeo6bbfZLRWm+q87EcxFAe6ygqo6oXid8deAp6LgJ7covUuPSV5kGnFo
         lPIw==
X-Gm-Message-State: ACrzQf1/rRX91FMt5GEJNqz/71FipQ50WJ/DZrHJr7gjayTpGVZVrKl2
        f2Sh0plpxNtferlZwuCFwr6QV0w5Aeo=
X-Google-Smtp-Source: AMsMyM46h5I7IS6Jz7eVzw5hG7BeQmtETWANRjpvsn4jO1n/LVKhvQP3qT+8Fkjnn4B/edMc5iU03g==
X-Received: by 2002:a05:6870:d193:b0:131:8899:cc6d with SMTP id a19-20020a056870d19300b001318899cc6dmr8551977oac.251.1664484785344;
        Thu, 29 Sep 2022 13:53:05 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.146.223])
        by smtp.gmail.com with ESMTPSA id 38-20020a9d0ba9000000b00636e9a0cce5sm162415oth.60.2022.09.29.13.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 13:53:04 -0700 (PDT)
Message-ID: <633605b0.9d0a0220.5b731.0d4e@mx.google.com>
Date:   Thu, 29 Sep 2022 13:53:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4610736940065690359=="
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

--===============4610736940065690359==
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


--===============4610736940065690359==--
