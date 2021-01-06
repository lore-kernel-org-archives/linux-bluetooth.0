Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14047C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 01:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA09D22D04
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 01:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbhAFBhd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Jan 2021 20:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhAFBhc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Jan 2021 20:37:32 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F6DC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Jan 2021 17:36:52 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u26so1294767iof.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Jan 2021 17:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/cMIokCqKoOhP5ptzFPmSaaf4gP6dMExcgVc5OMZwto=;
        b=mCLVywauMvapYy+yZdaPzqvHB3HRJvwQdM5X4iYAVnwkpInces1DreahNOfJW8OSCn
         a5n4Jy9m2sR+6YxGlpu3CAFJoN0BGTXtBqKwnfxUrNBxLa2u6Ws7QAa7X+bHEKpSba1I
         uv77XNzpzzlo6CXCFn10HKGQyia75ifpchJsA/DNt8ZCwNnQTRpUTdyVTGO2MjlVfnhG
         gqyymxJFaOmn71d39vnYECsVSEummHEyN+9Ewp2y8gcptW6y4m6UxQ2kKDlRTlF0W4HO
         DetaMhh2e/9C5zja72LuGG2mYjvlOn0Zpm56GD/DIqxYsUxp7bbhmqgeBNwXvoP9/7Tk
         ZzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/cMIokCqKoOhP5ptzFPmSaaf4gP6dMExcgVc5OMZwto=;
        b=DONwb1IKlEPFLdse+HgLxaNF6X6GUbxKw+L9lO3t8dJBpFadvC/C5nqoDXp/RZddox
         Ik35IPUp3p+DMqdiQtMSPC3nMUSAKWcQyAHD7mN8XSE1MfiEh2G0G0U8Jblp5KC0/TmQ
         583ra6JLOIskIVz1Qf0IxuoD8kbEGK2efbZwS26D5uzW/LN4bIejOQqu9r7tuLMyBUGT
         6wLU3izJ5AmLq36VD/Q4x6Y5Q4GxQTe9nOK2c/ZY5TPbC63uWlK66l7nPvEv8TcCWtze
         m9idLrh5eXQ1SnayyY7BXdg35hVu7l787KC6Bkzqg0BJp/R61AOFMAxflFeHej1kmfd7
         /H3A==
X-Gm-Message-State: AOAM53141xoLc6fmxTRsJ8KS9x8ukaVsDo1QV6pEEzSddCHjQCwBLRyo
        S1QFOftx4jEwKfYXaGbWBzkc7qgtBeeGjQ==
X-Google-Smtp-Source: ABdhPJy2PxjZjGA3QBtxFuAKyGSr/lThY7lB7ltr9Il/Ib+0m6lARURaWKOQqkme31yDHyBf6xTnKQ==
X-Received: by 2002:a02:c850:: with SMTP id r16mr2055774jao.18.1609897011705;
        Tue, 05 Jan 2021 17:36:51 -0800 (PST)
Received: from [172.17.0.2] ([52.184.163.61])
        by smtp.gmail.com with ESMTPSA id p5sm741917ilm.80.2021.01.05.17.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 17:36:51 -0800 (PST)
Message-ID: <5ff51433.1c69fb81.875d.3746@mx.google.com>
Date:   Tue, 05 Jan 2021 17:36:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1653227742691658446=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] shared/gatt-db: Introduce gatt_db_attribute_set_fixed_length
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210106005556.3550549-1-luiz.dentz@gmail.com>
References: <20210106005556.3550549-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1653227742691658446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=409691

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


--===============1653227742691658446==--
