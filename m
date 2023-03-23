Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC2DC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 05:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCWFJs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 01:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCWFJr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 01:09:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3FA1CF79
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 22:09:46 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z1so212798iot.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 22:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679548185;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qomjr4Kia1Fn4xlANgTX9Qk0uoo1j+hBWFrVKNU7I40=;
        b=khJZw9F1yiVh+UEaXGe+wrBKL94R0pA9aZlWZNIbNd1itmptWUyGtSo1RYVevFjEtp
         W2WfDzpbLS62oJK6ZpYA39mMh1M5C8qacBy1eMOrpDF1UpzS129tjhkxuejBoNNhubtr
         l/3/7uwByNfIPdGCvJPxrBaXjP6/L8ttqledaFPoF9Cw+gANeS/JsUjDjIgwB+f3qIFm
         3cD2Oh1Gx8i4bcxWGYHBKXsGdKlII7Mu5tgnIA/0iJVGE7dAEaazKzrbXbslMQbMwXGl
         gKG/+b2rhGmHYq7Egj8lnyJAuwn7fi49seesQRrHOsrVJUYaL1lbNcmx2PqI/9O8grXi
         4Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679548185;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qomjr4Kia1Fn4xlANgTX9Qk0uoo1j+hBWFrVKNU7I40=;
        b=BZ4QKnDmNkOmicRNk/51FMv72+e2XjDQ1xqQk43PS0ulWqsQC7dmLVaw+wO8WNOW3m
         2Up4b4QG6O8WNZVMHpfB2gL4A8m5/++98gl98wxtvg1MhX11mebWf18O6seqBBXUvLIn
         QGSXgtsDgxtYtRVJZVOckR9eB83s1iHhDlEt8/DkZTx6YuGauAOeUITbPr73pALwcSjn
         LbVijDNUyiHcxpc0dtU7PjMaGkIyyxtHSRqunCGG8Ne8LdRaHftmYgZFSLjteer7Sf96
         JXqPzAEBO2mEvzd/gYd2CjV3RbuyOiOH/bezKvXLgt9BrcUcPzeEAODw6j+sd7+Is9ZP
         6PMQ==
X-Gm-Message-State: AO0yUKXcSp0YZRYQln+wIpL7gMU/zBNsMZHm59aH/13Kiw6HO9QZJW0e
        J0Dxh2BBa2rEohufKmG8UHSpIDzriS4=
X-Google-Smtp-Source: AK7set/w41RQsQIh4fsuiNKP578DiIrzmaJ5vgIJnUsoAWb6chi9ChjT68lQxSZuLpv00Q/RKDjhMw==
X-Received: by 2002:a5e:8b01:0:b0:74c:a578:e3a0 with SMTP id g1-20020a5e8b01000000b0074ca578e3a0mr6014223iok.5.1679548185323;
        Wed, 22 Mar 2023 22:09:45 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.22.97])
        by smtp.gmail.com with ESMTPSA id r20-20020a6bd914000000b0075342150fa8sm4997008ioc.40.2023.03.22.22.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 22:09:45 -0700 (PDT)
Message-ID: <641bdf19.6b0a0220.70982.aa74@mx.google.com>
Date:   Wed, 22 Mar 2023 22:09:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6097590539277307557=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, aarongt.shen@gmail.com
Subject: RE: [BlueZ] obexd: support to reply folder name to store file
In-Reply-To: <20230323034805.18946-1-aarongt.shen@gmail.com>
References: <20230323034805.18946-1-aarongt.shen@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6097590539277307557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732965

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.01 seconds
BluezMake                     PASS      739.19 seconds
MakeCheck                     PASS      11.07 seconds
MakeDistcheck                 PASS      147.25 seconds
CheckValgrind                 PASS      239.63 seconds
CheckSmatch                   PASS      318.79 seconds
bluezmakeextell               PASS      96.17 seconds
IncrementalBuild              PASS      599.97 seconds
ScanBuild                     PASS      947.07 seconds



---
Regards,
Linux Bluetooth


--===============6097590539277307557==--
