Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A5FC56201
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 20:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F132206F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Nov 2020 20:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyCUrUpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgKYU2y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Nov 2020 15:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgKYU2y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Nov 2020 15:28:54 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB12C0613D4
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 12:28:36 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l2so6036289qkf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2020 12:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xf3FwUKB81FuLQacOP5r3aL4P1+ms2Zg+mQte1vMprs=;
        b=eyCUrUpSZM48hkEogJmR0oMh6gC/Tp+Qqu7pqichGmiJ6bphSuNutCov4L393ncVq/
         9kcw9nrZ+x691J56LSdUjxOWd6DTHtsvA1f3Srr7dvpW9ExRaNLxN6RmCZyWnJ8XC6QT
         ZfGzkaE8R2Ut/PMciwc+FrzHZJPIFvc6VWLNNkZ5AMuCNwlJSfnyyKxH6HsOMo3MkoL2
         rhwIYwYr7UkRzBcdD4otAlbCZBcZQFr0mA15MtrrmJKEargaRgtuosRueeG1c/WO8aj1
         FURGOZvehsBI0+ZJxQrSASKiUozOPNAXKBXoP7jyfiSk2euw48FHeJ7BPMKyw7AjBWnQ
         VJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xf3FwUKB81FuLQacOP5r3aL4P1+ms2Zg+mQte1vMprs=;
        b=MQGTRdRaazJ6VDd+zO/FNaeL0aIAyPxVFf3F1iTDDKqY/vsCCLgYz3rDlBQGIqVXtu
         WqqdE4FGNaFsqbOS8B2K1GSYLph63cZ6RaEvrUOiv2imc+/gL2Gayb10KRI8IMEELI/O
         KJRxvFUUt3FmWmGg0QEmB//4Zzhu+l1F+b128jfIkCQUkDGnYJui4pr/CUq5zhIH9HjW
         uF5y+vjubgFLNC1WidIkRI/VMIpYuaZJEc7z77C9ZpZ6pbG0ncTmp6qPW9PvKeg9kBi0
         N5ooR0U0rLdB18vJ764M4ExmDitUZ/g8tifnkSUZnpQCeTcZ0rWxGfa2P41e4zu60X+l
         SAGQ==
X-Gm-Message-State: AOAM530bqJdLxsiB9836EQ9I9wGH9wyo9grHE3IqF9y2M67xXBgRwJaX
        GtUTOhGRLf4UNOxAM8T8O/b9TIGeC5QaLg==
X-Google-Smtp-Source: ABdhPJwM/RaGEA+Oka72c9QxRgg4bK6NmDfAeWHVXQCfFD2knIUWA+UF7+Xh2hCVVGWI3QzTACpVPw==
X-Received: by 2002:a05:620a:2018:: with SMTP id c24mr699171qka.143.1606336115244;
        Wed, 25 Nov 2020 12:28:35 -0800 (PST)
Received: from [172.17.0.2] ([40.79.64.240])
        by smtp.gmail.com with ESMTPSA id t188sm424812qkd.45.2020.11.25.12.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:28:34 -0800 (PST)
Message-ID: <5fbebe72.1c69fb81.894a5.2681@mx.google.com>
Date:   Wed, 25 Nov 2020 12:28:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1864285427119947108=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [bluez,v2] adv_monitor: Update log messages
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201125121844.bluez.v2.1.I4dd1c737d5f8806fe2aa99b8c2d8154fe58871ed@changeid>
References: <20201125121844.bluez.v2.1.I4dd1c737d5f8806fe2aa99b8c2d8154fe58871ed@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1864285427119947108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=391111

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


--===============1864285427119947108==--
