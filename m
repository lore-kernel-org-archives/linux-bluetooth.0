Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FF8EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 11:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjGLL1e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 07:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjGLL1d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 07:27:33 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D768F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 04:27:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403a72df0a6so23613221cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689161251; x=1691753251;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bkT13qxh5KQxsDufIJ3YNaE/NQZYY6Xyxz/yEjQ+7mQ=;
        b=CZEFlr8HW1z4LgaZsq82LYNYlTDVPT7n41WLIXzr8m5iy59IGOY0UjDlUzzb2Rq22i
         pZua+2M6qT4kei/eFHOtsd/5SGLOx6s4ts5z2FOMFtnPVxXI5hmWYuJ6KpgTSEku6gQj
         5AIwXPJEqyWWe19EALS3WxIyp6D7Fo/nkKIgynV9NYOTAwJFIZMwTGOV+UjhgXiqpEhX
         gNBKG0zDo73TUBrWpuB74SpmXFiJWnynRHZO1LL/ALtfScYrE82/pE4WqVqsB9zoqWWA
         zbKWNjOnPPg2KOsNnPTtBiAWDCjB3ATLeYTD0PKZ3uVTYamsh94wCgxrBwiJBIMLl51a
         lUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689161251; x=1691753251;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkT13qxh5KQxsDufIJ3YNaE/NQZYY6Xyxz/yEjQ+7mQ=;
        b=Ko5NYIoJD0zFDzFhzT4N1n2xudUfE9P6aIy5BJPF8/CMjPiy/HKf5tMSqtSqrwf/nH
         cgFCyrc/o6bONIAkbIm5yjkpMfdGsFKyxsh/0paz9372XvQnol5OIp0sEkrL89DYXJqC
         4/bX+SY+rwsF70p2CcA8qHYB8G34xU4zkDt+6Q9Wy7vOZRPZfCzh9QtFEyAZ80klPIDf
         daz7j8ZmaGQQ85qEYXciV9qawsmTPYZcjFBps/Kbd87nWZvucZe64ZG89Hd02tamGmYX
         NS+Cbdi8gB8H/BX3GtXYNyYsP6PvB3SOmEdecHmuYjcINV+Xe01DG7uEqDySsd4t7kM6
         lqGA==
X-Gm-Message-State: ABy/qLaIrUqUZHlPp9KjAsjcucaSFFPsREdZMgXnvvJaFQu68ybjv8Am
        Q4PZviwqla+DRq/pRW5u4DGiTFwWhEc=
X-Google-Smtp-Source: APBJJlEH6zqitRiGegyjErpnFqrsmHr6OgNW5jHDyNRXrt+W4JMNLpRG17dKsP6ic4xWY7BaqCOZlQ==
X-Received: by 2002:a05:622a:1108:b0:403:9572:e378 with SMTP id e8-20020a05622a110800b004039572e378mr20063544qty.54.1689161250835;
        Wed, 12 Jul 2023 04:27:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.114.128.125])
        by smtp.gmail.com with ESMTPSA id x9-20020ac87009000000b003f6b0562ad7sm2181456qtm.16.2023.07.12.04.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 04:27:30 -0700 (PDT)
Message-ID: <64ae8e22.c80a0220.c2b04.6cd4@mx.google.com>
Date:   Wed, 12 Jul 2023 04:27:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5547301342954807771=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com
Subject: RE: Add support for BAP broadcast sink
In-Reply-To: <20230712085900.5423-2-claudia.rosu@nxp.com>
References: <20230712085900.5423-2-claudia.rosu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5547301342954807771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764738

---Test result---

Test Summary:
CheckPatch                    PASS      4.18 seconds
GitLint                       FAIL      2.34 seconds
BuildEll                      PASS      27.10 seconds
BluezMake                     PASS      993.03 seconds
MakeCheck                     PASS      12.77 seconds
MakeDistcheck                 PASS      158.86 seconds
CheckValgrind                 PASS      263.06 seconds
CheckSmatch                   PASS      349.14 seconds
bluezmakeextell               PASS      106.30 seconds
IncrementalBuild              PASS      4981.09 seconds
ScanBuild                     PASS      1040.99 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/6] client/player: Add broadcast sink endpoint registration and configuration.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[BlueZ,1/6] client/player: Add broadcast sink endpoint registration and configuration."
1: T3 Title has trailing punctuation (.): "[BlueZ,1/6] client/player: Add broadcast sink endpoint registration and configuration."
20: B2 Line has trailing whitespace: "[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0 "
[BlueZ,2/6] client/main: Add broadcast source discovery

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B2 Line has trailing whitespace: "This checks if the scanned device advertises the "
19: B2 Line has trailing whitespace: "[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0 "
[BlueZ,3/6] media: Add support for a broadcast sink media endpoint

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
3: B2 Line has trailing whitespace: "This patch adds the possibility to register a broadcast sink "
[BlueZ,6/6] bap: Add support for BAP broadcast sink

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B2 Line has trailing whitespace: "to synchronize to a given source and sets the QOS and capabilities "
17: B2 Line has trailing whitespace: "[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0 "


---
Regards,
Linux Bluetooth


--===============5547301342954807771==--
