Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A560BC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 May 2023 20:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjE1UHS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 May 2023 16:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjE1UHR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 May 2023 16:07:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A917DAD
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 13:07:15 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso1968313b3a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 13:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685304435; x=1687896435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U/u0harblRntOiv5YfGgndqCmsbkSJNp9NAJqttLjKQ=;
        b=FkKbakohd95v9Ie9ACbKUEJcf2fo5AeHhVvhMV2st7XVJsw30gcajt9MC9swUBtrEt
         p9vE6wvgbtVlcE7QpLAXcg9WSEWcpm/uxEHL5MJkTcob1p8rt76kyD+mgxVV6YyLN9bF
         v4NJBOnKDTRUUFQ0ss9kQuP9Av/EoHDK1ep5t4WIdRdvEtows1Y5oHBfuaJytWS4mSs8
         bCIQSbTSvCybAmkWoE3O1qvG/Wqrbiu8CK6wB33Bu+3szfgB9Vfv48taEVevIL1DTPrB
         7KGjsKeQBfaEN7BqhCaFrHdqU2IgIa7Xwfi9Q6BKEh38YEfiHuQbmMX+PMK0aYQAJ/Z0
         YrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685304435; x=1687896435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/u0harblRntOiv5YfGgndqCmsbkSJNp9NAJqttLjKQ=;
        b=D1alJ97GudGAclQLqYqZZJxNuiFR5lQ5zHDN+RQw3fhW9j8abfSwvYHc1C8AKJ9hX/
         fHKuBvEUiS75T+uvDa/r/xp9l2Yln/91j7GIzB7U4kSUlLpGlJpAzLoAEpa5JNXrR/sm
         olX8LDQWN1aUHTj7DI0Bt7FJXQuXxbwMsOnWp4hHHAqSHykFO2tRfM3G+OSUaFtkF7Na
         SY2s+2aZEcxsLhJ3z4SEIqogPHm/Z4ClDZDZxp9lVXxeRHh8QceFFyJQkVirG85Sz+Yi
         rs98bg7bGCE0XMNArBt+ff6b6AkKhUMeUZ4I963Wl1wA1EYHs0r8k/r9pPnCSwnVZziH
         o1kQ==
X-Gm-Message-State: AC+VfDwkZYiorW7d6DqnHrozXo+L9KlutGRxv0aKOdofxmDag+UGUwjC
        GFAPDikpWkmJkJhAdPQRPxyX7tyY0iw=
X-Google-Smtp-Source: ACHHUZ6MYuyr1DymDb+/MxQ9+poKqvBodI5Z8Jsj+nQgt5t85CZbrwr063zAzfuAFl2TtGo25I1LLA==
X-Received: by 2002:a17:903:5d0:b0:1a9:7b5e:14ba with SMTP id kf16-20020a17090305d000b001a97b5e14bamr8702217plb.29.1685304434859;
        Sun, 28 May 2023 13:07:14 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.46.50])
        by smtp.gmail.com with ESMTPSA id je1-20020a170903264100b001a9af8ddb64sm6632772plb.298.2023.05.28.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 13:07:14 -0700 (PDT)
Message-ID: <6473b472.170a0220.333e5.cd7e@mx.google.com>
Date:   Sun, 28 May 2023 13:07:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3092885456687642626=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/4] iso-tester: Add tests for AC configuration reconnect
In-Reply-To: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
References: <502997002ac9d4a76593aa4ba8237b7fb803c701.1685283364.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3092885456687642626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=751682

---Test result---

Test Summary:
CheckPatch                    PASS      1.63 seconds
GitLint                       FAIL      1.35 seconds
BuildEll                      PASS      33.10 seconds
BluezMake                     PASS      1035.93 seconds
MakeCheck                     PASS      13.28 seconds
MakeDistcheck                 PASS      193.40 seconds
CheckValgrind                 PASS      305.90 seconds
CheckSmatch                   WARNING   407.90 seconds
bluezmakeextell               PASS      124.24 seconds
IncrementalBuild              PASS      3302.71 seconds
ScanBuild                     WARNING   1262.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/4] iso-tester: Add tests for AC configuration reconnect

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
15: B2 Line has trailing whitespace: "    "
19: B2 Line has trailing whitespace: "    "
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:417:29: warning: Variable length array is used.emulator/btdev.c:417:29: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
emulator/btdev.c:1080:10: warning: Although the value stored to 'conn' is used in the enclosing expression, the value is never actually read from 'conn'
        while ((conn = queue_find(dev->conns, match_handle,
                ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
emulator/btdev.c:1392:13: warning: Access to field 'dev' results in a dereference of a null pointer (loaded from variable 'conn')
        send_event(conn->dev, BT_HCI_EVT_AUTH_COMPLETE, &ev, sizeof(ev));
                   ^~~~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============3092885456687642626==--
