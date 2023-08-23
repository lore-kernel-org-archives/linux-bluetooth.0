Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5742AC3DA66
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 22:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjHWWIG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbjHWWH6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 18:07:58 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB74E68
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 15:07:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4106eb44e64so1664481cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692828474; x=1693433274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u5lFfP1B1/pr3+eU+iQz0XeHVsFOmwXv/R8CGPu8bmo=;
        b=ITMliMfuCVO2IBlqwhNQP4X7fJ7jXNkx92T3TWkqKIGSjyqvqeVRyCkVC9tT86dZYA
         keuEwmZddRlYqXivMa65tcKV6Zz1s9zL9OgIZEo8fc2OtdRKhTC4ML7IjFIDcA24vW8c
         0ssqZjNnsHb9vuVqkVCWzw21lV0LyVuZ0adjAw8Hy4BMfO1My/t1wOYvhNtMa1JCRrxP
         PkLtYuiDuKti/uGIzmkbPZqYMbXwyPw3fz5SBGFDpGxfZqwWDkrsA3yzZmT9Go1M2YD0
         oiUJWRYd7SIanN1y5PJb4j42yt780Jj6PNZAKsfAzd3jGAy2BRNszHfikOtvhSnlVzf5
         eEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692828474; x=1693433274;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5lFfP1B1/pr3+eU+iQz0XeHVsFOmwXv/R8CGPu8bmo=;
        b=KkxgtSRRachdul9FxeNF6zhezO5shCoOSLm8UCmw64JwJLEABdJ6QXKpeBzoOeqiuD
         I6r2V7LjEMVzrqUHdT704ITG6ppI3NjW4HVZNcUlxg6wpFH4n975eCDakYNJhSLQ8ifT
         EixSKb9qGtBvnaGzFL8sFSfZXBnCWMEs4NG0R6g4GzHC6fr5gWpG7MTldQdL6rgcOTA4
         ECJoSVI5Jcn3oEFaUN9/gVNNasehyrOW3zFDUOg6WdIjywLPK0oBJe440kSzEE44PpEZ
         5RGUtYCxXE+alSmbrjn03sUu0hd28Z9E89f4UTTy3tqOhKbKQbCurvrIumVvZ2gAUflS
         QlKA==
X-Gm-Message-State: AOJu0YxSIOm28hiRW2Me8JWgqpDbGpXRTFeQXHuiCj573qbByPkVD1ee
        6a4fqppsjNgFLoHf3nSPrKP2FpzksjA=
X-Google-Smtp-Source: AGHT+IF4nBqkySmigNhVC42LuzcTkOWQj5+0R328GTqa4UDgbch1oYoV6p7HH9CnBzd/rWeJUHUw+g==
X-Received: by 2002:a05:622a:130e:b0:3f9:aa80:b48a with SMTP id v14-20020a05622a130e00b003f9aa80b48amr17334699qtk.8.1692828474022;
        Wed, 23 Aug 2023 15:07:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.124.94])
        by smtp.gmail.com with ESMTPSA id ce11-20020a05622a41cb00b004053bcffe49sm3957897qtb.9.2023.08.23.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 15:07:53 -0700 (PDT)
Message-ID: <64e68339.050a0220.15381.2082@mx.google.com>
Date:   Wed, 23 Aug 2023 15:07:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0452618629172679410=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client: Add agent auto argument support
In-Reply-To: <20230823205028.3903879-1-luiz.dentz@gmail.com>
References: <20230823205028.3903879-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0452618629172679410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778736

---Test result---

Test Summary:
CheckPatch                    PASS      2.38 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      26.84 seconds
BluezMake                     PASS      783.39 seconds
MakeCheck                     PASS      11.94 seconds
MakeDistcheck                 PASS      156.20 seconds
CheckValgrind                 PASS      250.29 seconds
CheckSmatch                   PASS      338.55 seconds
bluezmakeextell               PASS      101.87 seconds
IncrementalBuild              PASS      648.14 seconds
ScanBuild                     PASS      1017.38 seconds



---
Regards,
Linux Bluetooth


--===============0452618629172679410==--
