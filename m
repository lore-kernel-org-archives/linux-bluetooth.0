Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950B0C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 00:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AACE20814
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 00:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvtAoqg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgFKAft (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgFKAfs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 20:35:48 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8706EC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 17:35:48 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id fc4so1956438qvb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 17:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7L69tmG4ge+CdDQ9ol5h+rVeqDlvsxJmsg+k+xmy1Fk=;
        b=rvtAoqg6CopLaMlqlTxpx+M4h8DxWiB4tjWjFW0CPmgTHASIOkPQcPJ74q5oVNzXJg
         Ji27oPVYUzwVDBdoQSQu3C+M8s979X6JST/Jnq3hr2NthGnvUMbzHC6QZyVFK7k9ouwO
         Kc0j2yTOwg1rH0TE9JPMimYYAtvApysODN+yInunJjyU+BOxr2fHYHpuXt3oLPYwAdN2
         Mzvnd9a4hnJrp6p+yB5MArT1p23t6qeAHzEZsgN9sxxdZvFbcm8UYhp42OHbqQvcLcsX
         lNz7VNLNAXeoirfDh+Udh75mC150x38fXj2jybze77/fFwNO4IE7BZerriQU0osQR2ts
         IA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7L69tmG4ge+CdDQ9ol5h+rVeqDlvsxJmsg+k+xmy1Fk=;
        b=FEhqgl2cyC6oWmjSPTabe3Fc2nXKkZQB1twDcwE8r4GnPwA8npnyh5QNubJqEMrE39
         2uFhwPeXq1Uf8Jpyt/NJiv507n6lV5lRt76L8iA3LlbRYRRfURDnZkIPt0hfQoD3NQFg
         grX3nFagr0Tvlp/W+y6+pj4EXXmGmOBA+9w4lNK4tken/IyGRTvR8/sBvzv+OyZ8QnOy
         CeicKZeWAQe1QHIKkf9r6rmXO289I40h8uqP5YDYXPx/fy1yJLfU4ckD02ZXXCy83a4b
         RqUGDZZHZ9Hc8yDO+/6b7ZR/IB+3jwCFATNFKE5yx35ob5gdkgbwnLNojdJMBugeUVV8
         WbaQ==
X-Gm-Message-State: AOAM532DT+xXb6IWOXqHlReihXML93no8eahaKAhWFEyjGiGLw+HmiWR
        3iq5OVM50+niz/dPoaAJXfcExSomLF8=
X-Google-Smtp-Source: ABdhPJw1uJTBaWpX4+qOy1UL+KsefNqopUiaUypt+OzQ7EVqVQ5ybuTE4tORXsiQ1ePpheW7i/VOcg==
X-Received: by 2002:a0c:8482:: with SMTP id m2mr5808236qva.65.1591835747584;
        Wed, 10 Jun 2020 17:35:47 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.145.45])
        by smtp.gmail.com with ESMTPSA id d78sm1043408qkg.106.2020.06.10.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 17:35:47 -0700 (PDT)
Message-ID: <5ee17c63.1c69fb81.ead3b.78ac@mx.google.com>
Date:   Wed, 10 Jun 2020 17:35:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6672828760119075187=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: mgmt:syncing configuration commands to the documentation.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200611002345.148620-1-alainm@chromium.org>
References: <20200611002345.148620-1-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6672828760119075187==
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
WARNING:TYPO_SPELLING: 'implemenation' may be misspelled - perhaps 'implementation'?
#7: 
implemenation) to the adopted documentation.

ERROR:INITIALISED_STATIC: do not initialise statics to false
#64: FILE: src/adapter.c:123:
+static bool kernel_set_system_config = false;

- total: 1 errors, 1 warnings, 90 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============6672828760119075187==--
