Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2194C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 23:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A2E64E7C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Feb 2021 23:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbhBWXJE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhBWXAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Feb 2021 18:00:24 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A67C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 14:59:10 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z190so427281qka.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Feb 2021 14:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=XVc0KZqivgp3evBKHc2/KmHiASbYmXyOqxw9IoZ5Vj8=;
        b=ijgzcw97x5IT878t+s7zYKGMJVvYdUc6uleylFA16E2huBqy5onX8p8jXU40vh+sWk
         CIIsNtTQOwq1NdjI+DNC8EJHj1yi8S7CqA2iEYMdHD3B6MJL29LhpGQMGA0VGoyH9X+0
         MHF50zhixedk/xnr4SymEF+C04ZFnQRc9pkwLAlUrC5pvrMOdhyTG/C3BfknSnVhHnZB
         wiczupt4FLnBWs2DgGtkPGTJt4GH9IZgVXQBP4hcIveQHcK8acZ5DAdcNWeX+LtRymUt
         aCermiYm3o3WktukprIXnHG2sBa7zGiPaOTwNs9eCoHEGmmOGEtbSRyCoGLSxOB2r/Ld
         07Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=XVc0KZqivgp3evBKHc2/KmHiASbYmXyOqxw9IoZ5Vj8=;
        b=QcU7J0ekv6+H1UKCD0egvbij5Cll7ljdnrExuxFFBjExAtIQ9sgxHrhGrF2fi9sr6I
         fUH+POCdn5V/53Yw3LzLBz9FkWIw8JylmzruInEgfCQrjaS6SDQ27cKQ5DUdu6/fTqEB
         ktJjlzh4kLKYBR97YuxCXtWHch1h2aqYfW7VeDvyEzNjWybNAWhLQpZfcBA/woD68brT
         oOB0e0XaQPckyqD3QkQShzjuBwkt9i7DAsYzrASDuhaUKlXieFKER0m+TyLvHpgvyHzH
         FCnGk+k4BDDQ5s4XfW1h4hjk+fnxdDDLF2Z4jrdpHi/kuFTntljjv2iNucPNpw7aneT3
         IC+g==
X-Gm-Message-State: AOAM530oUUZaBsVBx+/jQDR69Y+PrsK7gMT24eJDKpWlBWj1hBWP5p51
        9AktXfW8w6wIE159f7iyBwagiBp+XMGj+w==
X-Google-Smtp-Source: ABdhPJxzYEh7wImL0dYDYluUk10yKWoAKzZ1z1G+jTB0IC3Lc3dV8DAv11A/ypgNrQFYq88sGAWk1g==
X-Received: by 2002:a05:620a:1ef:: with SMTP id x15mr27404752qkn.209.1614121149969;
        Tue, 23 Feb 2021 14:59:09 -0800 (PST)
Received: from [172.17.0.2] ([23.96.41.98])
        by smtp.gmail.com with ESMTPSA id q23sm106664qtp.24.2021.02.23.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 14:59:09 -0800 (PST)
Message-ID: <603588bd.1c69fb81.ff32b.0af0@mx.google.com>
Date:   Tue, 23 Feb 2021 14:59:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6193464766569078226=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] monitor: Fix handling of BT_HCI_EVT_LE_BIG_COMPLETE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210223190904.1718994-1-luiz.dentz@gmail.com>
References: <20210223190904.1718994-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6193464766569078226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=437331

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


--===============6193464766569078226==--
