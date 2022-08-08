Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55AFC00140
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Aug 2022 19:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244405AbiHHTQT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Aug 2022 15:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbiHHTPu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Aug 2022 15:15:50 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336819C35
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Aug 2022 12:14:45 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-10dc1b16c12so11598390fac.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Aug 2022 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=hyeint5iT/1HFdtleCaot74rOklA+dC1RIiLMwWkCXE=;
        b=EVshH2Wgn/HBRXmZu0pRLpwE4oA797wzLoUFAXHDh03wUDTJq2k7OHsa2PXFMpsuwG
         rCZwrWkYuzJ2nZgJFAELwfumAQFxkWYP6NMGTbaOgbD7kW436x2LYgOyKpY4i4eK86wW
         zwvhrV7U534CfP2oHc8UGYC9wN3YMYe4JwfEK2/X/pEdxVZUnh6EatX2NUXdbBdy2wYr
         vNCkuiwwXHyJbi0XMiNOXCdZL4w6oVCauq0QBE9RkJWIbrPQoigOTnw1aWBS+wgWS62q
         ohk+Ogqwg5OkGnFEIfcNU7mLPjejI2uab1KMP1+OR/0JdCqxNeZ4P0k8qUoS0AI3INaj
         pJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=hyeint5iT/1HFdtleCaot74rOklA+dC1RIiLMwWkCXE=;
        b=ugryjs5mEtBYGZLkpL4gW7Qv7mFKE41Wp1k6AVVHrWD1NEyYff+ryKkrwoiBmIXo7R
         3XHWjFcZPHMXOYiGaA8SGH/GA+fio2qrAOjeTQhndvYMLhlxnsblOzynv+ok5RunjAWD
         QEU47lzLtRXa2IvgySgJmj2kxagt6x1hgHqrMiy4PwZs62bmpLonmxeIeFsM0F9NWGLn
         MGwBMfXUZFM7fl8PYLCO8txi8zgHHlQmO54w+orKLr+VENmL60SwFP2cFC/7HWpXiv3Q
         Ja5rqqA31mhq0YE5oyFK7CJqVPZtuivWDaIAMTVsBFgbPOCOIlJo0vSL8tKJsu8sO4u6
         wBag==
X-Gm-Message-State: ACgBeo1nwpD7LN879Wvv1Fj2F6YZGcwaDNdBbfNkGxaU4dxXI2tZouEJ
        mTcdxJ9n8AeOGP2Twx7Y5yioiDLjP1+iXw==
X-Google-Smtp-Source: AA6agR4v5RRmfEIbn+NOfIXZWdx7xN40B6Wkbv1cHzip4YSUGTE4RD7EZAi5EPyL93Ga8BoFQE/y0A==
X-Received: by 2002:a05:6870:339a:b0:f2:d065:be1f with SMTP id w26-20020a056870339a00b000f2d065be1fmr9571998oae.69.1659986084785;
        Mon, 08 Aug 2022 12:14:44 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.217.202])
        by smtp.gmail.com with ESMTPSA id c9-20020aca3509000000b00342ded07a75sm1142587oia.18.2022.08.08.12.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 12:14:44 -0700 (PDT)
Message-ID: <62f160a4.ca0a0220.ec13c.3413@mx.google.com>
Date:   Mon, 08 Aug 2022 12:14:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3467930734014325171=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: Bluetooth: Ignore cmd_timeout with HCI_USER_CHANNEL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220808110315.1.I5a39052e33f6f3c7406f53b0304a32ccf9f340fa@changeid>
References: <20220808110315.1.I5a39052e33f6f3c7406f53b0304a32ccf9f340fa@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3467930734014325171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666118

---Test result---

Test Summary:
CheckPatch                    PASS      1.29 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      43.76 seconds
BuildKernel32                 PASS      37.79 seconds
Incremental Build with patchesPASS      52.27 seconds
TestRunner: Setup             PASS      630.09 seconds
TestRunner: l2cap-tester      PASS      21.10 seconds
TestRunner: bnep-tester       PASS      8.49 seconds
TestRunner: mgmt-tester       PASS      133.23 seconds
TestRunner: rfcomm-tester     PASS      12.93 seconds
TestRunner: sco-tester        PASS      12.33 seconds
TestRunner: smp-tester        PASS      11.77 seconds
TestRunner: userchan-tester   PASS      8.42 seconds



---
Regards,
Linux Bluetooth


--===============3467930734014325171==--
