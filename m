Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10360C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Mar 2023 19:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCXTwY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXTwX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Mar 2023 15:52:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029259D5
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 12:52:22 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h7so1410346ila.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Mar 2023 12:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679687542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GgF7SBj4bKRaRvZA16ZW+3rVNuHQVOo8g8RzMfq5XgQ=;
        b=axDBXAo83DmY7/VlToBvNekubLJ0BpHxTvOzqmOgJEcv0vaA2qvAsBGBnoxzNIkzmR
         hdBVNm2/CqoIK9bxP70qdcFOPSPB7rkjNdJfcm25pO6wXGuGBDBC3Z9NGNot7q4eQKpM
         TdRA2PyYpOz7YF98o/XBChuL4iHsPC2r1P2hr46R6nxdHORQzuxrfoGX+zSKBwRNXklm
         vu5DLnC803h9+KrUIgkFY4EMxtmSYPpROdUJELcroUzy5L/gzjJvdUUaHisadV55Fbgk
         9Rob2tR/1oTkL4Rmy7llBdUbyetgp96G1hu2rFdeQJ6kgvCtS2oz05OwpVQB8quzarag
         Hvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687542;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgF7SBj4bKRaRvZA16ZW+3rVNuHQVOo8g8RzMfq5XgQ=;
        b=O9TwxMtlSJ1gVRUeGH2ZVWIhXFqW268gikZK4EHqEYUO5RVa4MLZ31mvd9PVy1XOtM
         vfueV8iNVwF8almot/OJROFjGTwP/YF4fa0cH7QK9/H91PpeUcx4N1MDX1nz5wV1+Ac8
         yYQxC9X1HSBLGB9+VMsKdLjWPWvIZrN8WmfS1EI3ZlicM5ndFJiY2swsh8iQ+0nAXRYl
         mmO9G6eXzAAbDeo91zTi3GKDMU5mJLfiJHjlqiuWNLXrKRucAmMl0FzIjgrXqVAcdfLh
         DCDI/SEiorkJ/BNz8U7FYcZdn1CFkyfyuvS9yp9M5Pk2Ko3VdE39rZR1rK7mzv7fr0kY
         bYTA==
X-Gm-Message-State: AAQBX9eYI/TLEsv7pwWgtqhGOeVLSBWVPNkWJrqlOtOi2WYKPDzEuu67
        nQkf+h66VXpiy+wwXQFDKsJ4DL2D11k=
X-Google-Smtp-Source: AKy350aopuJGZbPt3EjT/pe63QMQbsyfGpcGs774qgieCIyIR7Ox7d2BtB3lZIZzbM1W3imShUhOQQ==
X-Received: by 2002:a92:d2c8:0:b0:316:d9fa:f31b with SMTP id w8-20020a92d2c8000000b00316d9faf31bmr2940920ilg.32.1679687541886;
        Fri, 24 Mar 2023 12:52:21 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.66.36])
        by smtp.gmail.com with ESMTPSA id 13-20020a056e0211ad00b00325e56c1cdcsm249789ilj.49.2023.03.24.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:52:21 -0700 (PDT)
Message-ID: <641dff75.050a0220.82939.088e@mx.google.com>
Date:   Fri, 24 Mar 2023 12:52:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2256862735656521164=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v4,1/2] vhci: Add support to trigger devcoredump and read the dump file
In-Reply-To: <20230324111613.BlueZ.v4.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
References: <20230324111613.BlueZ.v4.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2256862735656521164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733659

---Test result---

Test Summary:
CheckPatch                    PASS      0.97 seconds
GitLint                       PASS      0.60 seconds
BuildEll                      PASS      27.75 seconds
BluezMake                     PASS      910.23 seconds
MakeCheck                     PASS      11.99 seconds
MakeDistcheck                 PASS      154.37 seconds
CheckValgrind                 PASS      251.74 seconds
CheckSmatch                   PASS      337.29 seconds
bluezmakeextell               PASS      101.48 seconds
IncrementalBuild              PASS      1504.22 seconds
ScanBuild                     PASS      1060.11 seconds



---
Regards,
Linux Bluetooth


--===============2256862735656521164==--
