Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DF0C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 02:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCJCII (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 21:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCJCIE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 21:08:04 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA972FFBFC
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 18:07:50 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i4so2198493ils.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 18:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678414070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/CbAIIedm6vGtG/v1B6TsesE218s2EHKewqBQckpDcQ=;
        b=V8Cnwr9FLfStPbzaxgZx3tzJSGv2EeyXf0s+YTJWklbFkUprparpf1ErcI4Dz03dVw
         ktJD9964XTX8rYWUE5RGg27+oME6s6OXQ41rVelCzsx3DYqgYYB5siLGwUbhL7c2jaFz
         q+DmJYP3NighjKLMYU+qZpT5xQZE3K9gLLHctJlMO1ESI3DkXmFvVqyeau3tuqyeXzP7
         b0M3Ll5Nz+iSPsuipTPMgzPYOiF4TF1so5UgS4LL5o/f050Gf1LSloc5ty3cVBTtacWb
         M8uAaxj5H4capAKtkmz578tmLSLyZ1NuwrsNA3GePpaB7HwCt8R7/TCSEFm4gMoXh74G
         L+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678414070;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CbAIIedm6vGtG/v1B6TsesE218s2EHKewqBQckpDcQ=;
        b=IObfBuGodlfAjSeG7ylfZGmiLPq96G/20RBmInTm7IquG23t3X3snJ1Ha60ctE+WUu
         VY2QC2H8XXQpzzOF0kzeZ8ejcF2cxltlaEXivGvUyDvOY35+0MmnvS1fOHMSvu27f9hd
         H97+MqNPeWihRUeJWwS2d9YMuAI4s7EgtkHiBDAPOncIFI9rFfebj6q7CHcZblyv4jpi
         vd+N0p/NMURyPN4CfWeWd9AsEvd+O/0MVvksPrkWRAUf80kFsY25Tfb+KsORYiQOMkX3
         ImmnjwA9b88FyLeT45iFpq7cInThwZXhE36rbNb8ZirGgsltt/OBi4wVXL7wk22ATk8P
         XpIQ==
X-Gm-Message-State: AO0yUKUO48d7SWORw6uO6RD9u8QpH8LNIqEmZhBKuFCeS0KyRE7tzeOT
        5Gesp2gSKG+jP91qRxsY0mQpWkBtq+c=
X-Google-Smtp-Source: AK7set/6bukSXDgfu9/LNuLYMBjEQi6W/Mbc03F5Zyfretr8dQkW91rEtyNVtVPunARJW2dxAvpkKA==
X-Received: by 2002:a05:6e02:1608:b0:319:e3be:f056 with SMTP id t8-20020a056e02160800b00319e3bef056mr21103941ilu.6.1678414069909;
        Thu, 09 Mar 2023 18:07:49 -0800 (PST)
Received: from [172.17.0.2] ([40.77.93.32])
        by smtp.gmail.com with ESMTPSA id j21-20020a02cc75000000b0039d750a1823sm266661jaq.1.2023.03.09.18.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 18:07:49 -0800 (PST)
Message-ID: <640a90f5.020a0220.6d674.094d@mx.google.com>
Date:   Thu, 09 Mar 2023 18:07:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4880072144557024204=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] l2cap-tester: Add server tests for Ext-Flowctl
In-Reply-To: <20230310000154.3396458-1-luiz.dentz@gmail.com>
References: <20230310000154.3396458-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4880072144557024204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728436

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.32 seconds
BluezMake                     PASS      770.28 seconds
MakeCheck                     PASS      11.63 seconds
MakeDistcheck                 PASS      149.17 seconds
CheckValgrind                 PASS      241.50 seconds
CheckSmatch                   PASS      321.03 seconds
bluezmakeextell               PASS      96.68 seconds
IncrementalBuild              PASS      618.71 seconds
ScanBuild                     PASS      973.25 seconds



---
Regards,
Linux Bluetooth


--===============4880072144557024204==--
