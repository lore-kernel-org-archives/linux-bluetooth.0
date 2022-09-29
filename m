Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9479BC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 18:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiI2SGl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Sep 2022 14:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiI2SGk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Sep 2022 14:06:40 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EDA1B95D9
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:06:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d17so1345329qko.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=B6B+ep1rUx1/19PSihykY9+IEAjgXaX7tMJjlUefAS8=;
        b=MXQwO78akTNmDeRrnnVjeY3/W3a+u+hIcnzuVaTCeJskuoCD0ybEU5v4dE/8up7Oxh
         xHJU+RFieesZ74+4xl+CXws1M7YnXo2XpD7Yu1EE40XoyDbXJJBaV5jcrBASnbU93KCh
         xuKBnJg0THr3fV6SRsW1aIX+MHjQvJww1lbRO1SNOfxCpGdopMYndC4sb4GEOwI2AWYm
         Vke6ka411WEnt2OPRHmUeeC9hOQU3nAcO/GDPvbwsBJkPTArzZ/nGdAe7z0L5KlZ3RuH
         iQ+BgCxfx8KpiLdG8DCTl5P6vwdX6NqqrnfMjKo2O5OXPgAkVJ5M6+eIu3RCO9zMkEgL
         Mbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=B6B+ep1rUx1/19PSihykY9+IEAjgXaX7tMJjlUefAS8=;
        b=uIQhs+hA+POJDeFS4kNUNIMUtDrOd4+KtzkslNhZyt4njhpkcqYWceGtW7yJRpriXR
         lgc1N0Z9Etcp1sPJ9hs76x43q42mTxr/It9V8yFF7Ip+dcx9EiAOg5kO/Zh/QhjT3VRk
         3a7Yp/aCtcY7pXkdjUHjhaxkdq5SWDatiOKN1ENwOhprwY6cUcx3Wipmi+q1uOW5sReI
         +8UClQgsX2qXOB6KUWuYgCxbsZakkF+2PAPCRnq1uTvGuuPZSA04N4hu62zN2MBznU4a
         e+57Ufnz99/BDhg0IDc7Lz878+sPQBa/wS+G4cAAhWnkB8yo891kz2Cb1OOOzU1fk8vn
         YW4A==
X-Gm-Message-State: ACrzQf1ioaV4D26gwbqEWDKSa+pG7ZkW25HpaS55OIrQWCgVj5F3pcVc
        W1yj+SOJIXI1C+A4tdoOsYZ9O82cqWOzSw==
X-Google-Smtp-Source: AMsMyM5lZDt7OVgrDOz10v+g6vDA1TtcK7P4ZWIzuNwUlZ0NCVpJ7ERgInqmeqziR7B891OaLUTGcg==
X-Received: by 2002:a05:620a:2785:b0:6ce:7dc2:2b2 with SMTP id g5-20020a05620a278500b006ce7dc202b2mr3219807qkp.395.1664474798181;
        Thu, 29 Sep 2022 11:06:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.199.222])
        by smtp.gmail.com with ESMTPSA id bn39-20020a05620a2ae700b006b942f4ffe3sm81344qkb.18.2022.09.29.11.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 11:06:37 -0700 (PDT)
Message-ID: <6335dead.050a0220.45121.0575@mx.google.com>
Date:   Thu, 29 Sep 2022 11:06:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7617732091958788897=="
MIME-Version: 1.0
Subject: RE: KASAN: use-after-free in __mutex_lock
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
In-Reply-To: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
References: <CAJNyHpLhfhfGUDvrFaFQ4pMPYYfsnSrfp=1mDCp8c8Kf91OP2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7617732091958788897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 6
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7617732091958788897==--
