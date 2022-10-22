Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B191C04A95
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Oct 2022 20:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJVUIl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Oct 2022 16:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJVUIk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Oct 2022 16:08:40 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DB911E459
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 13:08:39 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 128so5461108pga.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Oct 2022 13:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d/xpjAicFFhoC210eT89sQyOgXdQ/q5zw8SVhugbu88=;
        b=Y0RSBE3qPud5c5G7WsVTouYfiyHuGkouK4hDE94V5o44Nfvbtqzn7u/E33vCz3h9hl
         kFpkS9vm2+ACJFEEc+tXyLRapOtL7x2HCtWCn7ZA0PqBGwbpltOb/7zPL0QM1p2shMx8
         T5d8Z4M3tFb/jdI0xRnR2qVrJs+G1FtfX7fN6b/3vWinzddkrsNpRYR8Ls81sArsRFA3
         SWtw2aPuUE8dPibxGBnzmvP1GsjifLozNqoheVCQSKcrZk+RD1TbQN1PqSBYeATmIbj4
         cIGBis5y51O51bRjKF9AexLoPbKaiGlZrf7hbFHoGE/b0OTvHU/LjwSujC8aRo5Zuahr
         LW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/xpjAicFFhoC210eT89sQyOgXdQ/q5zw8SVhugbu88=;
        b=rS6oTeUEryeBf3SPons6hHabVQtZ2xi0QPIdkVA/mg9xYdnEBDNtva019ZIoBCIe+0
         1IO/ark88DtX57CzlrqkBxjL4mQuVfFHaisHqZTY0ndY9cCJvRpUzJOFjOjdelK0eqX6
         wWeLjPb+u+Vieap1apZedMxXSoAaXqXvJEUzBcgiFqydHJhcLZO95OTVP2gZPmQ9ReuH
         nVwA5veC08xTRmYewGVJaKVNw9HRvaCthlSRfShKPOMf/pHbnwrz0HmSwotZvY9FWexw
         lgfbFbNjEK98FsNvRkGdmHuvOXPgntopTkp72KvsnyjeQDYyPhTqLbZ5yyxS9Fw6sIqX
         qp6A==
X-Gm-Message-State: ACrzQf0MhnNo5/RlaJ2nDLZoJNhHiZor5zuMZnQMfp73dI7N362wRuZ0
        mm4bX6FyOz9o1+5S9nTR/tsSD3veRak=
X-Google-Smtp-Source: AMsMyM5wmeOLiOr2K4duj6OujHGt+CoFmZ8H159v+DNqfNQgAbYqjUMMg/y/zthR8J36MVp9Lm8OFw==
X-Received: by 2002:a65:56c4:0:b0:458:85e:9e65 with SMTP id w4-20020a6556c4000000b00458085e9e65mr21985046pgs.358.1666469318650;
        Sat, 22 Oct 2022 13:08:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.55.163])
        by smtp.gmail.com with ESMTPSA id e17-20020aa798d1000000b00562ea6eeeb2sm17775719pfm.93.2022.10.22.13.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 13:08:38 -0700 (PDT)
Message-ID: <63544dc6.a70a0220.5a6c7.2147@mx.google.com>
Date:   Sat, 22 Oct 2022 13:08:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1134735383979572228=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wiagn233@outlook.com
Subject: RE: [RESEND,v3] Bluetooth: btusb: Add more device IDs for WCN6855
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <TY3P286MB2611D3672C5664AB862E10E8982C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <TY3P286MB2611D3672C5664AB862E10E8982C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1134735383979572228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=687881

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      44.94 seconds
BuildKernel32                 PASS      40.09 seconds
Incremental Build with patchesPASS      59.89 seconds
TestRunner: Setup             PASS      663.15 seconds
TestRunner: l2cap-tester      PASS      21.06 seconds
TestRunner: iso-tester        PASS      21.36 seconds
TestRunner: bnep-tester       PASS      8.18 seconds
TestRunner: mgmt-tester       PASS      133.28 seconds
TestRunner: rfcomm-tester     PASS      13.00 seconds
TestRunner: sco-tester        PASS      11.90 seconds
TestRunner: ioctl-tester      PASS      13.79 seconds
TestRunner: mesh-tester       PASS      9.99 seconds
TestRunner: smp-tester        PASS      11.74 seconds
TestRunner: userchan-tester   PASS      8.58 seconds



---
Regards,
Linux Bluetooth


--===============1134735383979572228==--
