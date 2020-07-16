Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF56C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E78204EC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 23:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS3Rlpis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgGPXs6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgGPXs5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 19:48:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94472C061755
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:48:57 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j80so7304087qke.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2020 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8NZbwJ+q0qt7nP7otXGqQ/bDUtTJDOQiBz+kZgwjkxQ=;
        b=YS3Rlpisc0dV46nf1TefjgkArU8iktOINSVdBLIu8QvVuePXuEKYLLnuJ1cIEBMa9e
         Tqg+YYLXU1QFAjhrY5qhqvCN/HDhy/XKiZ3ycLJVln7k1joCoaSPFG+Wionaf+KHv+LG
         jPdERZLlqR+7XwAuvc2LZbew4z+x3wcEx9OW4j4hHi0YLvpsIWpNmO7FEATJtEly/fVj
         fDfIjr27062RNmspLaL4G0yok1NqXJNx3vNNI/JUtqWj/V+rGp7Ngp8QxKyj0yOyck7I
         5JELqE85MWyeUmNHiWTcdZMJm8aaZ5GRPJ80fUniwrtRG8nfMIIS68KvJFUCKaFyCUsu
         8ptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8NZbwJ+q0qt7nP7otXGqQ/bDUtTJDOQiBz+kZgwjkxQ=;
        b=Mx0CohlHi2JZOBgfAHaJeajiylRd/mkVBzmBet4kaPk2X1A54RqJ+nsXVHb46ECA0D
         JtthSF/4jZk+0/RuyryCBqo+qARJ5hhx8mBWwoXRpvFDa3nxQvSioZJCa1hwpXI2D7IW
         QF8L1YtNUB229kmgEgr3HsAyM5YG/0ucF+0N9of1MjntSZHbfOpfr6mZi5ln5Srn5DZE
         52Re5svKzLU1t5K99YYFaWQ3/aYsV+7MUrbLOZXZ1D+qqmzq3PHQBnLz8u9xPa5G3kpU
         2BglbO2spt1PtuWWS9hKZyzeKqvfoeo+3Ww9XIhZ/mZarNGVXn0aAHoXAFSe5RqY/Obi
         wjBA==
X-Gm-Message-State: AOAM530NLIQIFDf+M32oqrlsuyTBHeQJVWF8iqImBEBQX0TVypgPj09O
        H43uvL/Dh+kjyDUh77ANfD5jr44rgss=
X-Google-Smtp-Source: ABdhPJyF+S5/olsweZG3kUnoelZTWBWI8VqcZN47JLEOVbZhKi1G+C2UN5//fl+tpAjy5Dt2KtH4JQ==
X-Received: by 2002:a37:7a42:: with SMTP id v63mr6770262qkc.258.1594943336682;
        Thu, 16 Jul 2020 16:48:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.161.145])
        by smtp.gmail.com with ESMTPSA id f16sm2806291qta.20.2020.07.16.16.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:48:56 -0700 (PDT)
Message-ID: <5f10e768.1c69fb81.68390.b524@mx.google.com>
Date:   Thu, 16 Jul 2020 16:48:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6301206506728767054=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/att: Fix possible crash on disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200716231857.934396-1-luiz.dentz@gmail.com>
References: <20200716231857.934396-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6301206506728767054==
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
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#17: 
   by 0x48E963B: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.6400.4)

- total: 0 errors, 1 warnings, 83 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============6301206506728767054==--
