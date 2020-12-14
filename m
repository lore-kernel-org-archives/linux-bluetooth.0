Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B109EC2BB40
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 22:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BF622516
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 22:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441140AbgLNWlJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 17:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502586AbgLNWjM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 17:39:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBCC0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 14:38:17 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z3so13171348qtw.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 14:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Rm5wRQ0uy5rdXhMDa26Mtmu56Q1A44xTM3YyarKveYI=;
        b=O2GQD4sLj6KXEtFxSQOVzqYq8d/4HWmnrxMGzy3tiB8xIrXCHSArROAlpPsWrrq8am
         jeTrIkQkBOwjdeVLlK6KOsljl7AwF/1GOfA0nmzwQl2/PAG7FeIgCYx2x3jKAhCzdI3n
         X4yiLvtiSkktt3DurcA+vaPctguosIMg56lL9CVfnV50mkP9irsPcSi6zwcahId4urKM
         EiTR+5I0KYFxRay0cQszL/QVG8sQESCpVPS9L245GgMjL5oxUh7R+W6tLTy4LGkH+q7e
         IWfdoZhVFJgLcJYkcT504m9gTsR/TKZx7KSd30tQLHH83aaEszm0MAoQb2G80vT2+53Z
         bGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Rm5wRQ0uy5rdXhMDa26Mtmu56Q1A44xTM3YyarKveYI=;
        b=WqCWKVEmTQA++ZU3Fd3SYz2DwOvBesfNDDEB3bs5IjOg0pYWjc8EXe+AkaT/W925y+
         DzO/tUFeI+WN/ZPJkSdwmHTnUIHOBfBF7TP7NxG+lin6NO7xlC83Faoh4QIc/ztWZL0S
         3MiY0e6UxgvlYB8j/Nzt7K623T2U/bi9/VnyJN3lwifl/haPXa4PwCOZzweqfUsJ6Z76
         nIiLKTFVuB6XmzudpFRLghbCkp1Bb5QH5xQJkbEatPxfgeum91j7GZH76tHoF6WlInsH
         CPm428dZaB4YZFqp+6rYKvuZQbl91yJXSZWjOHAIZuIE79Ok53r57XCGLlhhUUSpAZ4q
         Gpiw==
X-Gm-Message-State: AOAM532LvFyunzgESeF2OSQqG5Xe4WuRqOuJ+uD/ogmApI1Mg7GxnkdC
        pKqLCWRf/PHKtEX/icq5KvOGvaF8qNUlzg==
X-Google-Smtp-Source: ABdhPJxRwd2cZu3abjPjs4g5ISxQ9kz4Otw2BT9OJcGTRv8Y3tOFUDtN4QInVQO8eC78lmNXKuduVQ==
X-Received: by 2002:ac8:b44:: with SMTP id m4mr34413639qti.111.1607985496079;
        Mon, 14 Dec 2020 14:38:16 -0800 (PST)
Received: from [172.17.0.2] ([52.232.162.137])
        by smtp.gmail.com with ESMTPSA id f10sm6107122qtg.27.2020.12.14.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:38:15 -0800 (PST)
Message-ID: <5fd7e957.1c69fb81.1baac.c831@mx.google.com>
Date:   Mon, 14 Dec 2020 14:38:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5733743872788005145=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v3,1/2] Revert "input/hog: Remove HID device after HoG device disconnects"
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201214221502.392676-1-sonnysasaka@chromium.org>
References: <20201214221502.392676-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5733743872788005145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=401857

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


--===============5733743872788005145==--
