Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 03:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B49221E2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 03:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+smDEOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHGDtb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDtb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 23:49:31 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D80C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Aug 2020 20:49:30 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c12so381086qtn.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Aug 2020 20:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NEu1QocgVLoaGMVACuICewytF2Fj42EX58ouyCXb0sU=;
        b=q+smDEOQePWETTuwhlfWOGGgqiRxw3AjECzNiPx36dUfQ+IYT/sNol6P2D1uQ2wkyL
         yk6PCyuhPn+opMDADrTeAF2DU1F2Ul94lOs8KtwYR9DtId5TgkVmR8RpqVxlipA8h/De
         yHHtCszZVttxHF3dLYCN3w+v3j6IsDeFu7upSepcKyk3ETiVDUxdrL3Th1Nbh6jQkilz
         5XRqLQDfsqGz3RbCj4w3RUEvV/7k9Xg01rFjMZ6AVnKOis0MYirzOhXWErISqz+VtnOO
         mFGvoY7TyyVXIrNSoj7VZR1nDK0Bm3dkUqEwN/R4l8bizKez6vFTkxXq/uAED1XqcK9G
         k50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NEu1QocgVLoaGMVACuICewytF2Fj42EX58ouyCXb0sU=;
        b=dX5Y1Ybb01eFlYXcNwB4PF93lBXqYbjkCr6vDXA86vBpnMAT1kvLoQ0O5pUBVCzJTD
         tPhwc01ykvUovGLLCIUg70NtXNlGPUenAVoCwK+lV9U23cCyJwH5hu//c0HufNgOP5Z2
         rK4AD81ZazYuJ91l3jVdri2LAOOwD8wtboPeYKIS2n/+soE5FD3HIVRdCanHGdIfmrxL
         xvWxdLXpMMPDl+0RIjukNhqBGXkeYi8bIiLAMrZnkhyGSeRysG4wAPQTCxjn6CV7FecV
         SmH5SheCmhqsIxlSHsKN81HJ+wZwaxare78wRdm74GjjotAd1X2wV+nN8vPdUMU7gQc4
         /fIQ==
X-Gm-Message-State: AOAM5312X5oJGXdJNw1wLniyCgszIYbM+7KvHkW+0QQ+jLsP1rTFUAwP
        4q7+fb4Dk8Rb9TeAyKroMd1Xitw/EuY=
X-Google-Smtp-Source: ABdhPJzkbDq1tPnWARF72l7Z2oDa29QsOv9Hpg5Lx3bFUsxjwuE3P5p9XWPECelkICIcNwrQE1abrg==
X-Received: by 2002:ac8:1a14:: with SMTP id v20mr12379916qtj.269.1596772169154;
        Thu, 06 Aug 2020 20:49:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.91.70])
        by smtp.gmail.com with ESMTPSA id v28sm7491153qtk.28.2020.08.06.20.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 20:49:28 -0700 (PDT)
Message-ID: <5f2ccf48.1c69fb81.6d7c3.7937@mx.google.com>
Date:   Thu, 06 Aug 2020 20:49:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8324179757018013729=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v5,10/10] mesh: Refactor heartbeat pub/sub
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200807013834.123263-11-inga.stotland@intel.com>
References: <20200807013834.123263-11-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8324179757018013729==
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
WARNING:UNNECESSARY_INT: Prefer 'long' over 'long int' as the int is unnecessary
#88: FILE: mesh/cfgmod-server.c:485:
+	if (time_now.tv_sec >= (long int) sub->period)

- total: 0 errors, 1 warnings, 784 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============8324179757018013729==--
