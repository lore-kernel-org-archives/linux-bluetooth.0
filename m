Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A9BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Feb 2022 11:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiBNL6S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Feb 2022 06:58:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiBNL6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Feb 2022 06:58:16 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E89CD8
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 03:58:09 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id k25so15157572qtp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Feb 2022 03:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=jtzY3XwGAzdRhmPTUy3snMKgxJCR7uLp8lGGoL7TYqc=;
        b=OndF2VOZjaCFoTDtcxRPLt7eATfzfP1Gyisxc+wgTS1Cv0AHOOtkeFUnYisLWGRTyC
         VL8zuqMrJXFFrSAU9DatlYb0O4zawl2ZYDApdR9OE3LMEYI9N1xDvkIHwCWwZEFVMhW5
         YKmBJvoWmPl7OgCN3+Z7+KU0fa0xEDvK/3qMS2iVk9slKo0MAiWPZLwB/jxV5hdTj7R7
         ZnTfJ+NoI25n6tZA3x0HJQ15uyodh0BQzk4Ev1c0pAWiAMFQtjyaiusLRiE2k4Hl368f
         27VxdKs9w068ggY1BQN8IfVVXEOmJsjdB6wWQqb9yaTWo8eNOFdJEfKu7/V6FXvJyTF+
         bUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=jtzY3XwGAzdRhmPTUy3snMKgxJCR7uLp8lGGoL7TYqc=;
        b=vimSe7Gae4lLcTNa4nDqpm66f2tDn/sGziMuDhfclr836mcNIp7k4j7a76aF7cP9m+
         r5AfYq+F6JIHxtg9mRWgUPClJRUfatZP0jOCreJBJfq8u9ka+I+/GuVj/V9x5Yv4RWa8
         8+PRkyDG8i+1EgQ+PFsRTkwMNVhjHxM6EbhT8yrZNGTJ3t7ps4MicZxNEM5qQF8mIBpe
         z9N3WVCNZpjOClEYQY9biNUBzrGEavMiDZ0rBUGuEjdT6as2g6JdpE1FZRntoGOi14Ji
         trVHcATPuo+DC/s+eJhLUlV0+tJX1QJr1+oQA1OaBauaw5i2XEiXyWfZ33bfmn7KGZ0U
         gNNw==
X-Gm-Message-State: AOAM532KeJFfiGxeFcFjmXaozkCZQ3bxx+kG1Gt6IjasBwiFJ3CCtJ+q
        Ea/WsLz4pCyiipJMyGs02RzPttV6OakeNg==
X-Google-Smtp-Source: ABdhPJy5a84vRUsiOgK6TcL7qIcD1vr3aDfI9JstJSdUC0NvH6Na/ZcTneLQ7/5gYhzhFfapQ8NFIA==
X-Received: by 2002:ac8:578a:: with SMTP id v10mr9045949qta.148.1644839888542;
        Mon, 14 Feb 2022 03:58:08 -0800 (PST)
Received: from [172.17.0.2] ([52.168.109.72])
        by smtp.gmail.com with ESMTPSA id q139sm4262448qke.104.2022.02.14.03.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 03:58:08 -0800 (PST)
Message-ID: <620a43d0.1c69fb81.219fb.4359@mx.google.com>
Date:   Mon, 14 Feb 2022 03:58:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1477603129951387475=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zijuhu@codeaurora.org
Subject: RE: [v3] Bluetooth: btusb: Improve stability for QCA devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1644834935-23189-1-git-send-email-zijuhu@codeaurora.org>
References: <1644834935-23189-1-git-send-email-zijuhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1477603129951387475==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=614062

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      29.75 seconds
BuildKernel32                 PASS      26.48 seconds
Incremental Build with patchesPASS      35.93 seconds
TestRunner: Setup             PASS      473.13 seconds
TestRunner: l2cap-tester      PASS      13.72 seconds
TestRunner: bnep-tester       PASS      6.25 seconds
TestRunner: mgmt-tester       PASS      105.25 seconds
TestRunner: rfcomm-tester     PASS      7.81 seconds
TestRunner: sco-tester        PASS      7.84 seconds
TestRunner: smp-tester        PASS      7.71 seconds
TestRunner: userchan-tester   PASS      6.41 seconds



---
Regards,
Linux Bluetooth


--===============1477603129951387475==--
