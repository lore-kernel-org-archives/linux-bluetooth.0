Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B6EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 08:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE6C206B5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8Ooe40a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHSIuw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbgHSIuv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Aug 2020 04:50:51 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C30C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 01:50:51 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 77so20901235qkm.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2020 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JWWNGW4uLcUJgLR3Lzv+8SY+g1N/Ade7CE0qw+59PWI=;
        b=T8Ooe40aksqBVpv24YXu4h91x1Cn8XV6jg2YkPBlsIx2syIEfMsqEBXlY0rHw7qTpQ
         gyr1n8y5vKcu8f3irFx2mXhLXIjDhVekPDBlzpfnzd/lfKwGVnKjRi0KumAoUxTmJBjM
         ADFEo3PF2ab9aLhcb2eiU9I+zq6fTAE2mvkGnwODrQee6nvwnZ9pSCjUHxcxf0QwlTZl
         SBc2hoejoKlbvrMtMgR9gNkWHhfjtcY43sdW1T0imm0ZotaMLryBCwBbaa3UrW/3LfFS
         kXzfnGudM5qYrkJt2VrUDsXRRuA7hbjng0B1B5klAcJnq2J0Dh7vKROd6lIL7t9h29jq
         uSlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JWWNGW4uLcUJgLR3Lzv+8SY+g1N/Ade7CE0qw+59PWI=;
        b=oVeZQtcFBpivVpFRYhNKzVlWqEEWXQVvQ/YiAwANsWwh0D6KZ3Z7ofLkko7WDKvoZy
         6Ht/r6Y8lmirD3veOaGcxgruW0xRsohsguHgK57qyfEQo8U5l9yvdeQQHyW6pzWyFTd2
         2rECTFu+n2M5HxS9y9ZNEX51Pllfure+e/YWz+j+2T95YylSKVDW5Pyr5kXlhxpE+WKE
         t9Cl4c2NuGTfnwOwMik0j61ItlqOsOPTEKZhgGd+7D3CrLTQEz3tcc6rCVwGvVQIyscB
         gh6JePaNh2dD0y/RceMl9LkfON8oe7ApnEHIYqRMn7bDN7UbNKAn2zQpielDXNYpuIP/
         AoLA==
X-Gm-Message-State: AOAM5326IwHW8y5xh+sbMFrruxKvHNiv8ltCNxMS5zItu8OKBHJxRc2t
        XQZ8r4dtYzzyqPALZYBZt4pwYzAkMql/+g==
X-Google-Smtp-Source: ABdhPJyPMM5M0W0c1bJUO3dlpUrmWjopO6V32pzm4c0DKN8EevMbE3oV8ueb/SCwMgIOFK5tITU/lA==
X-Received: by 2002:a37:bdc4:: with SMTP id n187mr21291218qkf.192.1597827049761;
        Wed, 19 Aug 2020 01:50:49 -0700 (PDT)
Received: from [172.17.0.2] ([52.251.90.7])
        by smtp.gmail.com with ESMTPSA id g136sm23635668qke.82.2020.08.19.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 01:50:49 -0700 (PDT)
Message-ID: <5f3ce7e9.1c69fb81.7987f.0d7e@mx.google.com>
Date:   Wed, 19 Aug 2020 01:50:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4289954485751905989=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, daan@dptechnics.com
Subject: RE: [BlueZ,1/1] Added random address in mesh HCI initialization to prevent error 0x12 when enabling/disabling LE scans
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200819082822.64903-2-daan@dptechnics.com>
References: <20200819082822.64903-2-daan@dptechnics.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4289954485751905989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
1: T1 Title exceeds max length (102>72): "Added random address in mesh HCI initialization to prevent error 0x12 when enabling/disabling LE scans"
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============4289954485751905989==--
