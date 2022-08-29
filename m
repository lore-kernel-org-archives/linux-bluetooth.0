Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10955ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 13:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiH2NcN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH2NcL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 09:32:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4F5A8AE
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 06:32:10 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w18so5980624qki.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=5o7ndiYkStUph5QCK0hAlmN5kRBaciWQKhAVF8swbeY=;
        b=oQghaspNqoaA32g3oVNcWHg+SPRiHzlTCeh0F+nLO9Cn0HGQnlqoubDceq7OVDNdpW
         DOXCHmj4pdT9mQcdhFPhvd2gjFpCDch0AkUc4BEpFI7t+k/eh/pJXocEuTiXe0qHFU8G
         rKCwnWVVwoAJiA4ysElqiG9cPFMNcNgXt7hsSj1aaZXbrl61Opy0JuNb1Zf0Ikhs6l5S
         IfO5fvH1ShGA44dbSiHgsBVBLNa5ix2d3VnITf4pgKq578GGhUfsLUg7eF4aOBCfqWL5
         ulOa1Xw9q53u6nqHvA/55Bdajc2jrqZhIsaLR/lgZk9FbSxgG40y1bjkZzHv06jqAfBz
         eUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=5o7ndiYkStUph5QCK0hAlmN5kRBaciWQKhAVF8swbeY=;
        b=MLel5p/PurgD9FhvjmLeR3ZTl1i0HXsvUH4ND8Rq5RjSDPg6DbmxqWGOWTE5fis/kw
         9nxgcJteWwjMne/J3aaG+JGnZWl5Xwh9cZtoJgEZaWzQhZyuixPb8prfWlMHa2nBtphx
         l4ojN49iBdR+e/ibn7281+lNvSqw/Oa30B6ovg9T/Z3u7j2yGcmjk/H+ny2DuMDB+Q6r
         swTqBZ+x/OevO/Kk7ohRKshbqq7bV3TiaxcClfuW2qNpUQhiYHksiA46w78z1miwzWbz
         0Xu40zJohUtYMZfTCNOb4nEhQIaTeUfpqWwaJVV1T1ILc25qm4vYSM0NPgkLKf0Ocx90
         eNpA==
X-Gm-Message-State: ACgBeo2OMl3q0fxVuiHfT0bfy4wKrG+SvQLQkqf61G+Qa3hclYr+720/
        lBXZvA3PLFhISBX8uR8vFSl5ZKk/O7M=
X-Google-Smtp-Source: AA6agR5wKj6sUHe1bL31IHeeH4e5k3QbRy13AmW8EZf/o5G/NmbOIV68WPJylZlC201vxzuLrrooMw==
X-Received: by 2002:a05:620a:2611:b0:6bb:9ef6:efbe with SMTP id z17-20020a05620a261100b006bb9ef6efbemr8248283qko.550.1661779929379;
        Mon, 29 Aug 2022 06:32:09 -0700 (PDT)
Received: from [172.17.0.2] ([137.117.58.89])
        by smtp.gmail.com with ESMTPSA id dm41-20020a05620a1d6900b006ba9b2167a2sm5849745qkb.16.2022.08.29.06.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 06:32:09 -0700 (PDT)
Message-ID: <630cbfd9.050a0220.b25d.bb6f@mx.google.com>
Date:   Mon, 29 Aug 2022 06:32:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5627672515011680842=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [1/1] Bluetooth: btusb: Add Realtek RTL8852C support ID 0x13D3:0x3592
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220829114507.1024-1-max.chou@realtek.com>
References: <20220829114507.1024-1-max.chou@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5627672515011680842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672002

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.88 seconds
BuildKernel                   PASS      34.04 seconds
BuildKernel32                 PASS      30.25 seconds
Incremental Build with patchesPASS      42.85 seconds
TestRunner: Setup             PASS      498.43 seconds
TestRunner: l2cap-tester      PASS      17.88 seconds
TestRunner: bnep-tester       PASS      6.85 seconds
TestRunner: mgmt-tester       PASS      105.02 seconds
TestRunner: rfcomm-tester     PASS      10.23 seconds
TestRunner: sco-tester        PASS      10.05 seconds
TestRunner: smp-tester        PASS      10.06 seconds
TestRunner: userchan-tester   PASS      7.04 seconds



---
Regards,
Linux Bluetooth


--===============5627672515011680842==--
