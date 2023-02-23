Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B80C636D6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 10:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjBWKlt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 05:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjBWKls (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 05:41:48 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400272737
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 02:41:45 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id bg11so12028483oib.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2TCezCAwR8cKfdMlHPx5vTO8/YK9tzvWnblyo0UtSCE=;
        b=XyvPI1OR4RBBgBZg/AJlvqqJGm+SvzqrusKxJ04Gqv8nTFiIjWERqOFaLTq/3WzCpo
         6MyxnscffPeDHZgY0L2dSsqRejkQGxJ2pdbKbLqLODZpfrfVbacZuYWDOP5GYEhj45bO
         hU9TrbTXK7AbJdDGxNCBnSkA8siPIdQ3oPyFp7L5BP4Tgl3LX1iZqwlEjb3CvcxlAr5S
         jMaz2UepCYmXtG6mIg3OGQzr89vBdjjby/Er3u6VMqsqCpBlXMQS9mJKBEIRZb1eFoPW
         d74/mYoZz2n10juAgaVlQEmr1OYeZcVkUsl609Y1pcFlBixKIQAibH1UZ9ySIV6gnmtd
         OWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TCezCAwR8cKfdMlHPx5vTO8/YK9tzvWnblyo0UtSCE=;
        b=isfmVUBvLiKcocfja8m0rdZoxXhmSOxu+GIxbhGIU0g1dncd5NDkwi7zjmtM0pqfFs
         +aGvpAGe+ddjtNF4FnZaPS0dOwlk0JmEjvTNclb+7ltoCImB0O8eYO1MwXfSxqHM7eiA
         zcMs6rN82/gawET+Pff58OsoTaWqvSDSEL5+4LPDwbFpyl7dO0LNz47QPMZ2aHC15YM8
         Inhr7sE2JCfplQ35XPGu1fk6TEMdb7LR7J3Lk9dF8f7QUXmFwqrwH5vg4zRZRh4yBJof
         6bfigjFKQsq1lBBE72cK7NWrbHe7DWWwfTgI4+bQy2Hz1Ijkf4a1WoNNt3CmGtU7VBDB
         u23g==
X-Gm-Message-State: AO0yUKVrGeKZ6ursnDvhS6+L1VhxasJDllTz9RWPtCYn2EDVW0dcY0Le
        54mVStTJIjXDBHOjhkHuEjPALBnohuA=
X-Google-Smtp-Source: AK7set/u+SCBNkcSJ/OhZKwGRMCm/h1YBh/dALF4akwstgEG8D5HGqdF/9FtvxjzLJKDEOLxcc4LUw==
X-Received: by 2002:a54:4112:0:b0:378:89a7:2f4f with SMTP id l18-20020a544112000000b0037889a72f4fmr1794139oic.3.1677148904283;
        Thu, 23 Feb 2023 02:41:44 -0800 (PST)
Received: from [172.17.0.2] ([65.52.35.0])
        by smtp.gmail.com with ESMTPSA id be41-20020a05680821a900b0037d74967ef6sm2277512oib.44.2023.02.23.02.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 02:41:43 -0800 (PST)
Message-ID: <63f742e7.050a0220.a4230.a929@mx.google.com>
Date:   Thu, 23 Feb 2023 02:41:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3477616005186901354=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v5] Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets
In-Reply-To: <20230223103614.4137309-4-neeraj.sanjaykale@nxp.com>
References: <20230223103614.4137309-4-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3477616005186901354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: MAINTAINERS:22840
error: MAINTAINERS: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3477616005186901354==--
