Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFADC4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 01:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C664523A57
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 01:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgLRBUo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Dec 2020 20:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLRBUn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Dec 2020 20:20:43 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626BEC0617B0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 17:20:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 19so671876qkm.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Dec 2020 17:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sr7MQiuWqGXxotLVcmUaW/fQV9ml+5bSDzGk1swi3h0=;
        b=Dl7wncAH8jqCO4OxE/pPw76qT1ezsVCKLbVJALiNx6URF1/1s5crOwNlcEHy41AghQ
         QqD71qXRh+u5L69OFSd5T1mUH/cDZAtnIkRbT0WcyscT53ZwMz8DLVz2IOPmnBcSxpWb
         JiMA2T1xwFSGB3C/J0VdQVn7k4Uuttxm0NnMpIwYji9GmfV3638mHOAci625uW+IMtH1
         66CdTuD6kf8GNyCXJImY1su4HbEV1KtHgcnWWACQPpSItj8ksx0efVyPzzvgvvPQIxxL
         LDlnc0evvnMskoxbc7s+TVTfSXVZw3yrL6rFb8+li4zkZFBnCzfwRUdKsDuJXcNfK1+x
         9MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sr7MQiuWqGXxotLVcmUaW/fQV9ml+5bSDzGk1swi3h0=;
        b=n4Kn4yiyy0C2QXJK8D48PuLpbqozkzvhsSkC6o9a4l4nlFTDkjwPmLwiT90/LNwWN9
         O2sG4aoKA68dU2GHu2rN2FPuiZ+XyuTARGLB9r0aY9vEy0riwvr5X9LsBHjVIGoi3n3V
         TsUs8s6dYQ9toBwlZltw+HeM8glT7KOpTrd3WK52vSeyM5D2S2ywfE85EgDdun1EoXdt
         Y41P+tCbfv14ovdSN5yZTEGbuObSj2A8sZ56rbYpgHnCxPFRwhbkKZCYwkZyUS6fGcE1
         ZnHG5KDdgW0I5VnPE3jBz02TWi1hMnVg0Br8zTnAHDnU383uk/0ynIMDSK/Z3aj9IONf
         LFfQ==
X-Gm-Message-State: AOAM530g9KG0kpOcf/IxS7tXb2rpwouy36oGue4Fs5r5cMSPlW0zvFBr
        YhXVhYg2iPg6rTCy+Z4dw8Rm5JhTzdjcgw==
X-Google-Smtp-Source: ABdhPJy5k4+gxA7KjnBY4uYAKksIHQs6DVdPQGLzTWFGIsPM33ZOQIUQIsQW7H2ovpm450VyJatnDQ==
X-Received: by 2002:a37:5b46:: with SMTP id p67mr2429184qkb.124.1608254402452;
        Thu, 17 Dec 2020 17:20:02 -0800 (PST)
Received: from [172.17.0.2] ([20.49.27.154])
        by smtp.gmail.com with ESMTPSA id n188sm4998407qke.17.2020.12.17.17.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 17:20:01 -0800 (PST)
Message-ID: <5fdc03c1.1c69fb81.f9b11.0baf@mx.google.com>
Date:   Thu, 17 Dec 2020 17:20:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1977982120741645318=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] btdev: Add support for multiple connections
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201218001351.1442784-1-luiz.dentz@gmail.com>
References: <20201218001351.1442784-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1977982120741645318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=403877

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


--===============1977982120741645318==--
