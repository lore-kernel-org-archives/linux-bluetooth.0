Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5612C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 08:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D5C6196E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Mar 2021 08:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCVIw5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhCVIwq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Mar 2021 04:52:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D62C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 01:52:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id m7so11707524qtq.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Mar 2021 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KByjcxIqzBNWDHPuoT3XGtW3QW8KYeNleTymQKLA1/M=;
        b=d3Cn1V05zHuo4gpkD6bYSzVMenJjIW1pCjwFO6Eh9XbwUMgCPuNNwITMutaqyIb921
         SI2MLVSiQBDazTD15Q5bftv0/AWV6YNmXCJC/MCKWiCe9vtCN0CxqI5dPdzaSB+y5LUe
         ZOhJWaxfPQmKNlx1lY2Nhv5GQzT4f8mlm/6mHsU3XbbgMNoEFAhgImYTWgzMtc+M2D9l
         5TgJ9hg+Qd4ltvCbLi6gF9lsoc2OU8LHY1YkePD9jb74CunCJWemrcbopVGH5FOQi8La
         NXyu3moc4e/cMBnmyVEsLPXYcEEBN/R8tchyW636R3ZmU62yYizF43oixN3qPJgKoiId
         IcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KByjcxIqzBNWDHPuoT3XGtW3QW8KYeNleTymQKLA1/M=;
        b=Or0VHrt9vrrJJfkEPwfz0cxhGYftneRc6Nu+rFNyDQFVaV1YgeNwNqtKZksHFrcQ5N
         WyCKBhiO4CmSeU6Dj772PLhGXgdMUXaRDdm+6FojpFNGUQI59SFxgcoBvFYKbrEikFTz
         nX74nfL6MYcrS8J7j/m1EeIT1H1JfmIwa6+mX9V4G8tsn5P9uCtugNRW1lY/jA2vEtJp
         6C5iabuIRrvEYs4c9imMYnu9wr7B7owSa7EmGAItgcBTxUFeDj2ZV9aVfTf5fQbiQ4m6
         8Lgj4AoKKnTEbWgmTO4HuEcpPbH50NIadlbAA66m/WCdOAdRIP34poabS+vtT0loHFK8
         Gg9w==
X-Gm-Message-State: AOAM531uTKnc182Z3lIyQY1pD3zyL+LvjKy1AiLH5w/vSzfUzdYxH7Us
        RAthchsicqDh9adyM4cvYAh/lW+7PpTVBBso
X-Google-Smtp-Source: ABdhPJzZmhqWVSGrS9ZUBiVkCSEpeFOztGN9eWGSfvP+jg4pNYidv8KvlRxlbRaEEVHUrDUxSS5JaA==
X-Received: by 2002:a05:622a:1701:: with SMTP id h1mr4291091qtk.171.1616403165490;
        Mon, 22 Mar 2021 01:52:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.135.123])
        by smtp.gmail.com with ESMTPSA id p8sm8787313qtu.8.2021.03.22.01.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 01:52:45 -0700 (PDT)
Message-ID: <60585add.1c69fb81.5baec.30f5@mx.google.com>
Date:   Mon, 22 Mar 2021 01:52:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6201683226383765165=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v4,1/2] adv_monitor: split rssi_parameters into its own struct
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210322163554.Bluez.v4.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
References: <20210322163554.Bluez.v4.1.I8797a75fcc7c1e997f177b08dc23a1df0272e0a5@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6201683226383765165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=452665

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


--===============6201683226383765165==--
