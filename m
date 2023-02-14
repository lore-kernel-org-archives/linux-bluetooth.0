Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9590AC636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Feb 2023 03:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjBNDli (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 22:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNDlh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 22:41:37 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1057F55A4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 19:41:37 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g18so16254034qtb.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 19:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e2gyJm3SATnrM13pgjsSic3cfY+EjRmiIkLwC8l7vS0=;
        b=gKyL8nmGcs/E/K0bBZZfdvM85PyjdG17+TKFcaYogO50LQUgZ2ii/h1+Ka1B27ilBc
         rQV/DoVe5bQs/mwJm0hgoeMLwjnMMtnHqpIIbh+WbRzdB82sJkEJni5T+jqi1QnvqCFl
         EZvbBLFsbR2zRcx0oO2JPSi0eeRYHm7zQn+9qYEfsOZIS78qaSV0XSf4/S4v256yPktT
         XfEoXv1sTLipV2KXcWldcd3GUqBOm/ymCWrUhUX45bE7Qw9QDK1de/n3ODT+/kHL85iw
         pd2peraegmX/WOBMGsF6GgOIdGnuBc0i/yEMYxBXO4Xx4ZA5qbT8JbrUdYkpWBvFGMDc
         jmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2gyJm3SATnrM13pgjsSic3cfY+EjRmiIkLwC8l7vS0=;
        b=xez/jsjD48XSXEZYWy2JMH9BGwA6rmd/0FcZEtqc4cRkqYmmW1z3bggNBatNY9L+5x
         fYWPaknqM1H7GXJzzYJenqJir2oL2zQzWpLCS8TShyBg10cR0VbJrlI9VLSRFm+HbsYP
         pF+ju/uC4hZocCUoD9AT3m50fqzpFA6n4rmR/fz4LeODHDQyEGMRSDecoeLnZxqb1O02
         THhKI+y9D6joA1L8lrKoRieXE3B91LaXYK5XzTwK15yAdqQpLpzVFn0cDU7SQ2Sy+JmP
         f4aFnXWTY2wh4ui1k44V/+qqm2TDtImJN5nyIO2RQEiFWP4dNb+qBgn7kpAo/mGQEG+c
         heFQ==
X-Gm-Message-State: AO0yUKX1rHp4Fnl/3rvDxf5nFUWIhVBAHgJT3CESXHvV6BDbjbTPyIxA
        37PiWZT69RChdN9V0ZZcLjqm8ATr+s4=
X-Google-Smtp-Source: AK7set/4uMjWDEwlwcLBqjK0PlR7rWsq1nbYdSOEdg4SAmk5Yc+GhcTStQqEkQIO+yY5HlJ1FtDmWA==
X-Received: by 2002:a05:622a:508:b0:3b9:a441:37ed with SMTP id l8-20020a05622a050800b003b9a44137edmr1277677qtx.32.1676346096041;
        Mon, 13 Feb 2023 19:41:36 -0800 (PST)
Received: from [172.17.0.2] ([172.177.98.49])
        by smtp.gmail.com with ESMTPSA id i184-20020a3786c1000000b00719165e9e72sm11199742qkd.91.2023.02.13.19.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:41:35 -0800 (PST)
Message-ID: <63eb02ef.370a0220.d4855.1582@mx.google.com>
Date:   Mon, 13 Feb 2023 19:41:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1680211108586790886=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] mgmt: Use BIT macro when defining bitfields
In-Reply-To: <20230214021606.647442-1-luiz.dentz@gmail.com>
References: <20230214021606.647442-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1680211108586790886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721505

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      26.97 seconds
BluezMake                     PASS      980.25 seconds
MakeCheck                     PASS      11.31 seconds
MakeDistcheck                 PASS      148.67 seconds
CheckValgrind                 PASS      245.75 seconds
CheckSmatch                   PASS      327.04 seconds
bluezmakeextell               PASS      97.96 seconds
IncrementalBuild              PASS      844.89 seconds
ScanBuild                     PASS      1015.19 seconds



---
Regards,
Linux Bluetooth


--===============1680211108586790886==--
