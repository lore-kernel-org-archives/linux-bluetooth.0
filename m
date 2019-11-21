Return-Path: <SRS0=kdk/=ZN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30546C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 11:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0248620674
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Nov 2019 11:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2EbBYxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfKULAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:00:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36403 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKULAT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Nov 2019 06:00:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id n188so1237911wme.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2019 03:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:in-reply-to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=A52LAw25PUMf/bK/wd5zkUIDFwEvSjZ84Jb4F37kyw0=;
        b=f2EbBYxfYhe+pDbqJpX+HvUG0aLDRUucMvk3bnpwCr298ZP09T6xdTeFVklS/thYzX
         UyyouxpYq/kaVSnETEyrYaCKHGzeFnta6hmuQdrMOvJ8SNLAL6jkKSyOi5FTkFGhzlmD
         9sz+C/HJ/bzBO0tTQSpEwbSyZNyzlhy5bzl3/HDmKlG+fnUGaQHuFKlLvSrd4ehvbHE9
         rNNdF5ZaltfbxQ4TA6B73sN365cUUTE/IEKjBSD5bb6ONuwlPEQiImm7ng+p3oNKJAFn
         JTWWlcIlIDAVlwAj4P/x8C1Ab536NrdZNPF+oYR1D4vohZ+fAOYCmzJIBOhyhERPL8n7
         NyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:in-reply-to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=A52LAw25PUMf/bK/wd5zkUIDFwEvSjZ84Jb4F37kyw0=;
        b=MpeBzncZXdfSJ4UBCtLU6i8YVY8VrC//RM8WGPGz5HSb0DMcKTft60KYS9i61QvUaq
         PkzCx9ClZrfEH+Fs2zBaumpWb+U61vgv4ZxQW9We/mKp6fN+aOw4vhGLsCCuvMo1+TIj
         XC8+8WgNfL6R/pBe4+TVMqLou4EXHzV/s/AZREB10ALYIqq/y/HGClj6OEFRxQtEvRzf
         lp4DIAttPL4jB1P9LM5w13Iiv+rF/iFzx6j3MjlPc/RVB+eZr3yiELsSAdNq9udkbZGx
         hGm/ZVD2Yktl0QMV1yp4QN/R02OKcA5uijAJ+JMQltbc5whmrocMYIYbFX3itnz7Y05i
         bF9w==
X-Gm-Message-State: APjAAAXRFs6Jb9826nXU4GRORCp3Dcwe9YFchba0+mxvodP0O/r0rKFe
        sE/tyQFj+Iv/xhKwTHeu9zFJyMpB
X-Google-Smtp-Source: APXvYqxnqKdOdYNmqMGA2QkOxgRZuh3JDddEewBKzcenKNXpnH8F9sXfxheq7rbMth4EakArW2e+Xg==
X-Received: by 2002:a1c:4c15:: with SMTP id z21mr8629312wmf.132.1574334016797;
        Thu, 21 Nov 2019 03:00:16 -0800 (PST)
Received: from mamamia.internal (a89-183-4-151.net-htp.de. [89.183.4.151])
        by smtp.gmail.com with ESMTPSA id y8sm2955192wru.59.2019.11.21.03.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 03:00:16 -0800 (PST)
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
From:   Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Allow combination of BDADDR_PROPERTY and
 INVALID_BDADDR quirks
In-Reply-To: <20191121075130.92705-2-marcel@holtmann.org>
Message-ID: <51f721e7-42db-a05d-3a99-4fb1b6f82855@gmail.com>
Date:   Thu, 21 Nov 2019 12:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 > When utilizing BDADDR_PROPERTY and INVALID_BDADDR quirks together it
 > results in an unconfigured controller even if the bootloader provides
 > a valid address. Fix this by allowing a bootloader provided address
 > to mark the controller as configured.
 >
 > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Thanks, confirmed working!

Both patches are:
Tested-by: Andre Heider <a.heider@gmail.com>
