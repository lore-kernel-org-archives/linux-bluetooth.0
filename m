Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A319FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6946C2065D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 22:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrlmtQbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHRWuO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgHRWuK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 18:50:10 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9CAC061389
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:50:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 62so19927823qkj.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2020 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sOhqtxXJj4yMvbecvs4HPsnjgHd4D3czM1kjOjNEj/0=;
        b=OrlmtQbsvfz7Qc7MFrwmFfQpNAUXUdFdl6DsWrCJ7PQpkf2DTV8oQ1S8EWdDs/pTY9
         moPQRXb2uQC6YK+gfsdIJqEN1+BxqgxgPcYzZEU5odB2b0z63pP0+D/tq6okZX9PNYOh
         0cxM4eBVNQWgVCe/nsrKnvgrKaDmvtMz5qyawJjUiclkDMD/RHH0AVa9FkARlsgviqAv
         iqx5PiGKxAuMZKNV4CmosbgZuInN0AiVUo138vkyaQGdXkS8sGPGEvzMehdByz9Ll1nG
         xbU8FuR1c5PKGM9FooWzMuPY2FsAw2qW9oOoccHiMed1DgV5kugGdbN82VEoqEw1+JeD
         xnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sOhqtxXJj4yMvbecvs4HPsnjgHd4D3czM1kjOjNEj/0=;
        b=FtXIiYod9jTW2t/tyw4XbcqaNEj18GoXGzN9yVFyxIWe2qjU/uSVJMJcGLGz39nTu8
         4Cz/5kOil0lNPKJC06XFe4o5ewXiJ9iEf00zEk3rldwnyVWN8wmQrMA6IzAgqmgU2jGo
         OoishHXmrupA60nMP16ClQ2J7Yckg8HqCUP588Pu/WHtK65fus7AYQc/fiLmnoKqtgXX
         PBG4kHYv1uK1YNLzm2INGLGhivO27D3k+pW24QKuJ0X28qToQQeiCgYd867UmpOjNmm3
         4+enADYhARFIH8xxMOFbZVi1j91IGeOo0cvpEwLmcJqvxS1vqEJvGw69U6XBrZ47QIeR
         0iZQ==
X-Gm-Message-State: AOAM531kHJ4iTUxl3BeoaH84r/2Y2ChqL9g4Il2td2wlCgifvhuVFvZz
        ERlGb4A4ZblVUGWju/Gq9jz/g1W2sGGgrg==
X-Google-Smtp-Source: ABdhPJz3ZouduxAFvVeSzYDP9sIYiapD+iHa1CGxoNuhgSVj1MnwwGVWcdUtnl/i0AlbCBhDxwkeCQ==
X-Received: by 2002:a37:a5c1:: with SMTP id o184mr18951545qke.323.1597791008204;
        Tue, 18 Aug 2020 15:50:08 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.46.103])
        by smtp.gmail.com with ESMTPSA id q34sm26308706qtk.32.2020.08.18.15.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:50:07 -0700 (PDT)
Message-ID: <5f3c5b1f.1c69fb81.49120.b764@mx.google.com>
Date:   Tue, 18 Aug 2020 15:50:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3994007261342680672=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,1/2] mesh: Always set net modes based on node feature settings
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200818222208.50938-1-inga.stotland@intel.com>
References: <20200818222208.50938-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3994007261342680672==
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
WARNING:TYPO_SPELLING: 'intialization' may be misspelled - perhaps 'initialization'?
#8: 
the net modes intialization unconditional, to include the "No Support"

- total: 0 errors, 1 warnings, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============3994007261342680672==--
