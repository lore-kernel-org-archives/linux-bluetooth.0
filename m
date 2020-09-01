Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ADC433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38E9206FA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 14:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfRFkaey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIAObm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgIAObc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 10:31:32 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028A1C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 07:31:29 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w186so1120556qkd.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 07:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=AQEebDuiApyMST9ZTulg4RdpITa592ypiLLzUObzPTg=;
        b=VfRFkaeyT5sJXBeIDV9kpajIq1yOHiBS0Ib5x4ncZtZAXizVJ8fmJYDqQkxyy28kVN
         sNgnEV4OlCtS5oR+dHiIJ4uZ7tpQ7c/mxvEsjjs1ADpUNINqTb1tKCx8aPyn05qok2M+
         aCRmQrqnEmpXZ4Xfa/f5EvA31d3kkb/9TfZIOGhq0FNccbE7Ac+MwH9U+3adbAYLCEHz
         3Loi6Mb2bJzWMGP44LjbKvRuSKzmeobI2Aua8cYboVrkVQXT2bQ9VYdWlc0njqmx2FXm
         faSiTE8ZKN3HlE96XjxXPHwgiO5sQZTrA7d1sGXXBbTzWllfPpZAvawskZLlA3gJA2iS
         YOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=AQEebDuiApyMST9ZTulg4RdpITa592ypiLLzUObzPTg=;
        b=OWVtpu4bST8GnZqdb39MarjjvOhiq1ipDDwVatIfYdKDXMxt3kmOiJ0cU8wROaI/Iu
         8pAQeRS2d71WheK2rQxtM6EIxsnRrbPDti4ra7104mlW0+Jf8wyS7Ou6cPNnwSFmAMHH
         otyxTSYtZWvm1XeKgQp3frbANGsXhgyA+UieBuol2+wqBixznToW4IYjt+tZ1j2of3WH
         oRs/NDRfkKd9kQuHe49Z3KU04u7RNkZWE0J/GtUjFmpWoBas7R9vzAc2gDtwfqbonmGm
         98Z23f+sP4SHOOwlR3vUM0fUj6Lp+NNvWb/kY3VwHr6XWUWVG6o8Ti3CNL1TG2eKG41N
         C4VA==
X-Gm-Message-State: AOAM5320mjHx642GjA4a3FXmNTd+Vqz+aZEg1UmwJwd+pXW22ZCzA8by
        CEua8+GCTrUtO+aomwddNNeqA/K+lh02/A==
X-Google-Smtp-Source: ABdhPJxgCRQ7zOv7th4wrJoAJ3geJjGf3h1AFCrrQj7zO7kZY96ISplqGtfeQMLTpSYgVxa6Q09nzw==
X-Received: by 2002:a37:9d4e:: with SMTP id g75mr2274521qke.186.1598970684956;
        Tue, 01 Sep 2020 07:31:24 -0700 (PDT)
Received: from [172.17.0.2] ([52.232.245.24])
        by smtp.gmail.com with ESMTPSA id b34sm1663341qtc.73.2020.09.01.07.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 07:31:24 -0700 (PDT)
Message-ID: <5f4e5b3c.1c69fb81.a7ffb.4f12@mx.google.com>
Date:   Tue, 01 Sep 2020 07:31:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7611905431545700016=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, daan@dptechnics.com
Subject: RE: Mesh: make SIG model header file locations more consistent
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200901115418.82056-2-daan@dptechnics.com>
References: <20200901115418.82056-2-daan@dptechnics.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7611905431545700016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkbuild Failed

Outputs:
ar: `u' modifier ignored since `D' is the default (see `U')
ar: `u' modifier ignored since `D' is the default (see `U')
ar: `u' modifier ignored since `D' is the default (see `U')
ar: `u' modifier ignored since `D' is the default (see `U')
tools/meshctl.c:53:10: fatal error: mesh/generic-onoff-model.h: No such file or directory
   53 | #include "mesh/generic-onoff-model.h"
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [Makefile:6791: tools/meshctl.o] Error 1
make: *** [Makefile:4010: all] Error 2



---
Regards,
Linux Bluetooth

--===============7611905431545700016==--
