Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C394EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 02:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjF1Cjn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF1Cjm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 22:39:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F1310D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 19:39:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b5d7e60015so4597216a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 19:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687919981; x=1690511981;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wnqpmgEQiQcR+aJsJX/mF69fdRIjO4rSb41gTU17R6E=;
        b=caRZ0wmXLciy4YgneIf2ie15QDNverx3SIVkHJkpN5d1yqaIEfJViPRChXoqtbsT0q
         lA5AhHR5kwc1OrJ22MRGhOAn7rPSFxu/mMNqMtVQHg7RnhTMHdicmVukesoo9EUuusyj
         vQTl3xYk/mF/6D7vJRECIRNLlVipFW3IArSl8jNl4z1ku/N9B3MpgIPA3g9EM6m5+RMk
         P+yYHpvZGxr+MT/RNg78PfLeHfCYhY7LMc0iu8ebwxKTCtL6I8ERX8rkTvzeoxPb8bnq
         wM4xQRqgPVm4m1tO9t7VJC9zjPL4V/TLFvmbzeuGmm+MNmbXvF2ag7kqSGdYw4KwyH4P
         ZVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687919981; x=1690511981;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnqpmgEQiQcR+aJsJX/mF69fdRIjO4rSb41gTU17R6E=;
        b=dM5O4pt9AMLYRJVM7WSPVzNeHFsxRkaA8vqe/yDqni2LNFl0dORLnZyPsYydLGH/Nx
         XNZoLO5cV+6WBlqRlZaJ5qpzncOdPQgusV8oJjaLX7WbiesOP8LVK9GlsWO+bpqGccZr
         9MLaZ9i8zPhIT+c/kk3+eH53IWB2YNlGST+EJrAfhvgHemZtfcX0SOd7IKTNlvLjsmuD
         bnyAWV2gl/rd6akHykeg1OrShFCQWLQtvJYjt4vwSq/EYbD+14RkgoZVvGWBFuFWqlry
         GYr8SdFlHnd+CBnkH7//626qNe11eZy4tFW1O98RIXqSc+txY54lfQECmEo+cZZdFEiW
         G/Ew==
X-Gm-Message-State: AC+VfDyBOgQOLSqzSVf/pPuat5+xbXfop29DFzER8gHZe9qIARF3VPzX
        UDm29mU2CHOp8Denk3VCTlw9SVaV3qM=
X-Google-Smtp-Source: ACHHUZ7Sp5M8Im+pGYubLmvHJ4qkY+6UblKjJQSrZ7TgufkW8YIS+3eiPVE6RVWClLf5rzySNFuJIw==
X-Received: by 2002:a9d:65c5:0:b0:6b8:691b:cd9a with SMTP id z5-20020a9d65c5000000b006b8691bcd9amr4209031oth.21.1687919980825;
        Tue, 27 Jun 2023 19:39:40 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.54])
        by smtp.gmail.com with ESMTPSA id t19-20020a0568301e3300b00697be532609sm4233564otr.73.2023.06.27.19.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 19:39:40 -0700 (PDT)
Message-ID: <649b9d6c.050a0220.a9ba7.4514@mx.google.com>
Date:   Tue, 27 Jun 2023 19:39:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4056390823066460241=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/bap: Fix handling of codec fields
In-Reply-To: <20230627234840.2696196-1-luiz.dentz@gmail.com>
References: <20230627234840.2696196-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4056390823066460241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760764

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      33.79 seconds
BluezMake                     PASS      1171.04 seconds
MakeCheck                     PASS      12.83 seconds
MakeDistcheck                 PASS      193.63 seconds
CheckValgrind                 PASS      310.84 seconds
CheckSmatch                   PASS      432.82 seconds
bluezmakeextell               PASS      130.24 seconds
IncrementalBuild              PASS      1001.08 seconds
ScanBuild                     PASS      1376.85 seconds



---
Regards,
Linux Bluetooth


--===============4056390823066460241==--
