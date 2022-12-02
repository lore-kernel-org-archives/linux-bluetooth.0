Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1624CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 04:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiLBEFr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 23:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiLBEFo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 23:05:44 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD969D0395
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 20:05:43 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so2253027otg.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 20:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t4i0ZNOCqSBOoD7wmO1iOLtHIymNzt+zIukr7Wu4EA4=;
        b=gJxhCJQCke2qEJC+WhPhy+vN15PKixa0Q5Z1k0gauz8osRK8SJF0nYMId02mujYFVV
         +lZqmiStcBHC9iCl6OT7U1Cmf2PsxYoEnS1gxIacclYgXv7/9G4Br8GJyb1W6sN8+6Ae
         +5O/KzqClY3XT/DDFSjFZH9QKBiG82gIJWt6yL3O8rVdAaTeNFd0m0+zwrJRU3V+ZIMY
         Ykddspi8PcI5GVd0NvrdWjFD0/SQZuiuGzlpy+E0JqsI/j8kH6f+zfF93p+0RBe0vIOJ
         0UGRVP6WohEAZrd07sBM1v/2rQ0Fk3F1Ck83ylD24sOthAHbdd4DAIm431ysbbqUUMu+
         VDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4i0ZNOCqSBOoD7wmO1iOLtHIymNzt+zIukr7Wu4EA4=;
        b=YxQ+i4DygNFDEiJD7++4BtCWII0D4tk2xlY+zAFtBkUWgxHJHh86ih1Ezs7d9MXUyA
         QFsd73JrT46SQNglg42sYQ8SXInytqqKF0qz64iEIzanPL7Cx+FGq5mfNdVViApw0cuL
         ODyXLWoKs+M3OvKJUNtTd58Tax3kKamhQ7uhcj7Csjmx75t/7l3Tp4z3P4GiiynCRpME
         /Vul2ZT2E02BLLRBcsGXyeB6snOCIjxN3QGpOP3m/qjg1hYxXPjKcF+vZE5w0YdOzX+G
         JA08v4V2ZVwK1swHUwQRAREmHWD6l2crzHnI6ibJOgBTnQNiK+I24Q0mCuq5hFay3VkT
         2hZg==
X-Gm-Message-State: ANoB5pn0Q2+wlKwvIs41YBCIg+p3WLeVQwSy8ljGKzsIyfBgySRxH9u5
        4LJZ1ZnQ8l5F1jo/TRhD0TmggN0tib8=
X-Google-Smtp-Source: AA0mqf7/e5+OJnheW0DcR11pWb4Hk8sQcveKyN5xb3yWbuKCujkfuq1+ILMlTuAWawhR00ZLpeyPzA==
X-Received: by 2002:a05:6830:b:b0:66d:67cb:ea16 with SMTP id c11-20020a056830000b00b0066d67cbea16mr25376308otp.243.1669953942906;
        Thu, 01 Dec 2022 20:05:42 -0800 (PST)
Received: from [172.17.0.2] ([20.97.21.153])
        by smtp.gmail.com with ESMTPSA id 71-20020a9d014d000000b0066c47384ffesm2871568otu.74.2022.12.01.20.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 20:05:42 -0800 (PST)
Message-ID: <63897996.9d0a0220.a4b5f.ce0a@mx.google.com>
Date:   Thu, 01 Dec 2022 20:05:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3466797324233833000=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/8] shared/bap: Fix not reading all instances of PAC Sinks/Sources
In-Reply-To: <20221202005051.2401504-1-luiz.dentz@gmail.com>
References: <20221202005051.2401504-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3466797324233833000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=701027

---Test result---

Test Summary:
CheckPatch                    PASS      4.54 seconds
GitLint                       PASS      2.60 seconds
BuildEll                      PASS      32.50 seconds
BluezMake                     PASS      1144.47 seconds
MakeCheck                     PASS      12.70 seconds
MakeDistcheck                 PASS      173.32 seconds
CheckValgrind                 PASS      287.56 seconds
bluezmakeextell               PASS      114.48 seconds
IncrementalBuild              PASS      7628.72 seconds
ScanBuild                     PASS      1199.21 seconds



---
Regards,
Linux Bluetooth


--===============3466797324233833000==--
