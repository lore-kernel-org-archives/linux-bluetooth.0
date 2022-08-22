Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6F1C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 04:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiHVEqB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 00:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiHVEqA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 00:46:00 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888E1DA7C
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 21:45:59 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w197so10980019oie.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 21:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=YWWl/A9oVKdgezejoMgOhrgc59uJX4iK8V9f5hYvgkA=;
        b=CbFj6bneAjq3B9jgoJEfeidBt4q7h4fEr4+c7FKjOtSIzJD2YSA012Wkr5WzcDPgFs
         UO04KSR06MbzUn5/C+OvSxiy8Ckl2S1kv5207bThX2enZ9ap/hahxQndvTcXjen7VVNZ
         aLv4LGlDCr47t24TYYxBwoHz4TZeWDvDJcqcjs07+QJI5tun403Fg2eKC1x51cng+XrB
         OXsH9/zwGR4muAj/iaS5sBE+ExAcArQZsXA1LAZvTG8NPMArBktRxMnAjzwTr681lmfF
         XfTK3jqA3DP7muUFnAnMPdVvCWdt+5msncUWVn0hOMwDW9iOY2i+VtYrOf3KImEvbniF
         XyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=YWWl/A9oVKdgezejoMgOhrgc59uJX4iK8V9f5hYvgkA=;
        b=TKmVhaEIhwG25uHEV9Z6O/gEW9v278GZe1o9i8br6zifvFV+F1d2jcLdKfGi8GvOAl
         u3VPC8A9wFQfPYYeEAbiTERw6Y2Yo58N8FSDLLSGlUKy6ZnQnoEizBug0uq7XON8lRrG
         Pzm0hpD+OSJT7abGbW/wPCbrX70P2sNufs2pUXRfu6mNJCXS5xtvi4NYIWGS0mfK2aJc
         WLCSOif6WeqJqAj9/nI6fFhYTxbtBIuYaR7o1t3oIWZtxID6INKX0jwkIJWexpXU0eUW
         /oYsN/NFZHEBLeZmWC5SxURuIvPql9RFMdvozCXKOcfoIciZUqPtT9OCrNb0eCZ3Io2l
         2ljw==
X-Gm-Message-State: ACgBeo3PEJTRJSO2A43mLFLom8f7eThYeDTN5PWQT0mVJ+10lk7sI54z
        Ggjq/wbl7KS/xt+gpZkt/5VNVSoPH2yd+Q==
X-Google-Smtp-Source: AA6agR7id/F61q0HaRcl6u5J6+E3jDH5cIaf+Y+XPotaYtjxZCfVPkAe3QCsuCSQJTvMSyW8ods1rg==
X-Received: by 2002:a05:6808:1182:b0:32d:a9d3:4e0 with SMTP id j2-20020a056808118200b0032da9d304e0mr10248080oil.146.1661143558911;
        Sun, 21 Aug 2022 21:45:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.116.99])
        by smtp.gmail.com with ESMTPSA id 37-20020a9d0c28000000b00636c81d4109sm2791083otr.46.2022.08.21.21.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 21:45:58 -0700 (PDT)
Message-ID: <63030a06.9d0a0220.a840d.8f91@mx.google.com>
Date:   Sun, 21 Aug 2022 21:45:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7321361253010632383=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ronan@rjp.ie
Subject: RE: [BlueZ] zsh: drop no more arguments message
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220822023242.18162-1-ronan@rjp.ie>
References: <20220822023242.18162-1-ronan@rjp.ie>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7321361253010632383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669604

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.74 seconds
Prep - Setup ELL              PASS      26.48 seconds
Build - Prep                  PASS      0.71 seconds
Build - Configure             PASS      8.37 seconds
Build - Make                  PASS      815.78 seconds
Make Check                    PASS      11.50 seconds
Make Check w/Valgrind         PASS      284.35 seconds
Make Distcheck                PASS      230.86 seconds
Build w/ext ELL - Configure   PASS      8.37 seconds
Build w/ext ELL - Make        PASS      81.70 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      491.19 seconds



---
Regards,
Linux Bluetooth


--===============7321361253010632383==--
