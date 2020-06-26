Return-Path: <SRS0=vuCz=AH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A3C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 22:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4291320B1F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jun 2020 22:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf2MaWE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgFZWSN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZWSM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jun 2020 18:18:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA1C03E979
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 15:18:12 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c139so10213760qkg.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2020 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hrjm8k8kWaANozoyI/5q79U7jBzJEkOuzq49IzTOrTI=;
        b=Sf2MaWE6WJo7TSCvfuXj+P0dAoZNsn3xEW2w5Va2CC9oC4qsS52sQnmmw1opSdJtfS
         Nv7ce46WuOKWcKAaBr22kAn2mkbROKNCqsDFaEqcRcyNikXcaI9qJj3GaoxlsGbKL5Q1
         dh/dw+vFFu+SB0h84ZuZfLM9/RS5wSWfEUqAySA2KDP8EAF6UohQABK9I8b5gVxiGACn
         FhWT4d4QAIKtxIXelRieBSTc/hkmXwTWUJWessZ2O3dp9/O/Aky0j+Fu2bXtJU5xp18X
         P00l4V/o4MWiLnPCNEVZ6ZEuyf5nNfA0dErwz9+KGj+nllXxB2o3//cJaOEupXxTmPZj
         WU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hrjm8k8kWaANozoyI/5q79U7jBzJEkOuzq49IzTOrTI=;
        b=D7gkm0uQ6QX2p/8OkqGg1cip3JoIxkvLSp8nYTGd28waidP4U55GWr/ZGlGZpfzA94
         ovgbQSjaQkjQbRNhk2ZlIYUMgNsBA2FQjchCh8xXbjjg20YV2ED1LQupwa6ynCixs9+T
         2PUSGaYIEi/uCZ3YzF00zmIv8EzjCboU67munplLK8hyIB+rsPCLWTb80b+1pZqPGp3X
         hpHw/J//APZTfHLLu2ks2UJY5jjzfG+11uogSynl4TizY0eIiPLEI1KXxZUu9OyqoBz7
         U12/5hy1T5qoeQQpPfKgX0YXRQy20Lf/1iyvLBZXyoCWkWCUblNDlot7RWICxfQxpnU2
         gdPA==
X-Gm-Message-State: AOAM533H41Q8jlZWcGagxxRJcvx1g2x73Bqs8ZGYW6jvmN2cHnWTH1uJ
        ITlHfxf0leqCuf26xRqFI7Rv0IJTGU0=
X-Google-Smtp-Source: ABdhPJyeq/10i3avnKRHd99k8bxpGKOF66Mi6KYCRRlmwlPoK0Z2CnL8Cd0uGgSZl8MvSrMZ02S2XA==
X-Received: by 2002:a37:d0d:: with SMTP id 13mr5264389qkn.234.1593209891403;
        Fri, 26 Jun 2020 15:18:11 -0700 (PDT)
Received: from [172.17.0.2] ([52.177.116.116])
        by smtp.gmail.com with ESMTPSA id r7sm9180008qtm.66.2020.06.26.15.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:18:10 -0700 (PDT)
Message-ID: <5ef67422.1c69fb81.cd3a3.4600@mx.google.com>
Date:   Fri, 26 Jun 2020 15:18:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7677329624274572586=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] mesh: Clean up config model publication set
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200626215907.201532-1-inga.stotland@intel.com>
References: <20200626215907.201532-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7677329624274572586==
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
WARNING:PREFER_FALLTHROUGH: Prefer 'fallthrough;' over fallthrough comment
#174: FILE: mesh/cfgmod-server.c:782:
+		/* Fall Through */

- total: 0 errors, 1 warnings, 168 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============7677329624274572586==--
