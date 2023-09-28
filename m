Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C77E743C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 21:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjI1VAe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 17:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjI1VAd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 17:00:33 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6439319F
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 14:00:32 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57b72cef02bso5822103eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695934831; x=1696539631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5v5k3UEi/8sMMvIruJEbyzdaKrLc/gO7ydPoU0mFyMo=;
        b=Gy1dGrW/ZyFSMqimIiV3LvHq36EUJN532SsNVryc0JulZEqhQ76o9OL/Kndx1DgyMY
         MNuQgYLEBOwbP2dvcukl4PFbVBZstdSvuhgezQu3+E0g/QB15W9i/zhEggE5uGx5r7Mp
         j0tJEZhdOZvqPrh7LFG4Vafvfnc3REN0ThyyrEVDfEk20+7hv/8kjXdsj5XXhPWP2SEW
         V+WmETup1U/6ZCB4LdLAgVpivYYIFYK+F0QctrvMsBVo4jFLatgCIDD71i02zh1BZ6G2
         LeRfh1W2QfASm5vruZ1RSW/GRzNh3oa491EuA6ZNs9aUy3Od6MK6VKrsiTBYP7fkktQV
         wlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934831; x=1696539631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v5k3UEi/8sMMvIruJEbyzdaKrLc/gO7ydPoU0mFyMo=;
        b=RDUzp7dFAclwuvkfv6XlhfWP/pbfCuZHYDyhORVKp57ujHgxQKo3limjNhqwWmOVyC
         u8d3zjJ1P2t5q5p+VuGFCMdcyKhGv4QDrT6ftGijyhuxyrU+jMLO+y4BM9YSs0REY1Yt
         L2v29Qa2ewlHcCeGC/cZw8R96xkDNsHBeAhUFcwicsW3M3nKhAbiPniIkCCvyagZb3+I
         vw6JdSy/OlJ8OWtyOgAMsf0G4MqBTl6o8S1Vr8LFR1EfupcRA4r98jjqdHDIAAK5h+1g
         pD71XI0LAOLBaiUsH4bI09IJqQpSt8mlm/CjxmbIz21HLm+NSRyLkZU4u2uBsMkTyR4e
         8bNg==
X-Gm-Message-State: AOJu0Yyv8lC8HDwFp+tKoiBKZyv9DUOETf+GmQ7lrKQvhUTPPBJlZKhI
        IkYMSL+a4dbaIIwVfq42N3FtYc7mzeI=
X-Google-Smtp-Source: AGHT+IFo0d+V9Z9vRdbABeOzh5gLIsjGPBfZTMVRIaE069BXriWbo46/dk31gNbcL9dNu+f3Hp4hww==
X-Received: by 2002:a05:6359:694:b0:14d:6f1e:cfd7 with SMTP id ei20-20020a056359069400b0014d6f1ecfd7mr1470846rwb.12.1695934831271;
        Thu, 28 Sep 2023 14:00:31 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.173.32])
        by smtp.gmail.com with ESMTPSA id o28-20020a637e5c000000b0057cb5a780ebsm11567266pgn.76.2023.09.28.14.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:00:30 -0700 (PDT)
Message-ID: <6515e96e.630a0220.57bfd.c795@mx.google.com>
Date:   Thu, 28 Sep 2023 14:00:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7073208122413918745=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] csip: Fix not registering CSIS service
In-Reply-To: <20230928191347.2086937-1-luiz.dentz@gmail.com>
References: <20230928191347.2086937-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7073208122413918745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=788620

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      PASS      34.08 seconds
BluezMake                     PASS      964.18 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      191.22 seconds
CheckValgrind                 PASS      311.21 seconds
CheckSmatch                   PASS      416.68 seconds
bluezmakeextell               PASS      128.46 seconds
IncrementalBuild              PASS      1597.68 seconds
ScanBuild                     PASS      1264.27 seconds



---
Regards,
Linux Bluetooth


--===============7073208122413918745==--
