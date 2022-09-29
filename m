Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADB8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 16:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiI2Qto (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiI2Qtm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 12:49:42 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197612AC3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 09:49:36 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id j8so1245761qvt.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=55iF+YvZ0zVe+F40BSKH2gWVblJc1F2eyJlUTqi8tlo=;
        b=Jx8jyxbu1J4Nr6PgyUFBnDN8KuO0nVcK7m1wZxeMJYCZOKjbS8uoS/Azp9UNhY17/J
         xVuH11Wg8d/GKrs7aIZ5KUhiq3fPm7sZ2PeO8mIIcMLO5R4dL1YJmSgL7iesyxFdrOhN
         A0trnejUhFxItlDySNd47IfWRv3PyCxaUY2gxdlHhLuiQ6VGgSLhJYy5tZ59YuebyopS
         gfKInPeBxe/6uRuanbtaOVn7QRRaBE0/pPC1Pd5MSiOHdCo1DwHFCpe0RUuR31LOvz5c
         zjUr9uxvUvhXBrcksWpZxAwSMcFi1MiWzFaKrdYiEonZncdkpkGDJc3cdOztpco48WgK
         ooxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=55iF+YvZ0zVe+F40BSKH2gWVblJc1F2eyJlUTqi8tlo=;
        b=n0cGTi1dM2NYhD8T+AN3Xw/PM4+cYjup41lR7dbCmRB19yw09ranjU9/VUgVulNFUc
         3d0eQZx7FupkpmQgse8S6utIU+KdhdBc6DLZ4h3LlUA6k6X0UL20My60cniJuDpEvgXB
         acLLku4gaqVkmxZMswgyLH6aeXvY3BYw4x6N6+xmM70C7rm74x0l/+mRTiZW3czVF4ft
         y1YRx2MEu8n8B3mJem6yXha7sLPJQ21oztINUzvXLFZv9DsNxHJGkabeQgzSSmMcemt0
         VPrh2uXT704MDzaQDHB9/9KxLxNFzUDV4J+5UA7gsf83Jukcv7wOpD9XBggYbPP0SrCm
         5Fpw==
X-Gm-Message-State: ACrzQf1e7Yr156QpA87feXgwVUony0mPpxdYUHpDjnRv2NkX4FvcU+hl
        /GfvZwxSyw6ZUdplWmxr+SDl5b8qEhKE9g==
X-Google-Smtp-Source: AMsMyM56xXVOTSkSjVz8MTSCYzfGgHNAZG/XVnKyXKel2NkGuqW3zmhktC3stlgfBW2O3N9+lpu+nQ==
X-Received: by 2002:a05:6214:20e3:b0:4a7:618d:44d8 with SMTP id 3-20020a05621420e300b004a7618d44d8mr3260054qvk.47.1664470175031;
        Thu, 29 Sep 2022 09:49:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.233.203])
        by smtp.gmail.com with ESMTPSA id o19-20020a05622a009300b0031eebfcb369sm6795730qtw.97.2022.09.29.09.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 09:49:34 -0700 (PDT)
Message-ID: <6335cc9e.050a0220.98bae.532c@mx.google.com>
Date:   Thu, 29 Sep 2022 09:49:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8259489421476556025=="
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

--===============8259489421476556025==
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


--===============8259489421476556025==--
