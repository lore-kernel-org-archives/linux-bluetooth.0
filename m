Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C8C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 22:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833A360295
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Mar 2021 22:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCHWkT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Mar 2021 17:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhCHWkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Mar 2021 17:40:16 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEAEC06174A
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Mar 2021 14:40:16 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id h7so5488460qvm.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Mar 2021 14:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XffjHFiyGyufR3UW/YrBQn9Hrf1u7isnUqFLGLkMs6o=;
        b=HfaQ9XfdOSsAbFOoXum3UUPUZ1j3oyULKjmBn7ASa5K27NmytFlEiS7i4b3qeI19gD
         DHqMlO1J5wddMCG+aXLjI7SLk2buJW0GeGPiushth990U5RpFRb2+JlyB69D4tr6X9Tt
         8CxNNq8b7Lz1ztpWEA4a+c7voC/KMAvh9r6RwSl2vojwU8ILX2DWdLH4JpSX4GeGbNu4
         Abl/JB+AvfNiV3WkTXAqBPfs3KOP0ta4RCYAtKeObPdyBBSEGtC3YZQmDMxz3NPgsv4R
         FNzLN1lH/8AK0IR5nK30ioF9WsRjKHyStub1wYHR8F+7ywJXR4eiHs2VhuZZFccNwQju
         bs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XffjHFiyGyufR3UW/YrBQn9Hrf1u7isnUqFLGLkMs6o=;
        b=rxheR/mP0XnUZYlpZaeqJ5xkSaJhPKwc4hLlQ5sL65ox5hB5O2jeVWyBFkDJME2tQi
         EGwBLWwvVTHj50dlAFv6IN4eCKngFdNneNYVmbd+FS9umHP/rj+TWlKBA/A2CffkN931
         b6OqLxh6dTX/iv/tZ0drWyTpj/2guuSVP4ZKg/sbOk4e7pj83rF84nfSzvS9I8UgKJIG
         jsrlog/WKmBlPd7yaUf1ooXmeTnN1oCOrJHqDsE6etOaK8TI+kToyqgVdDnZayFDAlZL
         1Z6eqOnWEwBj3oFaQcLp6H3OzY90wXXnKaZ0efp1HqFC3PwNWm5zR0JFYATcAn37ZH5O
         qfAw==
X-Gm-Message-State: AOAM532vNTOjddXnc47aztKnNIzfzBY/H9XHyywyMmdOYTv6Bfjq9VlW
        L9m/QbBu0r9EFvxel1ml4PNSGmDowQ4=
X-Google-Smtp-Source: ABdhPJxhWxioPnjgEHLxikcYKVbWVkA3cOGoXRMlxPPmQvYZCInLXfdweYQoZmdf8E1rHb0RLIGOag==
X-Received: by 2002:a0c:9e4b:: with SMTP id z11mr1086894qve.27.1615243215349;
        Mon, 08 Mar 2021 14:40:15 -0800 (PST)
Received: from [172.17.0.2] ([23.96.29.193])
        by smtp.gmail.com with ESMTPSA id y1sm8559711qkf.55.2021.03.08.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 14:40:14 -0800 (PST)
Message-ID: <6046a7ce.1c69fb81.208f2.5167@mx.google.com>
Date:   Mon, 08 Mar 2021 14:40:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1615895710880725622=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Fix invalid access
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210308221046.339931-1-luiz.dentz@gmail.com>
References: <20210308221046.339931-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1615895710880725622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=444121

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1615895710880725622==--
