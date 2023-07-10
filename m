Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3525EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 23:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGJXzj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 19:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGJXzh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 19:55:37 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC21A8
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 16:55:35 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-634f59e7d47so28735526d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 16:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689033334; x=1691625334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=592jTyvhefsrWoVHYckWDOq8XdZwGDAcQgnokQB53RA=;
        b=nV2PvWLpqHgXL3St53Meg+lO5KCKfqqzFq+NMJqU2lMR4PVofV2+dfUOLI7QyKkyg+
         TtCWdLtCRbFnww50pjuyAg7eXK+KqFesmy1ajMmxwCMUopTYPb1l4vzx2sKSsSVHZP5Y
         m16pewSLFC+ZWIbZZyZ4y60ZvZ47luhJJ1g+oH3SKpRTFa5Jeo0I/+h2hl1ylYV1rdkd
         PNlDnjAdtMuxzPhHqWqZ+X+PUB5TD7Mzfwm+dGZJHKm8wj7NcEJsAr/0IBIcfpzmqik7
         rG3/ZrVjUefsZaQm30bUYIhKYovQsz9gWredo2pJPjhCnsqgZH63RHhlSlIDaFbDdsrM
         8mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689033334; x=1691625334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=592jTyvhefsrWoVHYckWDOq8XdZwGDAcQgnokQB53RA=;
        b=EFtQj1oaYLEm5tDOcCPhGqsAoBv8lyayDkIa7fwbMaB9Mpv9FGHofU0xyO9X8519Ng
         yQ4qIfaE03h7IzyjG1KFreIp2a/Vy0flUE2OIsbpwavf9bw81xZeooOAdOriUlUmfQvI
         dCV26PqbiKGaCPjtMuyyqsMd+Xxi3FJo+4SbQdtQcg52gAhhqvl5LvuSOaCfR0SkPBt5
         AoSCBZdkfWRRMH6pRIo9xz3kH2CZsw03MPIc6g0mSIXxTurSc1HHkfh7KsgZU32ila9L
         tFXODzHDX4ad+P4TCyUejt6lHmQNcBcOY8H9RWEc0dO89Qtr3gUXHUD/BGmFVFJgopNm
         xZ3g==
X-Gm-Message-State: ABy/qLY/c3XCVIMvXkJr8QJ/2yqkwAamRytwOM/ufzh3LQc4+7sWQcTd
        LrkFJHUItPt5yfL2ZPXlj9QmWbMkg8U=
X-Google-Smtp-Source: APBJJlHn/vxNm1s0oty+XvUJH4oTo4lXpZkS1dwt76scTIj+B2xxoJHGWYmEv8/fpDTNmluWE7630Q==
X-Received: by 2002:a0c:e1cd:0:b0:636:1aae:1bcc with SMTP id v13-20020a0ce1cd000000b006361aae1bccmr12900578qvl.39.1689033334176;
        Mon, 10 Jul 2023 16:55:34 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.170])
        by smtp.gmail.com with ESMTPSA id v2-20020a0c9c02000000b0062def68f75csm374924qve.124.2023.07.10.16.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:55:34 -0700 (PDT)
Message-ID: <64ac9a76.0c0a0220.aa05.19ac@mx.google.com>
Date:   Mon, 10 Jul 2023 16:55:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0114257492378054982=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/ad: Use util_iov_push_* helpers to generate data
In-Reply-To: <20230710221903.1231003-1-luiz.dentz@gmail.com>
References: <20230710221903.1231003-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0114257492378054982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764178

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.38 seconds
BuildEll                      PASS      33.38 seconds
BluezMake                     PASS      1148.19 seconds
MakeCheck                     PASS      12.96 seconds
MakeDistcheck                 PASS      188.19 seconds
CheckValgrind                 PASS      307.95 seconds
CheckSmatch                   PASS      429.27 seconds
bluezmakeextell               PASS      127.74 seconds
IncrementalBuild              PASS      997.40 seconds
ScanBuild                     PASS      1356.18 seconds



---
Regards,
Linux Bluetooth


--===============0114257492378054982==--
