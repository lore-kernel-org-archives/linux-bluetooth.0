Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ECCC2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C7920809
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbkVQo9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgI1HcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgI1HcI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 03:32:08 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFFC0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:32:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e7so37589qtj.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=CKZ4SEQ4Bke5K/SEu9l5M4fjuc54+8bFSX8dzCbku38=;
        b=gbkVQo9f1eH1R2Mo4G+YsQ0vSCej0nXJPFzmevkL8XsIYCZuLAU7yhZXkSDSP2fQqS
         veJzDtfzuNmW1sj+Kmu+XUeqqsVMwHUash5RJd2f/wXd0ZNjE/6RZVjc2qkp03SrRyHq
         vHMn6EQ6ndywGhgSffENvQCUr+vnHDtNenSum4FlWTFOKaKS+Pkw/OEW+fXOGfneOtm4
         +JVLwg+/b7voeaOe63dprvxlAaS3278ADBFv2JTKPqmrt/TA78Vzdn0LhQ07OkS+/Szf
         335IS7SjnOJcNUVld0Mpa/GqpcEmAtiYWERziptvzo+1uunD/aC7/HWkrK5xY4y6DpCW
         AAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=CKZ4SEQ4Bke5K/SEu9l5M4fjuc54+8bFSX8dzCbku38=;
        b=Xe8FIt5Fnq77Vi85mEC39C+jKIAHGFCJH52spwpAX/BIyjFU64QlBCD69MxtUjehZI
         +o9UdaJ4TxOKvKzeCKWiC1Wj7LpoEyUCk56btgMyth8O8NQ6HCIyDuSMI5j2jFXBLtr+
         svnBExhmxqnWdxxWcr5T14zsS+HvKGSu01PVIT9Etu+T3SmrtbaqOpK2c18NhDZMeEZ2
         EHsND4ePnfGpWss7SFupqbbrsmAIZDW9OuL6+IZy1Be2IhN1qFTMT7EY6iTKSALSYK2A
         8lcUCTVPqjf5qUOlijx+oyFOV+TKRSqZ4d+tfStrQ4mkFEuZH35Xo6duegH5LZHLwA7w
         5wHA==
X-Gm-Message-State: AOAM530E+hjzU7Wen5AlxvUiqtcnnluwq9cE6QbYEE2T9q3UWK/zvUP9
        XuCGvSndAQTmH1XaWoKPkVqWCD7N8eckmg==
X-Google-Smtp-Source: ABdhPJxYOQLc6k2AOhQgfVST/A9TJAh9ZuK3EcQwUsKf1dX5RouF0uosKJ0VA9JrKqtfUwpDYLhvWQ==
X-Received: by 2002:ac8:1c5a:: with SMTP id j26mr338787qtk.48.1601278327581;
        Mon, 28 Sep 2020 00:32:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.138.100.43])
        by smtp.gmail.com with ESMTPSA id m196sm176079qke.87.2020.09.28.00.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 00:32:07 -0700 (PDT)
Message-ID: <5f719177.1c69fb81.4e1d.07c5@mx.google.com>
Date:   Mon, 28 Sep 2020 00:32:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0740141867994544079=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, machiry@cs.ucsb.edu
Subject: RE: [BlueZ] lib/sdp.c: Validate attribute search return value
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200928064446.17803-1-machiry@cs.ucsb.edu>
References: <20200928064446.17803-1-machiry@cs.ucsb.edu>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0740141867994544079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=356319

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


--===============0740141867994544079==--
