Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE25C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0A820776
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBsk2/Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgE2Pgt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2Pgt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:36:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12727C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:36:49 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h9so2236793qtj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ncmsDrmaTNEUbWGLG7VTU956JJZkst+I8uTZfi4DRzM=;
        b=dBsk2/GcpAe15LaNVYRpsFBRQ3854HD6UKKMAI2WU8mBw2+iVxLGclsR6/d6bXlb91
         0KDuZhUW3PHNFkP0ZgtiYVVCmdpuct98vNi0tHTdLBSRHOcqZ/KY4gjYix58uyYGFFbf
         xEx8hlKe/XTqSHeyY4zZatdYQt9M2OQ50Ov8eM0EQWH/itIiAJweMZxp0E5pOtSnBud7
         c0Rfi3vrkfi5NacUXWmBDrc9sHbefDAEszcb67S65jlY3fj61VjqCSN9tXttsqIQmk3X
         HxfFWaqxKG0BfIYxlIgCB15kljaXMVbQOdRPzMZcfZpHGF4wdlTF+Cq/VACXKpdg0qPp
         Ou6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ncmsDrmaTNEUbWGLG7VTU956JJZkst+I8uTZfi4DRzM=;
        b=llin+gPvF0ulmZzShMFZ8CepaSzHuoYnkVg19SuTJhFLKKVfHNXtaKHcLidpYAVVeM
         ZjHOJlkbMt3btB8K1BAt9nhGUKd7PUZg3KgYEuuL2bY4cb3QuKQhWzrF7K6jzH1nSKMm
         vV4kH618DiThXKJ52O2RVnX/liev026Veh41t2wld0QZZN7xA4arr9858pGN8yAiwL3V
         6JUwGaqDAOJ+5khpYwiifSVzETmkarOAMMOY/P0XEgHfQHfaTzbVSgPonXkkMPg4kgSq
         nNBA3BgJ+3kSTfegcR1ubQ6EMCT8H/a8gyNKONIMZeHvXNv2a014CS9OyEUscFYm0ykm
         8KvQ==
X-Gm-Message-State: AOAM531Mkvrq3LvCtNpEwiKvtf+w9eit8AgutN5R6LGYU4SZDWqGGhFF
        friiv4ikhmAhIwZwx5F+n4YH/D86ZS8=
X-Google-Smtp-Source: ABdhPJxhks8dNGnM1nrRJAtF9wMi1XtTCt23YKdnV5MJ6D1CZ8BfxHmF0x5l1BS6ifu8ez5hTTuyRQ==
X-Received: by 2002:ac8:664a:: with SMTP id j10mr9051778qtp.85.1590766608175;
        Fri, 29 May 2020 08:36:48 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.47.33])
        by smtp.gmail.com with ESMTPSA id n63sm7161983qkn.104.2020.05.29.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:36:47 -0700 (PDT)
Message-ID: <5ed12c0f.1c69fb81.69d51.9e8f@mx.google.com>
Date:   Fri, 29 May 2020 08:36:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3409617582259645544=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [BlueZ,v2,2/3] adapter:set default system configuration if available
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529152940.208214-3-alainm@chromium.org>
References: <20200529152940.208214-3-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3409617582259645544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkpatch Failed

Outputs:
ERROR:INITIALISED_STATIC: do not initialise statics to false
#17: FILE: src/adapter.c:123:
+static bool kernel_set_system_params = false;

- total: 1 errors, 0 warnings, 320 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3409617582259645544==--
