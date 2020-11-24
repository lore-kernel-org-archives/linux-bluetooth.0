Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E34C6379D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 11:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6172073C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 11:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duv5qvO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbgKXL2n (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732711AbgKXL2m (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 06:28:42 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4291C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 03:28:42 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s10so21582081ioe.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=3FjpitTXVFRrRASQw/DfWE5kfWKOmgJ3sb2eGrxq+F8=;
        b=duv5qvO/W6lFJp5eWfnvr4P7KaOe++rP5wC8N1Tk16ORlbYbM1X9KXqnGPEv+Zljlc
         PD7JgzrxJrCOy/zhjNuXJOaQtodkvGDk5uGcXEk5WPb+1fHkFjYP/Su/9y0mkyHO2aqO
         DUIu+HIjOB4rj059XPHerPJSqQ/c1NhvfaHJt+NQbMhC1dweYZx3MYSI1zC/pHX1Ysvv
         A5RPZBG2qLSuegoESC20QRbjo1LuRfvVyhLC4hnDY+H2rN0O5fUhNYOz3dFAiGTTXC8q
         3xtg5xgP6dPgWSpDtXvr1bWSShVaQ24AAqrYloqGFGoCsy/4AydZwqt5/QE6Gkitu3P5
         ccPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=3FjpitTXVFRrRASQw/DfWE5kfWKOmgJ3sb2eGrxq+F8=;
        b=kegqwAnQKSQ2z+rHV9bybknUGiZxscTNX+BpSOLWS/4sNs3klTuATZNtomRIzfnY+S
         AE0Ab+Qa5XaoW1XDBqthGAnO86xb0WAlXYUMFjahYNoTq2mNhGp3fwOTtppanz04z4a2
         unWi2K0OKAdEb/GNlX/JLjDE5fcDD7AV27c4uVLE7kZnBUsxTOp2QezuUcsYqvfuPltR
         53WfyzIF/Ujnc2J47XdTT4v/WLArjwuYT22A1wow2KKWnUENxiL5pp9b0D68bDmjVz8s
         g/DTH34Frw3M4VJd3iUNM1Lh71/NOoa0UDSMBxd+tSVQEwDPBhXoXFm1H7uhfKrshMSs
         Us3Q==
X-Gm-Message-State: AOAM532eHU+4kpo5oUGlGSH2pN9aazZU4Ej6VmTfkduUkX4Zq2+tquw8
        8mL6QQkMuE2kfLwcHozUMoXuR7Tj9CQ=
X-Google-Smtp-Source: ABdhPJzt8cDjdSJ9pEtIZvdUFc4Bon5uzTrVtGxNdgMsU9EzLD0u5uV9WTAxY6tVObZpaVF3/MGoZw==
X-Received: by 2002:a05:6602:2c8f:: with SMTP id i15mr3798187iow.66.1606217322010;
        Tue, 24 Nov 2020 03:28:42 -0800 (PST)
Received: from [172.17.0.2] ([52.251.112.138])
        by smtp.gmail.com with ESMTPSA id h16sm9407363ile.14.2020.11.24.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 03:28:41 -0800 (PST)
Message-ID: <5fbcee69.1c69fb81.4dcad.1cb1@mx.google.com>
Date:   Tue, 24 Nov 2020 03:28:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7069138237830425459=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, maitysanchayan@gmail.com
Subject: RE: test: simple-endpoint: Add support for LDAC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201124105733.85025-2-sanchayan@asymptotic.io>
References: <20201124105733.85025-2-sanchayan@asymptotic.io>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7069138237830425459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=390145

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


--===============7069138237830425459==--
