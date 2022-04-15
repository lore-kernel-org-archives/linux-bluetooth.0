Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 06:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbiDOHBT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 03:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350811AbiDOHBO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 03:01:14 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409C6EC69
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:58:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id i14so5971092qvk.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IzLLusUj3vMkw1LULr1DEqtS0DK91kSKKtDwKoZnULQ=;
        b=NfiThb/puITE4VfNMhcgF8K0M2KSsg8hkOI5kBfZpStKaZIUrmzuyow93r50NqLdpX
         TZhwR4wC0ZQMACNvTv3avlhKe9RZBQ9x8TBAfsWMuVdLwB4KHF3EIv1Sg/OkIn1yEjQ2
         ncexXUoeRsPLadZE3kCmil18QKTuexuMNxiowF+CfMgQUJKGNMxqeJ70ZkGcrwfdufYs
         /b6NtUH28czGjIzlYlLsOfFAQrqubrpIzi18I4OZiM2UFh/o87vuDcH6s6omfN2b8y7n
         /6bfouE5JQdkuOxFHw/2yJNBMHaVEGSq4G2C1Mcllo2djXdmdp5RRW1TSzbbYgRXJTl+
         gogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IzLLusUj3vMkw1LULr1DEqtS0DK91kSKKtDwKoZnULQ=;
        b=7kQlVDwEiE2r0tvv2A2zhbP7FkddZt16TMHl3tM0E2ifKSUoqg2F7gG3FENQ7RMbV9
         h4ZXNI/EBnIn997qutiX1k802/3WZblqrlv1X3jhLiZjCloDn03iZbf9WSyEXkBc17Q+
         cV2wqpJev1/Qr+ldrOknv07YspTP412WgqSdf65PYY3l7ncZoucY2+JkKEgvfycb+Md3
         KBCCKRoN0259v5GSgdRFCTNczymjd7PRUVYmd/Sb/CCigTf4HeEk+DKY8kZWOO78haR0
         MsMV7omReVypVKM0IMWeRO4j21SknyyH/AbhjgZxiQ/TR7J3f8rly2zc1DaMPxXB8Khw
         IH4g==
X-Gm-Message-State: AOAM531YAEkgCEHrZcMGb7w1cvElf+4Zn9ifnkTB8h+rdK8CJQQ+jhJK
        /nfhr8SgR7NVPpKLmzoNDl349eXcec1ITQ==
X-Google-Smtp-Source: ABdhPJx9+tWA/2fUDW7Ha066MfsxwbLMirEdSAmmd//8s5BSqMyQrbzJ/WVlVbMKELRSlt70ChhJeQ==
X-Received: by 2002:a05:6214:2a4d:b0:443:7f61:747a with SMTP id jf13-20020a0562142a4d00b004437f61747amr6571773qvb.34.1650005926234;
        Thu, 14 Apr 2022 23:58:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.108.234])
        by smtp.gmail.com with ESMTPSA id f6-20020ac859c6000000b002ee0948f1aesm2285279qtf.72.2022.04.14.23.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:58:45 -0700 (PDT)
Message-ID: <625917a5.1c69fb81.8d13.d1e3@mx.google.com>
Date:   Thu, 14 Apr 2022 23:58:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7270805665574582310=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] build: Fix bluetooth.service
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220414215242.554396-1-luiz.dentz@gmail.com>
References: <20220414215242.554396-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7270805665574582310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=632426

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       PASS      1.14 seconds
Prep - Setup ELL              PASS      50.85 seconds
Build - Prep                  PASS      0.76 seconds
Build - Configure             PASS      10.40 seconds
Build - Make                  PASS      1445.21 seconds
Make Check                    PASS      13.17 seconds
Make Check w/Valgrind         PASS      510.73 seconds
Make Distcheck                PASS      267.70 seconds
Build w/ext ELL - Configure   PASS      10.33 seconds
Build w/ext ELL - Make        PASS      1458.01 seconds
Incremental Build with patchesPASS      1549.66 seconds



---
Regards,
Linux Bluetooth


--===============7270805665574582310==--
