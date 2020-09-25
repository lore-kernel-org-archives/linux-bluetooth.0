Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB16C4727F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9557B2086A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhiUrGjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgIYUsf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Sep 2020 16:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbgIYUsf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Sep 2020 16:48:35 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5E1C0613AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 12:29:58 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t138so4008225qka.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2020 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TUWNftdL2/rH2psDUkIOp7AAXRSIdZ+HFrvB1pRXHe4=;
        b=MhiUrGjRdNmh4B4Pb7pPwrwlxwpOqtg1p+Pu4Pn8/id/VIgPVwq/0Fogxkcbmbd3Jp
         WEuaCjPi1JqweDfaFEmqXxS5TzpNVI+SuqJSbN16dha89tee1n8xs6Q9EIE3oQ0m69DC
         Yk6jth7mYSzrBbO7sehsA0JzMNN115mCOQuNho1imPH45WCLCmHCxTU5m1StNavKT2tT
         JBNyWDqgUCR2VwiBJOhDLqQ1yZ1fXW0zruDJJlqsE7yrQh1iqTzTPki08t6mxyzN9150
         jICRgE4o5X/34sVVNeSrRddy2KQH8IKozfmHqwahrzCBctU6Ag8E9ufVwVOv3F6xx1p8
         V5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TUWNftdL2/rH2psDUkIOp7AAXRSIdZ+HFrvB1pRXHe4=;
        b=OO6hr9cbx3e5TtZpba6sIsQHaSsgCaXgQHahyPCo8aRVihBy2oKQSoD9Yw/RZt/IaE
         UMBXHSkJ6/UmENUWnNcZ6BJ53lRHo0CsQobVUZJTztiNzwoqLwyIqP0/OMWl6rwSR60q
         cFs0YGBwoYSFEEnqtskZZU9VFrBzH3dj7Vk07i1YPqLuFZ2m1lO/crLtMyZy1PdGNbN9
         g8UtS+xn+TvAaONoK5zBaL2iVI/Cr/p9PC85CvQf4HusV3C85XEfeWDt96RfwpVd9qZ5
         4UDFRIQcoa9IoTiKWTp+BD5IWwkS4b6JMEpLBgvidqCNhN5gqBgXFfE8wSYW/hUmmcHj
         I0oA==
X-Gm-Message-State: AOAM5322JwNwzl4UMC7OzaTpvvPRF6yHbr657w8B27GTeOIT/zBSd2cy
        CDTa84zn8oM9PiK6Ia0qFS9oNIUNJqyTiw==
X-Google-Smtp-Source: ABdhPJwo7QOC1UsH42N/uKi0eb2Fghkkk91M5zd1kuAWpPtKaUjNwFCCknBdlTik66moI1KJcs0Xxw==
X-Received: by 2002:a05:620a:103c:: with SMTP id a28mr1571315qkk.376.1601062196957;
        Fri, 25 Sep 2020 12:29:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.247.13.124])
        by smtp.gmail.com with ESMTPSA id y22sm2270628qki.33.2020.09.25.12.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 12:29:56 -0700 (PDT)
Message-ID: <5f6e4534.1c69fb81.cb235.0bb6@mx.google.com>
Date:   Fri, 25 Sep 2020 12:29:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1852458766870671873=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yudiliu@google.com
Subject: RE: [Bluez,v2] device: Disable auto connect for temporary devices
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200924161949.Bluez.v2.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
References: <20200924161949.Bluez.v2.1.Iedecbb8c8ebb111b14206dddc5bea3c40dfa1771@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1852458766870671873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=355131

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


--===============1852458766870671873==--
