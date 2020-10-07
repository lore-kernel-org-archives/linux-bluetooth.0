Return-Path: <SRS0=7SIp=DO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4912BC4363D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 01:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6B3207EA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Oct 2020 01:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIr60AUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJGBN2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Oct 2020 21:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgJGBN2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Oct 2020 21:13:28 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F848C061755
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2020 18:13:28 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b69so774542qkg.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2020 18:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=x2UuLNfnFwMsbMkJ+sK/nt1rv1nsS+zXU5lQ7LWqypY=;
        b=RIr60AUal/NmOVcfW6SfgwRbQWOHdMw/BOagEyqCQ0gvLzj6YWQlQIXiZ1FvS8FGMM
         7Uuo8X6Nm8I04hJIEO4FfLMzmcfMvTOuGxGVpQ07iS0lwSsTgYi8urcm1zD1ivgWOjmB
         U8/AmVln+TQcb4zwW8LOSXZpL4DCywZa2TF++DakVFUCVrETaqHBnZX89CiaNiszDF10
         W/LjVtAhNoRLBJCdZLIjTUFLHsNqynxYgKb4xh0dPTuuJgLhUwWcgR/w+h4SUPdo3lVN
         T1xyjIEGMq6DuvAEmwURQfPvHSs1i2P/EWZMGa3oKSKVFv3SBk2WaqGpG6jPzl2zt4Qa
         4Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=x2UuLNfnFwMsbMkJ+sK/nt1rv1nsS+zXU5lQ7LWqypY=;
        b=bhcG+oCNxWWoJisiVM/ImJu7IxeL3olsF5orNl1djJkKs8CohZD8VaT/J7Z2qDS7Mj
         g42GQpXyaIFOilMuYaZLZLMHA2CHAQUyzku8+E6EveFZiMDK5/Oe2/wirt8dbf5YJb56
         FBQ35cZYBhW25X3xO4Rm1wufW6V66tTHDKiYML0ZnHexUPsEa7SQhlb1R1//YtLjSNHd
         cjieNlrZ3JFJCzqWzuy1aGyJ5FcABHqFEyyon4p++ck9u//ZVbuOZn88PgXPCla4OBwd
         DR9yXdRdylnWlYuyHK+Zhs70EM6Fqg20esksNvyw4HqwwYKmRc/2Pe34/D/q+h/GXELo
         clvA==
X-Gm-Message-State: AOAM533AecvOD6c3yi7yuqPTUJalwLICZflBgXe3kZWCoAVBdVMcr4lE
        ap/6DvIPncL03LJYPDjk7v32DLYsCoymdQ==
X-Google-Smtp-Source: ABdhPJy8pVUGT+zK23AjgiNwBfzJCgxiwPLnXxON8ta5fb7U2fg59aaMH8jPJmk/42Z1yW/cmr9ScA==
X-Received: by 2002:a37:8ac2:: with SMTP id m185mr605863qkd.84.1602033207254;
        Tue, 06 Oct 2020 18:13:27 -0700 (PDT)
Received: from [172.17.0.2] ([104.46.1.113])
        by smtp.gmail.com with ESMTPSA id g19sm257766qka.84.2020.10.06.18.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 18:13:26 -0700 (PDT)
Message-ID: <5f7d1636.1c69fb81.c3b51.1e80@mx.google.com>
Date:   Tue, 06 Oct 2020 18:13:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3493847545021845200=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v6,1/6] adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3493847545021845200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=360563

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3493847545021845200==--
