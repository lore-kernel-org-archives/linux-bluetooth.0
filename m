Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11932EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Jul 2023 03:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGQD3Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Jul 2023 23:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGQD3J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Jul 2023 23:29:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF29FF
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jul 2023 20:29:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-40348601753so30139121cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Jul 2023 20:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689564547; x=1692156547;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fW9xPyTBIAtmNowqMIYZzOAem+AG/ECDsh9Ti4l0vpk=;
        b=dK/X372u9P+OdBW+FlGZe4DiS9pXh/el9izWVBnRIWYRyjiL2c1Im72rE729O6qntM
         u7Auo6bzI7f2s0sg7bHbrySpe7v1oz5xWJtys1xHtAbvWurpcVFsV5gQhJubWEI2pNqq
         udsMqSsgdNg1zYUUIh/mGDWikincxrGh7+leHHSD6jcRadoPSsi7UrbL/gNT2o7MYi52
         H3WP+9JwEYe1mVQXvEeGxZ9gWlSI8hk53PejWrqSD4WdWQO4KTVPs35Wi9qSyrjf2u6k
         BE7+6RKQ83A9xlzUOn7moHsOL+6XrlR3sNPaLfEbSOs7CjSmoX2NjGNNUEqF+CkDtEVa
         QQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689564547; x=1692156547;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fW9xPyTBIAtmNowqMIYZzOAem+AG/ECDsh9Ti4l0vpk=;
        b=EyJTsI3rBjq2hsD8xD/97kupnpg1X32Zw4uMqXjQpNcgWozc2JewAAGEP2zborCwyK
         +/1QE9lPilzQ6QOTukS6GWpbNa/m1VTgiZ0+FltZFPFfEDl/6aurDlJojmO1Wse+eWKC
         cGgn23RHwOmEk+qKIBYfMq3jfDrX72KEejTTiEEOSM8Del4Qula2zKr1m5iE/8Ka7Btz
         +Qj3ofV6TS6UOyJLSoepnO293XKO+tq1iyoKCcRsnlPc8tYDi/9w/WB86YUWvnixjkTO
         oV+rUHgytR3VQomiJy0ei5ERUYhjnBlfijb9pDZNlp3nB83Gwk2pxNfLjWy2LCYdityl
         u93w==
X-Gm-Message-State: ABy/qLb3HrJoRKLi+koIhpYoNZg4xENmpsM5+FVNHU/Yj5kIY4yQSL1J
        336QkdrqxCEkLWp7OZZl8fkKe2pCTAU=
X-Google-Smtp-Source: APBJJlH5Bc//TEbORHR+ahQBWJGQ5He338TmqcMw2nsz2ICrqI8vRWUKFlVTeNAl3HdFiSFMvyi11w==
X-Received: by 2002:a05:622a:34c:b0:400:9126:3f16 with SMTP id r12-20020a05622a034c00b0040091263f16mr15834496qtw.1.1689564547696;
        Sun, 16 Jul 2023 20:29:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.76.128])
        by smtp.gmail.com with ESMTPSA id i16-20020a0cf390000000b0063640486254sm6080463qvk.116.2023.07.16.20.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 20:29:07 -0700 (PDT)
Message-ID: <64b4b583.0c0a0220.69d45.3ee9@mx.google.com>
Date:   Sun, 16 Jul 2023 20:29:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6617095122263055844=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, buddwm@gmail.com
Subject: RE: Bluetooth: Add VID/PID 0489/e102 for MediaTek MT7922
In-Reply-To: <ZLSwfv2pQ5uH6bja@bud-laptop>
References: <ZLSwfv2pQ5uH6bja@bud-laptop>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6617095122263055844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:628
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6617095122263055844==--
