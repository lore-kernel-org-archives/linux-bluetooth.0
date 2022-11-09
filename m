Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95DBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 14:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiKIOvh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiKIOv2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 09:51:28 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C626612764
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 06:51:27 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id r81so14083733iod.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L+C5ye316YEgmufy8VMSuu5fXd9Y8sBDwBp6OWWAtfc=;
        b=jYh4TNyMG2r5xctRCSLQ4prCoNlfMr7rw4SRdpDTBxnf5El+xN7lIJc+4m1RDp1LYi
         DiT3u1jwOQFSlaQdrgk1bJ80IOSF7JThiKF6h6/CHMeKwXkLNWJs/CJWnn+o6MhZGu0O
         KoGvQfPrqIhUW4TB3nFXgU1G4WnOLzsASA4S71hi7MeGB01n6oEB+DIhhMKWkYcktCvA
         xfKp9FbCuET9oV+YM17KQf1uZPGwCna6sgtxDJPILBuvRwgGmNd8tWB8E6XG0ynTVMOU
         HRyMzbJKwWzmJgKy9jc44rAAGABof3Msb6fZzzx1N28X1yO6j9xapmb71m4+roD6DCy4
         glbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+C5ye316YEgmufy8VMSuu5fXd9Y8sBDwBp6OWWAtfc=;
        b=Yb5SoKYYZFpNaXt8iGv14MJGbneHe/vV2aVOZFmdeYmUhXs+cvgHP6a5Zu/6lK+M0N
         htTfl5jw44dErY0rY66UKr+JVps5lDRsEho0Wf9UmLqolsEATA9ozpEqe7JursHCpMYj
         a9WQD8PbYX199cfPYmwl6uLUmMYXFIxvapGiXksjNLmMN7IJY360BhIozz4o7YQbAL4h
         d7FbOpBKMa8G7eYllYFSAB1f3xhlaQpwIz9CJI6yYuTvKEDwWXYUbA8C+O8OMfBCE3Nl
         3fHGXCd6CgEtl1K1P/kDYBl8gZ+lHDk76pX4UOSEOX8NBjZ5PVlWsayZ+E9xaLiDE4TS
         +jew==
X-Gm-Message-State: ACrzQf1nD3mSqruOLZTmBa/7N4xrCul6ZPGoc+Ucln0vjdXdyE1F4EoK
        Yhh+nV9lI8uOSiZg/Ko5srqrYsSp4Yw=
X-Google-Smtp-Source: AMsMyM5b/YlWX2HuMdMNHVLzCcOxWhfc0OcPbkEi/c2GKDJJCSuw0YWCF3O6FLinZVqLvexeeEUjlQ==
X-Received: by 2002:a05:6638:3cca:b0:375:59df:d8cd with SMTP id bc10-20020a0566383cca00b0037559dfd8cdmr32177376jab.267.1668005486886;
        Wed, 09 Nov 2022 06:51:26 -0800 (PST)
Received: from [172.17.0.2] ([40.122.160.54])
        by smtp.gmail.com with ESMTPSA id x14-20020a056e021cae00b002ffcf2e2e05sm4826289ill.58.2022.11.09.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 06:51:26 -0800 (PST)
Message-ID: <636bbe6e.050a0220.4ffd2.9543@mx.google.com>
Date:   Wed, 09 Nov 2022 06:51:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1703128222074708419=="
MIME-Version: 1.0
Subject: RE: dt-bindings: leds: Document Bluetooth and WLAN triggers
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, geert+renesas@glider.be
In-Reply-To: <a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be>
References: <a85c256af01f64389a078c2b37c3b72a27d97536.1668005062.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1703128222074708419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: Documentation/devicetree/bindings/leds/common.yaml:98
error: Documentation/devicetree/bindings/leds/common.yaml: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1703128222074708419==--
