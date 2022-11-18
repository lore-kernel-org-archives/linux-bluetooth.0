Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E00C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiKRFQl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiKRFQk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:16:40 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33E997A91
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:16:39 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id c8so2683628qvn.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=92t7kdjW1W/4XRqtVOLRUhy8xejgl6/sf+bHJ0eZMeI=;
        b=WqQCuwWLDyYWX5LpWG7Zy89GL70d3RheWJ+fQzUgHbb1aCGep/9bfSux7B3GskHypf
         eL9DrqQBJyBfJPCAt3h5hbA9ulnW/LU1su+HUcodNWaycVDiWdrX6DFVcJJw909Lm0RL
         cSWj2obYfrnqeZXgQ5aeEZtWMerzxUc7R4KouZ/dDo5WFxi6sK05QLurJVLPno+JLQuH
         Rk/yCbybtceeJvPeje9daifuIelseVBj/y61sBSAanJGqdiO/p7QSV6o1bLl8wkPzBEO
         JmZHtDRdjXvhvRxeKQcw7eZHX6n3a+/m4aTRGOgSAe/VmUY8S07bJzHN8j66wqNq/Y2Z
         3sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=92t7kdjW1W/4XRqtVOLRUhy8xejgl6/sf+bHJ0eZMeI=;
        b=d8YuEUeYunmfcKLYLOYoRQhKd3FHyaq8z1T37rvpGQbent7tBp33VzY92peEjRjTPi
         kPYJ9ZtxdcXr1qXI7Rxh1z4WGEvcx/Aji7DxkgG+6cD+2h249rwhu9tlf1KhLQAopjcn
         Vt5Thqy+dR8M1x0kgoiibwti9XpUI6RxNGAjcgW+dS1c8jOLrhRGyGxSRU9GWMgzSXuA
         TxVqWtpKdEq3GkY2/adagXFZCgGY6BEMt1WnjiMmHd0t3OVQTYU0BKhEcidpU0h5gd6h
         vnD0FUNFmgYMwtUyKVOQgKn2IwupuFUo8nV0v05xkWZ06vjOVendObLy+NjStoJrEMkq
         Ed2A==
X-Gm-Message-State: ANoB5pkdUsxwJ9Uy8rDmooiKNVH4mZFWRBeZi5V2q2vUZeyecf/cyNzG
        h4/6+GchT+a5rsIthcz/Qe1I8zuMux6wWA==
X-Google-Smtp-Source: AA0mqf6iDqrC1sk8eK2K/m/trjJcbmnygEQCnYOWRzAMjXcy8JKU2FYzNRMGh8Ky1JASdvzgg0nmkw==
X-Received: by 2002:a0c:eb8d:0:b0:4bb:6b33:f12 with SMTP id x13-20020a0ceb8d000000b004bb6b330f12mr5500826qvo.5.1668748598602;
        Thu, 17 Nov 2022 21:16:38 -0800 (PST)
Received: from [172.17.0.2] ([172.174.60.129])
        by smtp.gmail.com with ESMTPSA id fp19-20020a05622a509300b00359961365f1sm1487965qtb.68.2022.11.17.21.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:16:38 -0800 (PST)
Message-ID: <63771536.050a0220.b6001.782c@mx.google.com>
Date:   Thu, 17 Nov 2022 21:16:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4205371191550621502=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4205371191550621502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      29.39 seconds
BluezMake                     PASS      911.44 seconds
MakeCheck                     PASS      12.48 seconds
MakeDistcheck                 PASS      159.52 seconds
CheckValgrind                 PASS      264.85 seconds
bluezmakeextell               PASS      103.92 seconds
IncrementalBuild              PASS      748.38 seconds
ScanBuild                     PASS      1089.33 seconds



---
Regards,
Linux Bluetooth


--===============4205371191550621502==--
