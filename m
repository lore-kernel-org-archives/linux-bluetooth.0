Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CC7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 03:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiBJDJp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:09:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBJDJo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 22:09:44 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CB11EAD6
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 19:09:46 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id bs32so3587863qkb.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 19:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=NML8XnHibz9ueSzRuLcSO5pyJsWnI/ayMD8bj3I0k2o=;
        b=b9ci1+f4j3euEc+6BavEPj7Zj2yTOtX2o72bqPwjeJHS7EGBTidrBdS9Clh0YNusVc
         CrrRjX86WTE545snC5JDD1DsrgFvBGbyelW31/hnJPGQR9smKF7GmPE2xINkfTwTsW6/
         vusNMjVTvmdnPGxeTyzXQcwDeiEHbLXb9+I00Axo3C6s7LeQ93pUoBSYwZRbOghr8aDp
         grXBeOiRB7uDZL2nSksDbX4ZqLdzQhu42nGrzbXWmDKxf83hko0/vn/B/a76h0hkKy6h
         CaN3YAPHwobyX/bVGP7EZ03IMGH0niwP8B9eObRceEBes/WIIJsYKBlzjMa+fI7vdxl/
         kTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=NML8XnHibz9ueSzRuLcSO5pyJsWnI/ayMD8bj3I0k2o=;
        b=MXJKmrq7lZv/tx5Sq8t0/sfbgY62pr/wezzYIbmG63Y2OIppSUtZeGQv9XmPl00IsR
         T3a5xLM7OhtaOeyeGNYOdQ+aniNfeGS9ng34jY9sYvNOopJF6mllJuCASKCzjaQspGBo
         4z7nrs2kcpLZjqISi7LP60O2Rk7sbNxuyQ3cT4yMrBR6OSJiCTFpMYlFpd+T1Zz/J//8
         i4rYJTWWU6SwI14JMiPE5MnnoVPH9DacbmfYTpRvkbxPLrvOdb6AW7OP3+heJHla9Vj8
         YHNTw555BT7ZHNTgqr+8Mybo41Im3MVImifvq4FJj6UqHK+rctx0b9CRBO1wVt6S+3n5
         XIgQ==
X-Gm-Message-State: AOAM533RJDk9lHGGEniyRgH7fu0UwJJMzA1/jETHx9PSJda9MM+2Wipz
        gnaunw1SYDLJJTzblJA+IN/MJynxMyB+wg==
X-Google-Smtp-Source: ABdhPJxo4kyQwh3RjYRwz22zGkxaSXzuviBwc2gDOXBOxMMyFbtoTYVyGRGt/zXA5WiFN0IYqFVwqA==
X-Received: by 2002:a05:620a:198a:: with SMTP id bm10mr2882238qkb.544.1644462585218;
        Wed, 09 Feb 2022 19:09:45 -0800 (PST)
Received: from [172.17.0.2] ([20.122.114.22])
        by smtp.gmail.com with ESMTPSA id g21sm10285204qtb.70.2022.02.09.19.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 19:09:44 -0800 (PST)
Message-ID: <620481f8.1c69fb81.53c23.7e66@mx.google.com>
Date:   Wed, 09 Feb 2022 19:09:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2644047625293809500=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] adapter: Fix crash when storing link key
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220210000903.162318-1-luiz.dentz@gmail.com>
References: <20220210000903.162318-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2644047625293809500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612844

---Test result---

Test Summary:
CheckPatch                    PASS      2.80 seconds
GitLint                       PASS      1.95 seconds
Prep - Setup ELL              PASS      42.04 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.25 seconds
Build - Make                  PASS      1316.49 seconds
Make Check                    PASS      11.14 seconds
Make Check w/Valgrind         PASS      419.52 seconds
Make Distcheck                PASS      214.99 seconds
Build w/ext ELL - Configure   PASS      8.17 seconds
Build w/ext ELL - Make        PASS      1270.52 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============2644047625293809500==--
