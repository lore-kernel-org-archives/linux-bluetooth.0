Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7ADC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Dec 2022 03:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLQDTj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 22:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQDTi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 22:19:38 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13FB21836
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 19:19:37 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id g20so2202408iob.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 19:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=znZe4iz81PPcAKrxN2SU6VuOeRq2wGY6TLlm90+vZ7Q=;
        b=lsHUEYjJLmjJ0RZ1U5FT4oswqs4UFpc0D0cWxV2TIU4DQxgM0shFCnrYG0IH33J20E
         pBN+VzA7vuMRTOtkfPKGsMgX7TqCmMb9ixDrxkv7QL55ucvzEvO0DPstcca2EfZ/ic8H
         FkjQgHr3/+gdBl3bGNGQntpw0uH8czpit/W7wuGaqSJ+/KKiwHsbfw5pmEMPgVK+oHR+
         c9b2iK+06sUEtJtgQ4su1Brt2lrkgzm49Kzc4GuIxk+NVP5EB9fPklJ1QLQWdBqvvVTd
         YkmjoNBy//p9H3EEVyc9+B2lXQm1yFS1kp1pDHcyXBqgNrvLERp4PbWmwueKLFICtO1U
         ANeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znZe4iz81PPcAKrxN2SU6VuOeRq2wGY6TLlm90+vZ7Q=;
        b=0tW3W0bYY+h1u/9TwaJJeAeBFgU0rDyCZAiRRVtuo1f06pnBk8TaeWJd3AOqtiPpTk
         dfOFHOve6A3m9xTcglIqZuo0qqNEi3PHoAyfWrIH7Clqh4sKE91xB3eXCt80Fqz+2JVN
         nlAvQRJU5IPqpjgllMzi7h4dGgHixIfEnXyGmf5ExQVPPDodLnxDnW8z9I4uFoX9G6ig
         CCHkoy56YL80p99LDwk97ZeQBBHYKK7cKVmDltnzIrf/QObWXg962XXptTuoGxHQJOfL
         Zm2O0XfzKazxXQ+yfgKVuJsESFEplH9PBzhV0qv5nBHrUdFFpF79IuruZB6JDmatBVO5
         UGMQ==
X-Gm-Message-State: ANoB5pmDGFxb2pqGWd3tz7YbrOuOWQvAYUmat3F4J63v5upkWpMErgzr
        PBqT3C+SaAVkjm8BLHdHa/oN6O0YpWw=
X-Google-Smtp-Source: AA0mqf6TO+0fkGlDHE2O3CPUsTMEHcXm/fNkn1+rUCHvhURxnsJYCcoCuvv0bUyY59xn5n6Mo4Fhtg==
X-Received: by 2002:a5d:9517:0:b0:6c3:68f6:be14 with SMTP id d23-20020a5d9517000000b006c368f6be14mr18882648iom.10.1671247176993;
        Fri, 16 Dec 2022 19:19:36 -0800 (PST)
Received: from [172.17.0.2] ([40.86.28.128])
        by smtp.gmail.com with ESMTPSA id l15-20020a05660227cf00b006e580444f02sm1309439ios.39.2022.12.16.19.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 19:19:36 -0800 (PST)
Message-ID: <639d3548.050a0220.9ee4e.20ef@mx.google.com>
Date:   Fri, 16 Dec 2022 19:19:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2937349325402891532=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/2] shared/gatt-db: Add gatt_db_attribute_get_service
In-Reply-To: <20221217011059.3087848-1-luiz.dentz@gmail.com>
References: <20221217011059.3087848-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2937349325402891532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705299

---Test result---

Test Summary:
CheckPatch                    PASS      1.17 seconds
GitLint                       PASS      0.52 seconds
BuildEll                      PASS      26.63 seconds
BluezMake                     PASS      740.12 seconds
MakeCheck                     PASS      10.93 seconds
MakeDistcheck                 PASS      145.54 seconds
CheckValgrind                 PASS      237.68 seconds
bluezmakeextell               PASS      93.02 seconds
IncrementalBuild              PASS      1204.05 seconds
ScanBuild                     WARNING   930.96 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/gatt-client.c:387:21: warning: Use of memory after it is freed
        gatt_db_unregister(op->client->db, op->db_id);
                           ^~~~~~~~~~
src/shared/gatt-client.c:632:2: warning: Use of memory after it is freed
        discovery_op_complete(op, false, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:929:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1035:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1227:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1292:2: warning: Use of memory after it is freed
        discovery_op_complete(op, success, att_ecode);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1563:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:1568:2: warning: Use of memory after it is freed
        discover_all(op);
        ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2070:6: warning: Use of memory after it is freed
        if (read_db_hash(op)) {
            ^~~~~~~~~~~~~~~~
src/shared/gatt-client.c:2078:8: warning: Use of memory after it is freed
                                                        discovery_op_ref(op),
                                                        ^~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3161:2: warning: Use of memory after it is freed
        complete_write_long_op(req, success, 0, false);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/gatt-client.c:3183:2: warning: Use of memory after it is freed
        request_unref(req);
        ^~~~~~~~~~~~~~~~~~
12 warnings generated.



---
Regards,
Linux Bluetooth


--===============2937349325402891532==--
