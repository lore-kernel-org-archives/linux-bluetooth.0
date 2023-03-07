Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E48C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCGWax (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjCGWaG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:30:06 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E2B0BA9
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:29:19 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d7so16215686qtr.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678228157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tKMma6Rz2NP++wpAuWjiHAPhHb/87q0Egau5xtnvjY=;
        b=hdW+rKrQvBT24cxVB1M9NFyYOmGWz7xMfaF3HcI7Ya59CJVjI8xSNpSCIx2FQ3Saio
         8T+xROZdXMfKCT2/moughB8I4pbWJWObfZ4c39y89AEJ2ZiXQQMDumN+FUWdD4W8n1vM
         bn7LaLijLReW0UeLFDH995qkqio2J5W6BGizi0nXfISVJPUXO9/FMUmZmrwqGuW88TfA
         S3jDosINMdhImr0Kj1chPJX28OOvgvk/P9QiQXwQ/6URsC7oEegg/5ejMILAuVwBOYZb
         tnK0CWXUD5Q4Q++blwK35d50iNAIWLkxksdFw9RqtTRVVwg1lPJmDmDA1AjuUEbfwEUq
         VZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tKMma6Rz2NP++wpAuWjiHAPhHb/87q0Egau5xtnvjY=;
        b=QL2tRco1Nn7ujJVw9OQA0ytyClr06BkYoryCscfGaMeQ0+E79xbQuXQl9fbaVfcixy
         yXGaVtWJsCGLrosarbtDPLYTMZGsdHXmW2lYhggPagwVG6U8JA+qZiXnz48UEMfDvPe0
         xww4H+FJeQQL5r7N5/8ocr+B8Wy0yJbcMImIWIhpO7uYbJe7GuHvz2VC+lURwgMZBpZw
         sQZ48Y62yX72ZMyb5kA+b7OypyGg/RV9U6j9j5TZn7iwZGgjzOAJeDydnAb0KOBcn2EJ
         b8VvJBvli6Xejh8dY9XcnKtOl3ul0qp8Pz4DAagRaab5EEWrW66dBWMs1SUYtcPfGSyi
         XeCw==
X-Gm-Message-State: AO0yUKVxZmFxI0X2l51HYX/1EwbajI56BOSQIqYQs8QovAG9+q/rgXMf
        mx3AeJWAbMpq5rVoCDMRSb7xh5pe82E=
X-Google-Smtp-Source: AK7set8GULSSGya2SfCH+xBvtFdH8BZJHuPuOPUQU2V8d3dNItEWsMq/Z5ybX0pLgscgILYkew1hag==
X-Received: by 2002:a05:622a:114:b0:3b6:2f0d:1925 with SMTP id u20-20020a05622a011400b003b62f0d1925mr21949493qtw.64.1678228157643;
        Tue, 07 Mar 2023 14:29:17 -0800 (PST)
Received: from [172.17.0.2] ([172.177.255.2])
        by smtp.gmail.com with ESMTPSA id x25-20020ac84d59000000b003b86a6449b8sm10329432qtv.85.2023.03.07.14.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:29:17 -0800 (PST)
Message-ID: <6407babd.c80a0220.7c0bf.1f46@mx.google.com>
Date:   Tue, 07 Mar 2023 14:29:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1574258616875438428=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/att: Always queue BT_ATT_OP_MTU_REQ on the fixed channel
In-Reply-To: <20230307211756.2581274-1-luiz.dentz@gmail.com>
References: <20230307211756.2581274-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1574258616875438428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727615

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.32 seconds
BluezMake                     PASS      733.56 seconds
MakeCheck                     PASS      11.37 seconds
MakeDistcheck                 PASS      145.39 seconds
CheckValgrind                 PASS      237.76 seconds
CheckSmatch                   PASS      317.08 seconds
bluezmakeextell               PASS      95.08 seconds
IncrementalBuild              PASS      596.28 seconds
ScanBuild                     PASS      936.72 seconds



---
Regards,
Linux Bluetooth


--===============1574258616875438428==--
