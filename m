Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B0C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 02:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D30261554
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 02:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhEKCGT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 May 2021 22:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhEKCGS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 May 2021 22:06:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBE8C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 19:05:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g24so10819364pji.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 May 2021 19:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=7d6ezJKgDg8RtMrqztKD5C0xj31m5s787NqTz/XHZEw=;
        b=L3RV+gjJZ/sLY9yDuc1g2oTtgOtQzWbzXMZ5eYr7HVktvK2NViwzBsBeMXejf9eBdk
         x8Fgf66QlrorG/NchMQLTH05SLrx8CosSX62YgB1AzDNGjlsStXK/VTCoCaFIJzu4eT5
         bizSXafh4stVnjqLqyKMmGH06kROmPAJDHg1xseh6NFQb8vyLrLQbv8YJGqxmamxTboM
         eJ9CtdT8OXhoOAYa48Oxu0sSuoaioNfe/XCXwnNPMosYeZHsvZ4ffLWzfoUAmaUuibg0
         XSPPtCqSxUYMPAScPWXUNtrBrJhUHqT2NZSSFfthJHtkzcg5fYvi/T4WUu9VV+0A2UaK
         BkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=7d6ezJKgDg8RtMrqztKD5C0xj31m5s787NqTz/XHZEw=;
        b=Jl60P4Qv8EPE8DKD3wIzu2xMmKMiiGB2uo5POksnUDXNbCyojsiaHNk6hIWfR1b1fR
         TiAdRrF+dekPy2mtmCsn6YK30MZpsliB5chArwFfliJcfNN5IsVNaUmvbNgnSTWEqk2V
         t81Vpe7HotgFfSjzaGvkpdzOaAc97FR5UB1s/MakAtHWxdRQ8w+Q6oGxXArI4bS8L7NZ
         3tJ4Pw/tWrmap8zeGVeQlr0jijBK4Ft3qo36TqlkJBKKcOkfUtVhJTtkwam5zP9u06E5
         y4r/Yx8h9pDpH6VaFul/kYB+hjEtMQq60VUowKeEzE2X+7na+650xdQ+2UYnxj5R3HDu
         P8wQ==
X-Gm-Message-State: AOAM533OzGzroKHDiW7eZd8voQKm8motyIOxRkb5Cxk3lgL2fU+4NHgE
        tDZiOa9SLk/viEudRE02su8MGdlAEJqiog==
X-Google-Smtp-Source: ABdhPJw4bJ0uFWL3vvK1G9oz/4wlYXh1vQW0fvzsDFJ3pJRSX9IB+CoVEW2pqaPh2Fz0NWeY2tGQ7A==
X-Received: by 2002:a17:90b:182:: with SMTP id t2mr30282418pjs.138.1620698711692;
        Mon, 10 May 2021 19:05:11 -0700 (PDT)
Received: from han1-mobl3 ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id z23sm12189395pjh.44.2021.05.10.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:05:11 -0700 (PDT)
Message-ID: <6ad17224e2e81ecb76fee43c116480591739d7e0.camel@gmail.com>
Subject: BlueZ basic/regression test report - 05/10/2021
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Cc:     Tedd An <tedd.an@intel.com>,
        Luiz Von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Brian Gix <brian.gix@intel.com>,
        Inga Stotland <inga.stotland@intel.com>
Date:   Mon, 10 May 2021 19:05:09 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BlueZ Basic Test Report

Test Results:
-------------
1. Builds			PASS
2. Loading Driver		PASS
3. Reboot			PASS
4. Power On/Off			PASS
5. Scan				PASS
6. Discoverable			PASS
7. HID (LE Mouse)		PASS
8. A2DP (Headset)		PASS
9. HFP	(Headset/Mic)		PASS
10. OPP (Send/Recieve)		PASS
11. A2DP + Scan			PASS
12. A2DP + HID			PASS
13. A2DP + HID + OPP		PASS

Test Setup:
-----------
DUT:
	System: NUC8i7BEH
	BT: Intel Bluetooth device 9460 (JfP) [8087:0aaa]

Tester/Peripherals:
	Dell Latitude E5470 w/ Windows10
	Headset: LG HBS-1100
	Mouse: Logitech M720


Sources:
--------
bluetooth-next:HEAD
commit da68ad722e54ce86fa6f87829cf60d12201cdfaa
Author: Connor Abbott <cwabbott0@gmail.com>
Date:   Fri May 7 14:27:33 2021 +0200

    Bluetooth: btqca: Don't modify firmware contents in-place
    

bluez:HEAD
commit fa57cb68e13ea4a6cff5532830008d44254e7e83
Author: Tedd Ho-Jeong An <tedd.an@intel.com>
Date:   Thu May 6 17:56:30 2021 -0700

    monitor: Remove Pygments dependency from manpage
    
    
ell:HEAD
commit 4cb908f7fb7191eb45838dbd95de2460470f75f7
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Sun May 2 12:54:54 2021 +0200

    Release 0.40

Regards,
Tedd An

