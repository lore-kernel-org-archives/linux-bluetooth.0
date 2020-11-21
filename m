Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD151C5519F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E2A22403
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTSdPKPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgKUBcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgKUBcX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 20:32:23 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287FEC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:23 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f93so8599481qtb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=aObdG6Nn57p+ixQeQ4/HnIPGn0MADVk4r/1P1xOZ2Vk=;
        b=WTSdPKPfW14kIBHirR7zKhMMPBwNnEPaE8rDNRqtdC/3vPREKTsUOYI+p/VRC7WKHB
         FA7BC0uWFCk9sKCifKgYk51q0Rn1DPogJJkG8QHIljYsAxFUiGSwkUZOtQqLmt06+UX0
         YH1MD0M/JLBqT9HVw+cliXNlRKkzzkQ4c/3irSeqMvfhtBDRjjpSWQtyjUnK9WW4JuHZ
         iknyWjGvfHz3esMCt5cucM3Of8oqb7bh+TuIS/IJZQu0d/dSxaKuMfWQi/BGgxQ0DY/4
         P8xZaMkv0lZ7s2pGeq90t4M38K2DkCfEd3+vAYXWumuMEUy4epHJJubl82CMIccQKzne
         2POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=aObdG6Nn57p+ixQeQ4/HnIPGn0MADVk4r/1P1xOZ2Vk=;
        b=gVo6q85UF3u2QA4rIcWkZWYAFTFoRyoqI6mHR/gt6JEpcbqlXpgH2peLcUmDqMBQ/k
         roYM2j+nXODvjqRTw6tAKb7DQaJjXBzRpDIXOevJWsSq8oGVjCd85u4BHphPq1P0OhdQ
         8VcJcaYA4oSBXCIqWfkHmMa4yt9/uoQiJfHTkF6MQv2Sw3HcDJC3Swble0fyL7p9akaU
         LBp5dpzsZWZ+f4yudpw4kgOEsVOo2Bvvlle4cqy+A9XoDsg67eJPKfSxvMT/uIKLxUFt
         6j88f3CdouD+jm/GViVZkBnZA6Rxvwt9RIeUE9B3E9EcKK93xg/RuWQxYfjk3z32KiuB
         iEDg==
X-Gm-Message-State: AOAM532/BB5quwxLdAkTBEfQASo3BEqxvI+V7UqF9cqU2dIhJPZd6cHk
        MsVxxVQNUZ7bAeUxYFWKDn9UrYpa0lMjaw==
X-Google-Smtp-Source: ABdhPJynXbtCUZzgaHmhV8j8UF1ITIBofs4Zp9GgeMNEUZidrobae5sBTV+s/qL8tSWm9ogOhxdXHg==
X-Received: by 2002:ac8:734c:: with SMTP id q12mr8208397qtp.239.1605922342326;
        Fri, 20 Nov 2020 17:32:22 -0800 (PST)
Received: from [172.17.0.2] ([40.65.207.225])
        by smtp.gmail.com with ESMTPSA id v204sm3385018qka.4.2020.11.20.17.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:32:22 -0800 (PST)
Message-ID: <5fb86e26.1c69fb81.5f9ba.6a19@mx.google.com>
Date:   Fri, 20 Nov 2020 17:32:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4728931249238719307=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, reoshiseki@gmail.com
Subject: RE: include/net/bluetooth/mgmt.h: fix typo in struct name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201119071038.380502-1-reoshiseki@gmail.com>
References: <20201119071038.380502-1-reoshiseki@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4728931249238719307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=387293

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
include/net/bluetooth/mgmt.h: fix typo in struct name
WARNING: Missing commit description - Add an appropriate one

WARNING: From:/Signed-off-by: email name mismatch: 'From: Reo Shiseki <reoshiseki@gmail.com>' != 'Signed-off-by: n01e0 <reoshiseki@gmail.com>'

total: 0 errors, 2 warnings, 0 checks, 32 lines checked

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


--===============4728931249238719307==--
