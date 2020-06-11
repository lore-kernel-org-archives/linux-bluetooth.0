Return-Path: <SRS0=Bgmv=7Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA64C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 00:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E172081A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jun 2020 00:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkQXji1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgFKAfw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgFKAfw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 20:35:52 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D433FC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 17:35:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q8so4018044qkm.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/i/zK71gymuqJezGK4E7P7L8fTocECH46UpHtKjBkpA=;
        b=JkQXji1dktmNdFLiHn4KYqyDWxAGsrkWLgOAYgccT8pcfkogKBkJLI2m0KQdVS+7m+
         1nGl4pp/UIB+K3BjG11PJV3G3wovjOPfJfHPLpLPCidTsYAkHqd/XzcNUMvlESDC3rdm
         xqc3e+EuXGRtOA068e2tXx6nK62yISsAo4givfHrBi2aZDa7dPVS7RGCWzC7Op+17Ipb
         qqxjbbg2c1y/FJTLyb3Tx4q2ItqzCkFyMCruIJKOY6wSVZhbA61eVnmzkSlKmZoCbrw6
         xdt5Q3+GUqdF33/O02DJyLp+wPEtssZlQu8h/VYJtLPTeNezlOeAX8O9z4Zrun2MPwLb
         5cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/i/zK71gymuqJezGK4E7P7L8fTocECH46UpHtKjBkpA=;
        b=Bi1QHFfNJQH6SmaAlRd2x7+l9g/nruHnx854iDcLFHN0QrSrzddPq/b20U3/t8Xrf7
         AH2Ua0PTwb5suNEXsYX04UYrrUiWSX+R4RetrsrwelM1IiewmFE16NBH6vaWhLCTiLs6
         JNJpTqlUn6kFg3xW+EMetk5pGyHaF/JUhBvxfGmbFDMu1iJ/GGCimybkRihuCv6+PgQ0
         oZy1W4OzoegNzhlAFB2fXAAPpPVyWZqovloMWlWqVm4MOBGgT7B0WEIH5HsWzg+J8o3S
         qgGvRLB/1u9C3uHdwOmydus4VumJnxJFuyw0LIzBrHB2YWOmN0MGw3/fsybucbKK3vJi
         mffw==
X-Gm-Message-State: AOAM53169cRKniUaNHmAkneqCDe/6C0guwklHmnhn6AEVtMGU5k4izUK
        SOPC+i0/OSbL0x3zfXOhujkRlFDcCFg=
X-Google-Smtp-Source: ABdhPJw0mHyBYjrCJ1++zry3MjmgUrcFVPd5PaTIRkfHYU1ROsRRy2mLQ6Z5aLX4+jxIfvfN2yUQ9Q==
X-Received: by 2002:a05:620a:11b2:: with SMTP id c18mr5753556qkk.480.1591835750064;
        Wed, 10 Jun 2020 17:35:50 -0700 (PDT)
Received: from [172.17.0.2] ([104.209.145.45])
        by smtp.gmail.com with ESMTPSA id y1sm1203176qta.82.2020.06.10.17.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 17:35:49 -0700 (PDT)
Message-ID: <5ee17c65.1c69fb81.997bb.89d6@mx.google.com>
Date:   Wed, 10 Jun 2020 17:35:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7614803705217581314=="
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

--===============7614803705217581314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T3 Title has trailing punctuation (.): "mgmt:syncing configuration commands to the documentation."



---
Regards,
Linux Bluetooth

--===============7614803705217581314==--
