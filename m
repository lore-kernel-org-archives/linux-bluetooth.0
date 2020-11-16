Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A02AC63798
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD2C22453
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Nov 2020 18:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUbAb1TP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgKPStU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgKPStM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 13:49:12 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EBC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 10:49:12 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k4so7886031qko.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 10:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=C7VQSZZs+yzUohKK+fmc7WxKviWP4HmJYUjjMZ89bTo=;
        b=AUbAb1TPHrMJeOq2DBeAbOx/sGh9a27eDoQ78Nj5Yyx568CkanW5HZdTA/jJepbBWU
         q3dpD/Iv1aLUJ0KS+4CP5LNME8+9OHtwJQMeGU09peC+n46zPZjLsqtwYX6XUS2hrfrf
         A87f+s4U5Pj3eslQdVptNngSr3pmRvHWsskwyvWeWd0kPVVmxr/MscKv04Ajpxri1eZd
         3lZyowAJfv6fQA6uVxofzW+ABV1vOMQOH9kdLT54VNMdBhegKzHDcQ71rPuBWjqSCOED
         YSefYVk5x1mvOJrb9PfSGTBNGAdJo4ZIXjA8OSYImw2fflxgDNMjgcfHC/rZCaCS0Wze
         3ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=C7VQSZZs+yzUohKK+fmc7WxKviWP4HmJYUjjMZ89bTo=;
        b=DWyky8WqPOXFb7EBrWHUTIyLMwA5xoM7cgtj5DbrAoRk6xIGgm57weF0ZsKnwO09rZ
         y1H9X1uC9z2QknKQ2cqTPw33VnODvFJ52Sewy5vaGvu6eAo/OmxhXXPi8EmLLdgAQHnW
         UI1Jr7V3ovvJhwce8H9Q+reHVBWaH5rpibSPrkqbA0nqd/gSYcxEbq9MtaKEExRO+Z7c
         0yQLM+UqLoaeVnQpUfL1OeF0L+zNkjgamlS9vA14Pfafcm+LBks+AAN4j/35c//hUS3x
         1ZG/NXPmD8Z1v0vS0hB07PBO8HOrr9/fRta50XZMetAi8IwY4OoJ8N3RL6W8N4/+xD4d
         Tcxg==
X-Gm-Message-State: AOAM531b71bjkeqIVRcay/kPBHq8pAlBN6rULdws+AAtu58KXtIElYQ1
        Wc4agXsDUs7DCBEKVPt8In+GVLLP1o8=
X-Google-Smtp-Source: ABdhPJxPCfQzNB7uL35pranMsLg8l/ks+Av7BNiZplWrhc2OJNhD0TsptcYXGc8J9BCBd9kyXVhtpA==
X-Received: by 2002:ae9:de86:: with SMTP id s128mr16015657qkf.379.1605552551883;
        Mon, 16 Nov 2020 10:49:11 -0800 (PST)
Received: from [172.17.0.2] ([104.208.240.54])
        by smtp.gmail.com with ESMTPSA id a85sm12870197qkg.3.2020.11.16.10.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 10:49:11 -0800 (PST)
Message-ID: <5fb2c9a7.1c69fb81.699ff.b768@mx.google.com>
Date:   Mon, 16 Nov 2020 10:49:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3804551007590150347=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [bluez,v1] adv_monitor: Update log messages
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201116102547.bluez.v1.1.I4dd1c737d5f8806fe2aa99b8c2d8154fe58871ed@changeid>
References: <20201116102547.bluez.v1.1.I4dd1c737d5f8806fe2aa99b8c2d8154fe58871ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3804551007590150347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=385371

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


--===============3804551007590150347==--
