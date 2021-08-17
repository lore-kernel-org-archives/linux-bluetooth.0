Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2315C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C660FD7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhHQR5x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhHQR5w (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 13:57:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BE9C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 10:57:19 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d5so8473521qtd.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G2YMHCSlC7/IjmFDYjTnQusxJX5sAXR5d6TK0tiaklQ=;
        b=qcA9iLaAQkjBHxPEiDn0STNlHzJhaz4bQMNXXxBGcoF1gPO0wx68NNlTbQ3EOog1Gk
         HgfsWxRbqMsFDJB/xTXGPqGj1fiAh06rsizrFUF3O5M3/BWcR3ISnbN8/o933xQXV66V
         qSiORCO8EW/k2X3Qe7h4ZXUmiCNf0mRbX7EFDU+5hfTXOpXV/AsLXaPCYjYO/jCSAeMj
         wo21DVq3jiVpXy78Xgyfy1hnaMakCc2PJQFcgelGn8EBKCnYsrbRF8scf+CGtBLYaMkp
         SLNTKxbAmmwlGGRNxwCKtiFVzwp3JBU30rfG5k2k7Jynd1ORgbbUZ46g3SNJMt4JXwE5
         LzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G2YMHCSlC7/IjmFDYjTnQusxJX5sAXR5d6TK0tiaklQ=;
        b=KdqgZGvFq8iCXnmxpKVAWpCDzQYQn3LRng+IRqXsyuKn5auGGX55E9LVjSYH7GZUdN
         gomJE+s4Aw9grBY+KhvafhC8PpjYwOtUCH07xMFNFOxaDVVJfm3qIdhFlCrtFRIWOIhw
         GNUODjHnQtkzE1ISVMGR3hxInh0Us1YRe9kUdpD1iY1MfLWt+zbCTxO3zUYlLPluBmVw
         GLDWUePnVrmiJ41iN9v4UEyGufNv0Ij4+oSs+orqnxFrxtNg0V5o1/Eu1l7zQsT3FYAB
         7Od1kxz8EIzw1w7Bqqd8ohM2mQFYzNi6gHE+61/8d9mSVSTBYbKVokB5M180QdtzTK0K
         9eog==
X-Gm-Message-State: AOAM532PnquNyrhK0WhouhSxtfcBKSoKpSJaSqyeciL+xIIAITlsdWvX
        zn10d5/NpYDgxbFhbNRhE4juq82bYn8=
X-Google-Smtp-Source: ABdhPJybhfz3Y3PgO+ezu8fvmKNprrBGoNb589HvaCNGSaJZhrB9AaPk9k/T6ON5+G/semXNGIC9Lg==
X-Received: by 2002:a05:622a:14e:: with SMTP id v14mr4230764qtw.307.1629223037978;
        Tue, 17 Aug 2021 10:57:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.49.85])
        by smtp.gmail.com with ESMTPSA id i123sm1911493qkf.60.2021.08.17.10.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:57:17 -0700 (PDT)
Message-ID: <611bf87d.1c69fb81.78d98.d4f1@mx.google.com>
Date:   Tue, 17 Aug 2021 10:57:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7330858196573526148=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bernie@allthenticate.net
Subject: RE: method to notify/indicate to one device
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210817172909.18630-2-bernie@allthenticate.net>
References: <20210817172909.18630-2-bernie@allthenticate.net>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7330858196573526148==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=532875

---Test result---

Test Summary:
CheckPatch                    FAIL      0.44 seconds
GitLint                       PASS      0.10 seconds
Prep - Setup ELL              PASS      40.37 seconds
Build - Prep                  PASS      0.10 seconds
Build - Configure             PASS      7.10 seconds
Build - Make                  PASS      176.64 seconds
Make Check                    PASS      8.44 seconds
Make Distcheck                PASS      208.03 seconds
Build w/ext ELL - Configure   PASS      7.17 seconds
Build w/ext ELL - Make        PASS      166.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
Added GDBusMethod to notify one device of characteristic change
WARNING:LONG_LINE: line length of 122 exceeds 80 columns
#18: FILE: src/gatt-database.c:3619:
+											DBusMessage *msg, void *user_data)

WARNING:LONG_LINE: line length of 110 exceeds 80 columns
#81: FILE: src/gatt-database.c:3682:
+												 client_path);

WARNING:LONG_LINE: line length of 98 exceeds 80 columns
#86: FILE: src/gatt-database.c:3687:
+								device_get_address(client_device),

WARNING:LONG_LINE: line length of 107 exceeds 80 columns
#87: FILE: src/gatt-database.c:3688:
+								btd_device_get_bdaddr_type(client_device));

- total: 0 errors, 4 warnings, 105 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] Added GDBusMethod to notify one device of characteristic" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - PASS
Desc: Run gitlint with rule in .gitlint

##############################
Test: Prep - Setup ELL - PASS
Desc: Clone, build, and install ELL

##############################
Test: Build - Prep - PASS
Desc: Prepare environment for build

##############################
Test: Build - Configure - PASS
Desc: Configure the BlueZ source tree

##############################
Test: Build - Make - PASS
Desc: Build the BlueZ source tree

##############################
Test: Make Check - PASS
Desc: Run 'make check'

##############################
Test: Make Distcheck - PASS
Desc: Run distcheck to check the distribution

##############################
Test: Build w/ext ELL - Configure - PASS
Desc: Configure BlueZ source with '--enable-external-ell' configuration

##############################
Test: Build w/ext ELL - Make - PASS
Desc: Build BlueZ source with '--enable-external-ell' configuration



---
Regards,
Linux Bluetooth


--===============7330858196573526148==--
