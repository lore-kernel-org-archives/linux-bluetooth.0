Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C5EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 13:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999DB20771
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 13:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiXzMu2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgHKNuN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgHKNuI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 09:50:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB593C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 06:50:07 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id k18so9401477qtm.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2020 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=w+qODleQQsKHZ1WWrEjUAUHGpfYDNjuEG5I1xgDqiqw=;
        b=UiXzMu2ZQMNFIUP2BS80wsk1I6I4Vcbcjk7BbrsCYsZ/kdkrxO8KFydAOENZCAgTR0
         zP7SbgADrXj65RGevnYq5cXm8LtdEsDeAEWJ24EH6s9408IBPvj+8ILkhSgRitY4ZORZ
         xzRVsRpxlO6bFgJBZnvaJugJc1AOt4leoA/n9vqms2VsxURjnU1CeFu7SuuVWlMRjP8q
         vhjAK9xDy66Zrstgw3rFADDOMbq6at3WRWhfpxVWHrfBR/ktVqaobJnddDwY5jasu0BU
         dJs+519UfMGeLNRQWc6HGAtg8KXXtsgfIeI89kV3plTbol1lSP/cvPukX+V0pE2+8uvy
         T6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=w+qODleQQsKHZ1WWrEjUAUHGpfYDNjuEG5I1xgDqiqw=;
        b=A4t4Yftue9g9jTBg0mKGaR2ZCfZaQTi7TuKxwtHaMmpkgiN6BwSCb6H0S6tF9dgFmc
         57lMvgA17rC83C4v88T7WZf2NU4Y48cwPU6k7kbOBkSpb0yKBMJJPZz5gLQx95Ogin8J
         4SgGiv1xUTLafzm3FKWRg7/Jacm6wBl4UNV7OMdUmmC3n2Pju3vZhRe5+waarNvF+t56
         l4ib/dglx5FYpGx8iPAXCX4mwxyw964MY+OpnVgw9+uCCvlzEaJTIQvanH89qcvMBrBh
         xrDlVAFgbwHGBwzdY6mhISFNXc5gLfiCMawChVFSOc2tkTHW2CLcyaQOfLydWmMkuhGU
         RJ6g==
X-Gm-Message-State: AOAM530/yDAZ8bTgWd5c5FJ3okOp26r8JMxZ1M7jpr/DWLIIVTuFVxdD
        seC0mjexxPirvXwiA5lIR5hh/xNV6yU=
X-Google-Smtp-Source: ABdhPJwOqp69NLU1HYy9v1whcIGKYX/g0pMlB3Wl0qD2JfNwwNgQOXJ4LEk2w1FRpC7MvWvcM8aZ/g==
X-Received: by 2002:aed:3e90:: with SMTP id n16mr1140988qtf.37.1597153805984;
        Tue, 11 Aug 2020 06:50:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.202.113])
        by smtp.gmail.com with ESMTPSA id w1sm17910057qkj.90.2020.08.11.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 06:50:05 -0700 (PDT)
Message-ID: <5f32a20d.1c69fb81.54e64.69a4@mx.google.com>
Date:   Tue, 11 Aug 2020 06:50:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7420580290351379786=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michal.lowas-rzechonek@silvair.com
Subject: RE: [BlueZ] mesh: Fix application key binding lookup
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200811133907.8249-1-michal.lowas-rzechonek@silvair.com>
References: <20200811133907.8249-1-michal.lowas-rzechonek@silvair.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7420580290351379786==
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
ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 1a2a6debd00a ("mesh: Clean up handling of config model binding messages")'
#11: 
Bug has been introduced in commit 1a2a6debd

WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#23: FILE: mesh/model.c:115:
+	 * and entry with data equal to NULL */

- total: 1 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7420580290351379786==--
