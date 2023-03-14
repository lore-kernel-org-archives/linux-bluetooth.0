Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B1BC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 00:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCNATU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 20:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCNATS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 20:19:18 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994721A947
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 17:19:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z6so15250936qtv.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678753150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mGtZ8OuGeeLzch0j/v5L5bkgs0pmIjaG0+IwoFelo3c=;
        b=OCE0RNA9VoOIdtWJgayOOTpKl97miHZkMPe9cGGrOsFfprHD/0KlMsjNGtz5ckMjoK
         h6O+HBTW6UEqY1SkPqjtkFsehle1ku5MUwVkZi0KK/StjBITyySa8YCGH31rcjjSKmcj
         kl8QI3yFvsYhagGJmAISY3IQJEiQfVsK9jDXqU5FhBwH2ev2sdm6B8Cvh2wc0wad4MpO
         Dxxp9JTCNdikTi8pKl1iVvU3PbLdLrbgpbYSmTanJ3qnrzvmSF8YfBdc+3KW8EnhFL16
         gfKEq6HYEsMoKhxgeHAJ1ZZ3qI2NBz9KCmzwsr80Pth0/ODW//bHA9+s1DOojHAWDoKV
         5TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678753150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGtZ8OuGeeLzch0j/v5L5bkgs0pmIjaG0+IwoFelo3c=;
        b=48K/eO2f5Q5a6pxLPEogZq+y5ArwptLvJztMTh1jDPeeMDooz9SDVuElVY/q0pGTFi
         Enn3Vc5Bjh/toPJpmYBoidfvdvkLDy027VULH34lCjUpg/WQJlnrXyOLRPfodnJazcJC
         BwMd6H/ZI0agwgHdQQV3eLH+MWFK0XWhQxavil+jLYc8qXhdIXut7WhKBh/k6xZbrknK
         aWH8RgiGmBhPKlNHRiRb38bzJJhod9c7o3d0EuDZExhw8cj5PuxpGb1fdZxjUqFVSzjI
         v97N9lHYhABhAxNqk35i9wEyOcNynRE/uZJUMZKn2MmLZjh5z9Nbx+sjPaemybupwlw/
         mG1w==
X-Gm-Message-State: AO0yUKVqv3iW1ApsTOc8U8spARpObRpoYOl25k3tru27qb9KDF8dDEqF
        g3HTonB7AbfB4HNa7+XsA6IqzFWrBSk=
X-Google-Smtp-Source: AK7set8sfJxbr9Mgi0EwVxnHbV3Qh8BsF8KCu7WDIz1+KWlLszCswPVvxILuG3NjnjusloSRbRlf7Q==
X-Received: by 2002:ac8:5903:0:b0:3b9:b817:e9a8 with SMTP id 3-20020ac85903000000b003b9b817e9a8mr63903736qty.27.1678753150562;
        Mon, 13 Mar 2023 17:19:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.98.54])
        by smtp.gmail.com with ESMTPSA id n67-20020a37bd46000000b0073b99d515e2sm684164qkf.44.2023.03.13.17.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 17:19:10 -0700 (PDT)
Message-ID: <640fbd7e.370a0220.2be8c.3758@mx.google.com>
Date:   Mon, 13 Mar 2023 17:19:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0924697557996635609=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: [BlueZ,v3,1/2] mesh: Fix uninitialized memory usage
In-Reply-To: <20230313231152.59147-1-brian.gix@gmail.com>
References: <20230313231152.59147-1-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0924697557996635609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=729657

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      26.54 seconds
BluezMake                     PASS      759.22 seconds
MakeCheck                     PASS      11.27 seconds
MakeDistcheck                 PASS      150.04 seconds
CheckValgrind                 PASS      240.84 seconds
CheckSmatch                   PASS      321.44 seconds
bluezmakeextell               PASS      97.21 seconds
IncrementalBuild              PASS      1224.68 seconds
ScanBuild                     PASS      977.66 seconds



---
Regards,
Linux Bluetooth


--===============0924697557996635609==--
