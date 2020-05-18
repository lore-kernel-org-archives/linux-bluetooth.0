Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB6620715
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 22:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEhgJZvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgERWgb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 18:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgERWga (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 18:36:30 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E52C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:36:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id v15so5565865qvr.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=o0hEglvlCJ/d1Cum29KnhqyUEKPtUoVBlT7H21f8VVU=;
        b=tEhgJZvzNQCIrFjPgFEdxNc++oqBkOkYu20+DY3mP12a3TRZtgNZK+Nzb7AR/v2xj1
         C5PPvMohbGYAWqmN1GgIUhEiZxZcNytfdYWmjBqhGbG3sfqnbC/1yq2VB2iXokidEM+5
         HXgRh1Yw7OSwh9aiwJjjDsk/qjtOq255sztcNEnPWe5tX9bl8nVKFYfS4Qy6qc+4HTqP
         QqosMlPYe6Rq60Ou4a/WT5kbWMcVs2wnUZvFinJibgggBhi1ZKQQ4VoLgtx2WyuXJJiI
         qCoKrCE24Ef+XOaTtFyVsyhsxQ6NqpRhvf0ofLNMZV6skoxTeEu3ovzB5DiRU4hzF46H
         n5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=o0hEglvlCJ/d1Cum29KnhqyUEKPtUoVBlT7H21f8VVU=;
        b=rS9/f3Xt49oU7YEFOaYLBU9X6X7JijMxZdBDk1b9xEOgrowbTH/NzDuq7F6JnWJbig
         g+fRbhLXfNQTn1iWTN6d/t5DUa3yfqEBtCAJrCXv+hSLerr43w2bKI4maRuKA4rxFpWe
         2LdyP6Paw+98N6U7mBBGKeD2FEcpmhirGinrjDkwx5y+BfL4WX6OlnR5JcN02+4rRjd8
         C6YcrnNT2swTVBdBkHRNu5TviBNMfVJSuyawQfZBf/05N6RsEfA7+4dSbGyvevZTshWq
         P4uaD00SO/fkXw8+oJB3gXzlXCls1Wn5bM2qAnq/GmBqMG8XqujmV8vDT2fspDCJKWj6
         OVdw==
X-Gm-Message-State: AOAM531lDr+7P6oC24OlFeCkqCTnITCIkagyRSlwhzmybKVpNSVwjLzp
        vJbJyFNbgpuK+VK6Qz0trAJIrs/Jy6U=
X-Google-Smtp-Source: ABdhPJwhSLzkGeSfBmCC/nihZBtc5QiIss1CGIjKWYGi1fcB1kmBRvTViUUL8F8ro20aiM3k5HTKTw==
X-Received: by 2002:ad4:46e7:: with SMTP id h7mr18265525qvw.221.1589841389714;
        Mon, 18 May 2020 15:36:29 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.235.20])
        by smtp.gmail.com with ESMTPSA id o18sm10816627qtb.7.2020.05.18.15.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:36:29 -0700 (PDT)
Message-ID: <5ec30ded.1c69fb81.8e883.c764@mx.google.com>
Date:   Mon, 18 May 2020 15:36:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5256566793909095241=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] a2dp: Fix caching endpoints for unkown version
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200518222908.146911-2-luiz.dentz@gmail.com>
References: <20200518222908.146911-2-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5256566793909095241==
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
WARNING:TYPO_SPELLING: 'unkown' may be misspelled - perhaps 'unknown'?
#4: 
Subject: [PATCH] a2dp: Fix caching endpoints for unkown version

WARNING:TYPO_SPELLING: 'unkown' may be misspelled - perhaps 'unknown'?
#6: 
Don't cache the capabilities of endpoints which the version is unkown

- total: 0 errors, 2 warnings, 47 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.



---
Regards,
Linux Bluetooth

--===============5256566793909095241==--
