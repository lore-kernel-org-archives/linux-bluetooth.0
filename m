Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF88C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2282B22403
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1c1QUuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgKUBcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKUBcH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 20:32:07 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B150C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:07 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id y11so5628917qvu.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lP4BaIqC0kTj6VYExB7/QEWoQREaX6+35s0vnEjmVak=;
        b=l1c1QUuS8AJQFYlIsueCCQIsXBFHU5qHZdL1zpFQiXpHobC7SVobBCL2QeHp41bXvc
         SkAmqcZgSzmnmM5M1ogJQKX6Yob358xvTUDNq/e70BHt5he+Tm/yOiz07b4jbMbmGWAL
         LU9F2KIBO45SAsHpkj/XcjptdSt5kn/ysjsWkIDSjXqtIWUBkCZAR/8W39Vc6WmTeyYe
         IzImq1tv9PmNEcmEDvN3i0PW0xCRBiFuLuY3zsrBI3UlCQY2SOwR8BaQFhsG+enX3l/u
         E+YXZbtouZR28uzI94ToZJuCfvk1HdmCznsY3XpKbvHm7WJqb3wpF4fwTlFixOKjxll6
         aZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lP4BaIqC0kTj6VYExB7/QEWoQREaX6+35s0vnEjmVak=;
        b=RKx+BjfmFb4RHfCIgc2//ETmRrgr7/W348xiHI/HXQadxeSCYW8JiPKNO75IGw/Wp5
         N1VqzIVq6UtY82Ii4Gn/8f0ifiv/POE7VomrrwHkJbGQ5NpxGPGjZb8+ir9ubnlpNTK2
         TPX35N2XYAYWrUu1LfKI5IR5x4X94pf2kxWMHzXgaIcjU5kKzMLRmWD/S8qJEaHZOMkm
         GmnrZ6v5r2X5fk2NW8nLMcan4g4WSi3ivHEU85Inb8Zyu0chI6VRcJCoU4l+2Yrm16bb
         +zK05Uq5FWjfYf0NrB+KnJXIXaAjTtOwicePQYIVc4cjMUgjdQWulrIvI1bINBn90Cgo
         /2fA==
X-Gm-Message-State: AOAM530OqMLrAFhFFMRjDD/EcDH4wV/vKTqrPh+fUSlrUHweT3wjwc2J
        IrU1kh5tlRALY29F575kKD4xHvBymsp82g==
X-Google-Smtp-Source: ABdhPJwgdbOUaNqAYjkTfld76b4YzKSTUJWaoEtTOwCxgA4EC8UA7XyiE6SllFOAzK6y2iQibk9BnQ==
X-Received: by 2002:a0c:ed2c:: with SMTP id u12mr19385847qvq.5.1605922326600;
        Fri, 20 Nov 2020 17:32:06 -0800 (PST)
Received: from [172.17.0.2] ([52.184.225.157])
        by smtp.gmail.com with ESMTPSA id s68sm3282561qkc.43.2020.11.20.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:32:06 -0800 (PST)
Message-ID: <5fb86e16.1c69fb81.d9413.6147@mx.google.com>
Date:   Fri, 20 Nov 2020 17:32:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6367945202948595357=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, reoshiseki@gmail.com
Subject: RE: include/net/bluetooth/mgmt.h: fix typo in struct name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201119072819.384182-1-reoshiseki@gmail.com>
References: <20201119072819.384182-1-reoshiseki@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6367945202948595357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=387315

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
include/net/bluetooth/mgmt.h: fix typo in struct name
WARNING: Missing commit description - Add an appropriate one

total: 0 errors, 1 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] include/net/bluetooth/mgmt.h: fix typo in struct name" has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============6367945202948595357==--
