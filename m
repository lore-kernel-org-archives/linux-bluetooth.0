Return-Path: <SRS0=OtJ6=EM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F1C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 23:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C010A20867
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Nov 2020 23:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBKRqd03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKFXYw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Nov 2020 18:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgKFXYv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Nov 2020 18:24:51 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9598BC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2020 15:24:51 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id y197so2716110qkb.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2020 15:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+R31lbxb8raXKCtsXKBcOlXVTAVpku0LfZDFqSrZYtQ=;
        b=NBKRqd03O7MVEZfz5ov823Qw8ibKdSFoyhQFKFc0OflBrw7qrijJPWqnXS3jSDpSy9
         yIpDwLW8n9j06qJdUKuUFqW1vWfKuhzc9S7p5KGxToWxUMbWMIOba6mFTsEDQstnEy2d
         Plp7JKOSCrSNHGJU8KPn45FXBzAfErTn1VePbGCMQynRKxiIA2qwv3oM9McLznNk+n+/
         KVAPiAM40YOomwkVz4fwmyoQli8jNnB/fBdPaoLdBGOyusu0GUjXuYmTgOyAE65xxZ0q
         lUS21uvtLQBnHxFxalY2jfq+BusNwfpdfbzGviBMxJR+v6EdYDW8IEURn4Qm3GjOrS1v
         ox6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+R31lbxb8raXKCtsXKBcOlXVTAVpku0LfZDFqSrZYtQ=;
        b=t2HRTP65SWQrdR+hHxc/FAbAYctvxaHTQ/XdboSdl76pfUjtPi3zPRDZE1AiuP5hc/
         qcvU/ABYkaSB08p3/WflXTgbTT2mZiAPARz9m99P7B4DaqkJV4e0l4PtL1b7BHKIaNk+
         a1kdkCA9LwCCTox9aB4aKLy2AGAb10Jz+aKYidRJ42WcYLUxQuVZMM6pLr/IslR4w+Jf
         tsntgo4Z1i8ZQZBYG6Nk+LJHYBaF+od4b3sB51FbCoChfF6gNfzOAXDUBxQAoOYvtxc+
         lhXFK7mfqXKH3MH+9muskdYwG1jZCB1bgSwmRpHw0/iNghtIKcS72ZYC4UI818XPSd80
         krcw==
X-Gm-Message-State: AOAM532lkc4GeUVVs+NUp5alXEVMDwF6Xp3LM3ZrobkASc5j72mVH7Y4
        Mhjf6EI+gi8+f8Vbooh3eFy6sUhk3DvTvg==
X-Google-Smtp-Source: ABdhPJyvL6JBSfpXggrNd5y57CVJ2XoP7c8njyt+6u9Qnj5pVy5ktQICeX3BQbnRzGrWGsIM7mW7EA==
X-Received: by 2002:a37:4f51:: with SMTP id d78mr3924988qkb.445.1604705090706;
        Fri, 06 Nov 2020 15:24:50 -0800 (PST)
Received: from [172.17.0.2] ([20.186.105.241])
        by smtp.gmail.com with ESMTPSA id l14sm1559899qti.34.2020.11.06.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:24:50 -0800 (PST)
Message-ID: <5fa5db42.1c69fb81.a8b83.ae08@mx.google.com>
Date:   Fri, 06 Nov 2020 15:24:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6218303704361273264=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mike@mnmoran.org
Subject: RE: [BlueZ] mesh: Only deregister io for the last network detached
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201106224811.1987610-1-mike@mnmoran.org>
References: <20201106224811.1987610-1-mike@mnmoran.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6218303704361273264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=379379

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


--===============6218303704361273264==--
