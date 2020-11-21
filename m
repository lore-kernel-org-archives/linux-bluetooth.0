Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987EBC56202
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5810C22403
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2V1WYGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgKUBd4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgKUBd4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 20:33:56 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F41C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:33:56 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id l7so2336235qtp.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=cUXFdcmvybjHua3liK5nt6Hx4zKeAPzUXgl4NDqYeAY=;
        b=Y2V1WYGxqk0dIY26jUtTpqi1Xy2OSB+MJHtypdzq7eph/H66fgy0dGCJ+GIRZu1S/d
         GYJRB+WAscyRGWPkQ/p6lBhH8KAaEc/fttBUgfeiSV+65n2aZRuaqMmcPLoWXhYuB6Bd
         ORjxU3Bs5pllvmIHUmhwohIdocaZhK087TacYFQ3rs8yraTnC0R/5TNLlOa44hrJSCWx
         1teKU/xQBHEb2gMMEpdjYyr6XKceku9MJhXNRJdrLAornjUJ8/t73t37PoZT8NS3uT35
         4YDsqh21ga7s1WjcsoeBx9NJzF0Cb2xlGpfm/9AE9tD7aRns5/3IDrH5QhzJ3aWzGKio
         oaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=cUXFdcmvybjHua3liK5nt6Hx4zKeAPzUXgl4NDqYeAY=;
        b=ACtmg7uNlwW6WkzgfMugFoC5DgUvyRKhaxmFNco4yUPrix2Pc0gnSICkyVlg9oT5PX
         41ra3qCd3gO/n59wr/2jjlRK8zo/Nj5zCs+fEfeKunB6a/50thGtKfd0+58nm3TjMIrI
         K2N0X6G0yZ3vW8jZkOotUOp+zCXPKwz3v5gM773Ds1dB06EzZFlKf33KAwYCX4YdbOW0
         z1+ue8nLn7PW0PewdSb0rrr2tyjUC/QRVgCLeen2igU4wFwjRziNakxvzph6Znu+wTZ2
         SghgnRfkfXB512JNJ466hxsfZMnOTkCqG7g4MKc3gBqAq56nhUMnNHYJ+uTMR/Fat3Cz
         SsSQ==
X-Gm-Message-State: AOAM531qZB00Phbw7IZtgjUP7cfr5PhKmHbLtH2B5vzwqkfWdxQvJlVr
        jiVYb31xAr/c3A1p3yACRWiFsMpCcdUuZQ==
X-Google-Smtp-Source: ABdhPJzIR6W7+Jl8inF2EPh3jepQEhZuZ5oCIQF/QWT/77HYubSnP6fBq/9QUU2itfcm8/HwHhWXeg==
X-Received: by 2002:ac8:41d7:: with SMTP id o23mr18776063qtm.368.1605922435190;
        Fri, 20 Nov 2020 17:33:55 -0800 (PST)
Received: from [172.17.0.2] ([20.36.200.32])
        by smtp.gmail.com with ESMTPSA id j10sm3176654qtq.59.2020.11.20.17.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:33:54 -0800 (PST)
Message-ID: <5fb86e82.1c69fb81.4494c.51fb@mx.google.com>
Date:   Fri, 20 Nov 2020 17:33:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8834351251099872232=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, reoshiseki@gmail.com
Subject: RE: include/net/bluetooth/mgmt.h: fix typo in struct name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201119073710.385004-1-reoshiseki@gmail.com>
References: <20201119073710.385004-1-reoshiseki@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8834351251099872232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=387319

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


--===============8834351251099872232==--
