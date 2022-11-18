Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D31C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiKRFfE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiKRFfE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:35:04 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4AB7AF52
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:35:03 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z17so2765804qki.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea/yM9UmAh4jA656etZf9PBFx+DV2lsOK7Wt+MY+UHs=;
        b=izmt3zYBbx0lAHhc8lE6xoBC9SNqmpBCKKDSmJuxQOwYdjzkINRE0YlaC/Tpx1w+HF
         nGn08yJbWJdDcpMyf2fHZHwdsIIIDmnvbxSYdomU7svymrbk6/1Fq8H9ZETFvoPXVbmn
         MSReeHCjjIK6SLpIDmLeLslqZTlKsEmGSpF/EE9ETkz5XwtsC592oDucsPtj6GbQoFOZ
         8fnaGwNts/7GWOaT/QwFDwdo3CxoKE/8uLN3K7WHXMkBCMNOf0/1uMthjMtCDDI9HgSW
         ik0+WzVzEu8nwd++pNJO8DI030sS8WazIrTty/NiFQ8ONkKeWud21OLbIV3fcP1zws+H
         tGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea/yM9UmAh4jA656etZf9PBFx+DV2lsOK7Wt+MY+UHs=;
        b=LC1137T4W59TAVl3QCfcVP9YMTaRUQqxVI3a6t+NuEGo/Gc2pqOtrHdXp+O5JYZXNA
         eU3k9BFNiVdh5DzCL7the5ZSXUIbEX8pXrCKffaHB2rcLyIbq6qFlHhCozJ7v+qwkHbb
         u87m7BzDj8XZDDHYvXwbEGaJ0BHyLV10lmgvOe/Iv/ckoYjwWVSjcB9/NpA+p6swMXio
         qTfNxopFK1nt217VV35qA14hQz/jau07Jvzc+tI0QwHr18JRQdWqqfqgaEMd5NcNFn5u
         9sjO56C+W7Hbu2I0YPQKTef+JIIC3fRLxOlno1wtBPvLiz1agm/3OUEBMy/ByvbRTUqo
         9gnw==
X-Gm-Message-State: ANoB5pk0Yf82w+YDh6/hMl/c8oy7Ek1rffzYcVd9JkA4OiPc+rJZX2Ze
        9hx1Dit53/xuI7PD6eTzjTe9y1rKIDGwJw==
X-Google-Smtp-Source: AA0mqf6gv9d2ku5rAueFJwmlzoC4HZuUexraZBE9nGAfMDp/CKeAvkKvxr89hL5Rq8WilUf0KS/O7A==
X-Received: by 2002:a37:aa41:0:b0:6fa:c90:7aa5 with SMTP id t62-20020a37aa41000000b006fa0c907aa5mr4577587qke.319.1668749702510;
        Thu, 17 Nov 2022 21:35:02 -0800 (PST)
Received: from [172.17.0.2] ([20.7.18.220])
        by smtp.gmail.com with ESMTPSA id q24-20020a37f718000000b006ed61f18651sm1769639qkj.16.2022.11.17.21.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:35:02 -0800 (PST)
Message-ID: <63771986.370a0220.6f97b.8f6a@mx.google.com>
Date:   Thu, 17 Nov 2022 21:35:02 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5582636675504402120=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5582636675504402120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.39 seconds
BluezMake                     PASS      757.34 seconds
MakeCheck                     PASS      11.50 seconds
MakeDistcheck                 PASS      146.82 seconds
CheckValgrind                 PASS      240.30 seconds
bluezmakeextell               PASS      93.97 seconds
IncrementalBuild              PASS      612.77 seconds
ScanBuild                     PASS      964.38 seconds



---
Regards,
Linux Bluetooth


--===============5582636675504402120==--
