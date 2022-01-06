Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C8EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 21:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244059AbiAFVBH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFVBG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 16:01:06 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFA9C061245
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 13:01:06 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id p37so3522406pfh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jan 2022 13:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ued2tcLWPIHBn44hm+c12RNjnXbt9XW7j/xr/LhDBzE=;
        b=G9CZxRMbAdRcTJaPaWf9Zowl1hH8ImHMZnhfrCGitTvXtvrlhbrqdUIB6/JIrhLlGF
         NJVqenYqHpgmTvekUX/aOU/Ik9scwp3vhzvOU15yzKph/n9v+0devRMgjLxLquCfax/V
         b47p8pDNfQuwc1BOLxikJPlI+Gu/wvKfwJe7gEjPB+/o/yLgkImVGseIU5agY0bGeRJs
         /1uYnXdDFw5aveSZv5BgFD/2aOamcRRSXo5M+aCsMcWNQWKaxGUlC+DWZfGfDZKoNSEr
         e70ixHJeAX2P0THGiNOxPfZZKD1dc9LNA93Soj2bLAP5LQSMt4VM45JsFlJJzYAYrRNE
         7QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ued2tcLWPIHBn44hm+c12RNjnXbt9XW7j/xr/LhDBzE=;
        b=1mwPK35Nzt3VBIphiBfllLQlEuwtQZPtYxAejPflacqtJadzajoopS0eSvMZH/hGv5
         md2RAG7SbtPdIMtYJ+Qknk3u2eZQaRQeDWBZ42SrkxFv5pJD00vIPZ54wlS926RDJj1o
         I4GDiDtI2dSq3cQix4oLssxj6r+vcb1/ePnPj+DxSdsnr4amGT1oUwhUXJnRTF/Fmh/A
         ZcGVZUs+vVYRZPi1QqOOp4MwYbS6c6Rfj7yvBnXmINLCN56wB3zl1uK6qJWao2vheoxn
         2ldiGbNvW+9glofwlye1Ag3pBeDS04diSfzswsHRt8Ti09BtIu8MzVMCiAu3PANbzFVg
         L/ig==
X-Gm-Message-State: AOAM532laWCckMLHfIgZ6Jb59i1Mz+OpV8riwR8R9J1aDGtMSDKzlmzl
        6A/69OdCONwDuK8X9tj4iFu25RiKBwQ=
X-Google-Smtp-Source: ABdhPJyFw+J3oFr0iUbJPDtOLJjOA1atOKXslgHGzkhN3wcXYZsU4tleP+L4fA8uhqi/yQGKxyYnow==
X-Received: by 2002:a63:8c49:: with SMTP id q9mr20317518pgn.425.1641502866019;
        Thu, 06 Jan 2022 13:01:06 -0800 (PST)
Received: from [172.17.0.2] ([20.69.156.213])
        by smtp.gmail.com with ESMTPSA id m14sm3482581pfk.3.2022.01.06.13.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:01:05 -0800 (PST)
Message-ID: <61d75891.1c69fb81.1fe18.8df4@mx.google.com>
Date:   Thu, 06 Jan 2022 13:01:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5633673302996302248=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v2] tools/mesh-cfgclient: Fix config menu help message
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220106192632.28915-1-inga.stotland@intel.com>
References: <20220106192632.28915-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5633673302996302248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603296

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      55.58 seconds
Build - Prep                  PASS      0.62 seconds
Build - Configure             PASS      10.79 seconds
Build - Make                  PASS      1846.57 seconds
Make Check                    PASS      13.03 seconds
Make Check w/Valgrind         PASS      556.91 seconds
Make Distcheck                PASS      295.03 seconds
Build w/ext ELL - Configure   PASS      10.80 seconds
Build w/ext ELL - Make        PASS      1864.09 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============5633673302996302248==--
