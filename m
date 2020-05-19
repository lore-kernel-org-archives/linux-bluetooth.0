Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB172C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1D12072C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 20:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFEzlq67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgESUkA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 May 2020 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESUkA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 May 2020 16:40:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C5C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:39:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i5so1144401qkl.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2020 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=QmeKGIPJOYfvjHl3+KLV+FiDssEQ/c1HgznRDtqGHrg=;
        b=iFEzlq67KhEcE7OrZkltBDVfR4lrVB6sofxNc+b6ozjyzduNbGAHwwwkDKONRrA0YM
         6rHCjqmRQzQTMYLHX1nhhm06ccqXSIdwkgQZErPPggDqllb70dkkD4OPZXY2JtcNPuWB
         SYinDx3r6ulL7RZcWOYXneDiBIUSJiy7fznLn9o35oOVWCy/jZV5o1aavE5G6jXu8q/d
         QBd9bxCyaPNayqG2YNFeFpwHxxsTezqeTeCZsCy0nMQqjP238A0uF+g6tgz5Jr4eCSnn
         EqDe/e9A6k6KApJH2xjP/aSuNocsbmS/bLWXJTeCjCtyfBJz0RS0Ou7SLXZnzAJq3OIi
         Ievw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=QmeKGIPJOYfvjHl3+KLV+FiDssEQ/c1HgznRDtqGHrg=;
        b=Sy5MGy4V4wcew2urEz9rw1lSLtoc9NBM78pe6caVVuKM1USJjhW7hZjN+aITQ2xMTW
         H5O12vEYrm4vsmnSBm1nxKwHVBEXBQR3LkGrXBP+3qI6MUFJ5+az/SsBRopaz7DwRobv
         krz5XKPRnUxhRn6Gg28NQFPQaysbmujpF7XZ7+XiPoonyhXLMwEwdwYmrgnbfVNM2yWE
         tQCk5JFCnU5PzJrmm7f8mluH69BZDCtyaE5jZTwvguVqpjqmBsDB6yZNDrokmPWgsgdB
         RTUl6lalM56J5Vg/RXrthDDr1YSNciPyv4EkWNKOrbtDNhrji7tsqt3dCK1iAURBvVXS
         6euw==
X-Gm-Message-State: AOAM533cVuB6bCEJ5YJRyu1/Bo2DeS6aqFAxBlklB/KaJvrHOMW5TRzw
        iLwLu3IEmIs3GieivF1dKPpiNZHI
X-Google-Smtp-Source: ABdhPJxlvdHGtRXBHmiD2z4SGUUonwAtl96rV+9U+UQLl1IiqOiorx2MgJ1G4dS5YsRa1DqGdB2Bxg==
X-Received: by 2002:a37:5d7:: with SMTP id 206mr933764qkf.118.1589920798558;
        Tue, 19 May 2020 13:39:58 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.74.64])
        by smtp.gmail.com with ESMTPSA id k3sm519615qkb.112.2020.05.19.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:39:57 -0700 (PDT)
Message-ID: <5ec4441d.1c69fb81.6be43.3c0a@mx.google.com>
Date:   Tue, 19 May 2020 13:39:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4552447754608806657=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/4] a2dp: Fix caching endpoints for unknown version
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200519200345.217345-1-luiz.dentz@gmail.com>
References: <20200519200345.217345-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4552447754608806657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
makecheck Failed

Outputs:
./test-driver: line 107: 14841 Aborted                 (core dumped) "$@" > $log_file 2>&1
make[3]: *** [Makefile:9726: test-suite.log] Error 1
make[2]: *** [Makefile:9834: check-TESTS] Error 2
make[1]: *** [Makefile:10228: check-am] Error 2
make: *** [Makefile:10230: check] Error 2



---
Regards,
Linux Bluetooth

--===============4552447754608806657==--
