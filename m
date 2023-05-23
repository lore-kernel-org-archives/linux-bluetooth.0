Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84ECC7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 15:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjEWPPS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbjEWPO5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 11:14:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AF8E56
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 08:14:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-76c5558ba95so99037139f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684854861; x=1687446861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=495iXl1/rC5puO0gpoYZt5IXy3C3/XUE3tHip0wSQHg=;
        b=fkwgCzULAVCfg+5iUu/ri9Gu2PE61NtfAi2Ko8NTEFeHawf+9tp2f7kVYoOE4UsyU4
         tGC1W+RUNaSOwbv8qZS+tQVm5r7qesKcHJx/j9DpEpUzt6XzIDdgNdz9citFjBQzxzpf
         o53Yc/P5p9H5rgVX6KldB+IBHrJAFGDFcrxggFw03TXcy+fvViZq5dpIhp4wGztpTyxV
         2KnaZoeEFgNKLhMuy6c23vpNM+ey/9P5qscg8LIk7EgCf6prwk+/83qftUVm8ml+EdeF
         FoV3hPxUejVo57+S3EV+Q0G8GbC7YDFwB/ZMfO4bWz5cV7kPyo9pDhpwoQsymLvPw0DI
         YZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684854861; x=1687446861;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=495iXl1/rC5puO0gpoYZt5IXy3C3/XUE3tHip0wSQHg=;
        b=SagI71VGSAzAuRU9Zcn+OS+8AYx1yONNSZGTUdSnZ7DT3cp5a81bWF6rL6Pulfvp8h
         NMMlAX4gb8EUVGbhUAG5bymAHNLfqrMh+N/zlI6C7OST62cWUejxesOL5TQSozdYBwCu
         FC5UgOkZOxLeB/8Nb6sObfQi9UdBBGg+epmZjf+rwQoza0Jfl9faAD5o+RS2ep1yQAcU
         Fp7l7gW/RzSRoAM0/EI3fH9uweBEhL4nNnSCLEL51ikHo9N9lBhuYXjZh9Dmytu7AnHo
         BPy+ttAP/efbg4Rb9ZF/x7n47rhGrIk4EeICwR4Fb70DTRv6IYT0SnqcGxdaHXdT1hDN
         82YQ==
X-Gm-Message-State: AC+VfDw7SFm8Bi7JM4jiO84LFts3bKkxZR9I3ApxaFdkme2aXPcDyaTS
        LF0YCm0WGW8XSI/anag+pul8f4VPHj4=
X-Google-Smtp-Source: ACHHUZ5+LcWT/m4Zl+slHoXyfj98U5VANvoXK7Dq7m8RACk4ejXQMKjPcH+eHNCgEZEJ4j0Vv2QrJw==
X-Received: by 2002:a05:6602:340c:b0:774:8a65:df02 with SMTP id n12-20020a056602340c00b007748a65df02mr1058334ioz.9.1684854861294;
        Tue, 23 May 2023 08:14:21 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.28.129])
        by smtp.gmail.com with ESMTPSA id cl9-20020a0566383d0900b0040faf78330asm2555285jab.28.2023.05.23.08.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:14:20 -0700 (PDT)
Message-ID: <646cd84c.050a0220.12818.2a9f@mx.google.com>
Date:   Tue, 23 May 2023 08:14:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4780588941659035720=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Add initial support for BAP broadcast source
In-Reply-To: <20230523143504.3319-2-iulia.tanasescu@nxp.com>
References: <20230523143504.3319-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4780588941659035720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/player.c:73
error: client/player.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4780588941659035720==--
