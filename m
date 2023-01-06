Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BB4C3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 00:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjAFAD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 19:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbjAFADn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 19:03:43 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB543C0FC
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 16:03:38 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id j16so862459qtv.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+2vU1q1MefdJi0qSVNmHAQMVieijiAzE20qDyBYADGs=;
        b=EgAsRG7kcdC5TCttvhtPT1YMdGolL7I25bQCrtSs8gTBZQ13aGQnyTN+riGB3rqXxq
         fXBmFJqw1K2EfCWqh4zsYTjedtNNFW/Y9T29Ox5sX5EcBwk0aQaAhOccJZbx/KS4bO79
         IioaQcP5JLsYii60habf2USM5xHaPaX9MUm9AdmjjhoB8HmsrqPje/Z9EvHv75x1um0H
         t47HwqGFTVuWh9wgwrGIDExA20dCoz0YDbjOMt3pkdqy2Zt/aOniBcsHrGyeBCgedAAk
         0GGHfNzKkphMnT5E9fE7ytdQZk25HKvWR5LKRTuTGMMBMrxpKQ2rLF08RmVFFse1ZOxx
         fpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2vU1q1MefdJi0qSVNmHAQMVieijiAzE20qDyBYADGs=;
        b=Bi6eE2rJ2KCc9MUgpK2ea8f/mQ06P0OTt/RojhN45+bwYe3tQDX8LIootZl4o/8cn4
         BGJ3KRb7Lsm/Qe4/8XNQ7/WLOGC2YwCFcTDHE3tAGOggpPOsqxu5rzZRRYpqereQS7e6
         uOBnfM/Ek5Dxxn7W118naveWEFki/Qju8SOYGKdUQsN9lplqbB2OG3etEY6agHC4hMUp
         PmB5FtBH9oOcP2/MT2viGpiXOcmNmrnCQMbjwuxolOFh5wccTgxwK2pKtjN3TTEDxwY6
         KZW2i+vYVvXihvNRd5TeKIYXbgg8m422i7dXS01RYPByf4dko2c9GCdzK8lpVQgarCjB
         zJlg==
X-Gm-Message-State: AFqh2krnsPocerL0rWPmHNb6f50nAQsWgi/DJSVTsD41P7xC5fs80dOc
        97Lxg2WyWx1V1xhAdDrZazRX7+CQAK8=
X-Google-Smtp-Source: AMrXdXtFe6erPFKSNyMDchoIbaXclGl1aHkWTrHddd5/aSXTZ1WdRBFqwvUpk2NTsxGHSW2Ae16pPQ==
X-Received: by 2002:ac8:1249:0:b0:3a6:7558:e0af with SMTP id g9-20020ac81249000000b003a67558e0afmr76706344qtj.28.1672963417750;
        Thu, 05 Jan 2023 16:03:37 -0800 (PST)
Received: from [172.17.0.2] ([52.190.17.163])
        by smtp.gmail.com with ESMTPSA id fu22-20020a05622a5d9600b003a611cb2a95sm22451867qtb.9.2023.01.05.16.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 16:03:37 -0800 (PST)
Message-ID: <63b76559.050a0220.cbe75.dd46@mx.google.com>
Date:   Thu, 05 Jan 2023 16:03:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2757779767305985257=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/4] shared/gatt-client: Use parent debug_callback if not set on clone
In-Reply-To: <20230105220944.2373424-1-luiz.dentz@gmail.com>
References: <20230105220944.2373424-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2757779767305985257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=709312

---Test result---

Test Summary:
CheckPatch                    PASS      2.39 seconds
GitLint                       PASS      1.39 seconds
BuildEll                      PASS      33.02 seconds
BluezMake                     PASS      998.52 seconds
MakeCheck                     PASS      12.62 seconds
MakeDistcheck                 PASS      178.17 seconds
CheckValgrind                 PASS      289.84 seconds
CheckSmatch                   WARNING   383.95 seconds
bluezmakeextell               PASS      116.46 seconds
IncrementalBuild              PASS      3284.64 seconds
ScanBuild                     WARNING   1193.87 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-client.c:2764:33: warning: Variable length array is used.src/shared/gatt-client.c:2994:23: warning: Variable length array is used.src/shared/gatt-client.c:3075:23: warning: Variable length array is used.src/shared/gatt-client.c:3514:23: warning: Variable length array is used.src/shared/gatt-client.c:2764:33: warning: Variable length array is used.src/shared/gatt-client.c:2994:23: warning: Variable length array is used.src/shared/gatt-client.c:3075:23: warning: Variable length array is used.src/shared/gatt-client.c:3514:23: warning: Variable length array is used.src/shared/gatt-client.c:2764:33: warning: Variable length array is used.src/shared/gatt-client.c:2994:23: warning: Variable length array is used.src/shared/gatt-client.c:3075:23: warning: Variable length array is used.src/shared/gatt-client.c:3514:23: warning: Variable length array is used.src/shared/gatt-client.c:2764:33: warning: Variable length array is used.src/shared/gatt-client.c:2994:23: warning: Variab
 le length array is used.src/shared/gatt-client.c:3075:23: warning: Variable length array is used.src/shared/gatt-client.c:3514:23: warning: Variable length array is used.src/shared/gatt-client.c:2764:33: warning: Variable length array is used.src/shared/gatt-client.c:2994:23: warning: Variable length array is used.src/shared/gatt-client.c:3075:23: warning: Variable length array is used.src/shared/gatt-client.c:3514:23: warning: Variable length array is used.src/shared/gatt-client.c:2764:33: warning: Variable length array is used.src/shared/gatt-client.c:2994:23: warning: Variable length array is used.src/shared/gatt-client.c:3075:23: warning: Variable length array is used.src/shared/gatt-client.c:3514:23: warning: Variable length array is used.
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:401:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:646:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:943:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1049:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1241:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1306:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1577:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1582:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2088:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2096:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3182:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3204:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============2757779767305985257==--
