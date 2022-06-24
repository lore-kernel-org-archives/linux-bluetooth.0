Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1534AC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 09:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiFXJ3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiFXJ3L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 05:29:11 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE4355358
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 02:29:10 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h5so1123419ili.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VT4Wj3iNuoJAwrG3kdrBvcWSPtUIf5CkMNe7VYHMJIg=;
        b=cPMq1QzzazPdBYGGwX3OuCu/d5LWbf0Q0eR34juYGy204q4c5bH05deJ0B2CMl0lyE
         hsNUhpOn5ml7QGZZrQJtiYhIimuTUqCX06fCi6IJFIZV4PUy/XlYHNSJq6XsRsF//hUW
         UrCPElk7PDzHtGFyl9T8M3gN9fkBBo1iSQK78JkwuRDJvgRO4rpIIcqBFFbzbE6+XPpg
         4vwsWUnZAFcnXewlY2Y+nY+On+243GMBhChBx7zyA0YNwbHrhyZ1t+E4lxOgJ9dE8qHn
         Kjbhf7VCRr4TwB9D1mhKJo/ALmRHw/nYL9t0QmR0j+FI0JzAeEMXIyxywq8cUxsYq5Zt
         A04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VT4Wj3iNuoJAwrG3kdrBvcWSPtUIf5CkMNe7VYHMJIg=;
        b=vs2MwqZFcVLy4xhb10t5180eWyqlYYAGi6m9WqVZ/G1OVKqHYO/Y3MEo0ObaQ3oc7/
         uDlBDRahQHA+Fb0jAm1q+r34viVdijUZTchADu7bvCTDHLZKQmGxl7vLECV9MdeXT7aE
         g8FBVrm6A80IpmaYfQP7YflQm+W9p3L4YWU4yCaF0GeSvVmBOtyU7heHZd69wU72Hrgt
         tjTGXonXJpQr5zcPtzvx/7+lR+oDSAJ3cTXbj/0zImzlvhXxqQj6ZZmkditmqHLt3ZM/
         DvD2HR9F9Ik7+iEQTrIVT+Jb2YtEvW4FCQt41lQuyJJFFUWFH+62S5xcueUYg198Z2Qb
         6hiQ==
X-Gm-Message-State: AJIora8Qh4n66JC1H8LLgXK09kdIL1Cf0iir5gioo7S6X+5D/avgbEtM
        cOBB3wZ+ff5eZPNK/dj/kb5L46ySmuM=
X-Google-Smtp-Source: AGRyM1sTqT7axEOaqxLT5UABA7yS5l1co2YW/OMhBRobJ0LqiZq1/PeT8WElTWMj5CIZ0fcvPnFPxw==
X-Received: by 2002:a05:6e02:1685:b0:2d9:3cb6:c2ca with SMTP id f5-20020a056e02168500b002d93cb6c2camr7758259ila.242.1656062949264;
        Fri, 24 Jun 2022 02:29:09 -0700 (PDT)
Received: from [172.17.0.2] ([13.89.227.177])
        by smtp.gmail.com with ESMTPSA id b26-20020a6be71a000000b00669b5129b4csm1012947ioh.3.2022.06.24.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 02:29:08 -0700 (PDT)
Message-ID: <62b583e4.1c69fb81.57c65.133d@mx.google.com>
Date:   Fri, 24 Jun 2022 02:29:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4543077676287857301=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, szymon.janc@codecoup.pl
Subject: RE: monitor: Fix crash when using RTT backend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220624082541.51687-1-szymon.janc@codecoup.pl>
References: <20220624082541.51687-1-szymon.janc@codecoup.pl>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4543077676287857301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653494

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       PASS      0.73 seconds
Prep - Setup ELL              PASS      43.22 seconds
Build - Prep                  PASS      0.55 seconds
Build - Configure             PASS      8.74 seconds
Build - Make                  PASS      1280.85 seconds
Make Check                    PASS      11.53 seconds
Make Check w/Valgrind         PASS      433.72 seconds
Make Distcheck                PASS      225.36 seconds
Build w/ext ELL - Configure   PASS      8.31 seconds
Build w/ext ELL - Make        PASS      1228.49 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============4543077676287857301==--
