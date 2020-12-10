Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5A2C4361B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Dec 2020 01:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCEB2226A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Dec 2020 01:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgLJBr4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLJBrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Dec 2020 20:47:45 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E445C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Dec 2020 17:47:05 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id l14so1693611qvh.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Dec 2020 17:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xOyIdVRmObwI7AjvRtTi7iwcOkpIoRE1MzvNbgO0blA=;
        b=IOXrQr4CXFcpWofEvBiwUDWnjSAfhai6e51o+AHhUvXwZ1D5Ba/kSXBrtc1yAjQIRh
         vfiButClYVSXsg/+4baeHUsvweFo0AXYcPbWWWUqPuubrp+6GFHvfeH49XKQQwOIDYb4
         ZfzHKL28lF2NHj1KjTRoKguMSyEskjpryAEx8BsMVv1kfH/X4KMAWDWdFRvgxKxtUuHe
         tf8HHvLCVq3coC4clLcEnaeF6Uhc6srgAwAFgsI/6xEZmKp3KNA0IYUz1hGWfysUntls
         G5cc95nRhGzrquKjtKmlI9bV1lHK+zFcFhWJgoCKx+fLJpERyL5/fMAfC477iJcYikj9
         FoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xOyIdVRmObwI7AjvRtTi7iwcOkpIoRE1MzvNbgO0blA=;
        b=hDrMNqAQSf+Ymiqb7gj51f4LaLs+Y2/UAUxRaVVUt2DWjoDfPvn8GishBHK8rdPc6g
         uRDLFK1yld49TwBg2y0/EwlwjrBfSIHxDlQsv5nxsdV5QzmaQLfSMpU5X29BV58xV0Q8
         K/DIYwrf/Qt9NRX+qAHKHoIFNHB7GvGKJW1jpo/u2zsWTRV6WYJ73845DiNpwczB5Q9U
         L8vMv9K4ODl4TaIDkh4M6o9WuzdtdgSqa394n+VHISlzRZvj9uYT3iVlCgvBkXZ9gNSj
         0ctAkBsA4nSleTg57xtrXhSE+iMezudaq9HupnXtWlPGlOB6uDN7bTls5gNkk8s4U4uQ
         drmg==
X-Gm-Message-State: AOAM532S/+8PJZYsclED8Ji/jN0TAh253lwz8VhfIDhVAXTLgypr4ZUP
        IKDFlOoFkhaUZiQvIwzIPZd8dfzvHpo=
X-Google-Smtp-Source: ABdhPJzkR48AO6S3PJ5ls+80sO5/yQ5ijf0ul8PwVHimITHoXo7jXpPHl7UuHnMXHGBpNrDf/s8PdQ==
X-Received: by 2002:a05:6214:487:: with SMTP id ay7mr6317569qvb.37.1607564824352;
        Wed, 09 Dec 2020 17:47:04 -0800 (PST)
Received: from [172.17.0.2] ([20.36.196.140])
        by smtp.gmail.com with ESMTPSA id t30sm2655269qkj.29.2020.12.09.17.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 17:47:04 -0800 (PST)
Message-ID: <5fd17e18.1c69fb81.662fb.f664@mx.google.com>
Date:   Wed, 09 Dec 2020 17:47:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7905044398775768693=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tpiepho@gmail.com
Subject: RE: Bluetooth: btusb: Always fallback to alt 1 for WBS
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201210012003.133000-1-tpiepho@gmail.com>
References: <20201210012003.133000-1-tpiepho@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7905044398775768693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=399381

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============7905044398775768693==--
