Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2E6CE79A8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjISRxl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISRxk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 13:53:40 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C4692
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 10:53:34 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-773bd514996so226746085a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695146013; x=1695750813; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GCdp2ECCuUU/suB91ABuGavQd06mnz4vi4QxVsl4s+k=;
        b=XZuV9WdQywADDCEk5HNoXeDUDrCB1lRgeqKu66NxIdiYV7UGYsUAAnYJVpS/wxpwI1
         AxsoNf2HQtm3LKiyuSuF9/E8l7WKI+4Ic8KeM/SpYuDWTtuVFcY/cx4Mc2r38bRQAqPb
         K1ZrKjkNwvRV6RY+0XSHaM90awht04niE/daTsa60rlRtwcWWuvLmMF8uFgOpo8dzov6
         FAKjMgEoCetAyHbWWfjtsuTY1N2u6/PobPPT64VPSHRW3nA9Y146A5QcUoKdRJb4H5Us
         vNhDrHn1UOwPtmy5cOBJeQsIngEdDTyrcW7XtG/eQeuq+VM/xa9g6sHQYiDKYLpziQev
         bEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695146013; x=1695750813;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCdp2ECCuUU/suB91ABuGavQd06mnz4vi4QxVsl4s+k=;
        b=Gabbj1wOJGrINJysRdL3qD/RSB3JwYmzADbTqoxtjsZ3WBUMx/yog9ASeUZSBjKMO4
         z8Y67ZtYzzkwLZYnkn4tpYmvzWZidQrywA8ViXsvoPsLxUKjpP3kLiZSCEuUqsyP+zum
         a0Bl5Mo50gmxqoDReUpYz4aQ0O4yZ9lS85QCjUqJYAlL4Hkk6IFT+4yOY1JbqX1xybkO
         nldBqK4XOgvegMjZ6kcHAqePSs98kiuPbMp3RIpf62H+VpnazwxVO6SKYQTgWkAkF10q
         8lz03Jk/fODf6AOsLA6xIa7nm3mE8V5uWQ4S0+LBP2sTBtDqKVjKfnt9Iso9j9w9gPRY
         KHNQ==
X-Gm-Message-State: AOJu0YwXRs5fjHN6mEh/6T75soq4T4GiFsrVluqiBoy74IwjfpXfBjVg
        MiZFGJT/PgpXI6SgSWkiY1THioKVdnA=
X-Google-Smtp-Source: AGHT+IFiK83FH5KSgy/J4HbHtJ8XcBhVO3pwOrmaLnVuzh0jj1FIjAp1hkR5M/e4wVpqM9ut4kKPLw==
X-Received: by 2002:a05:620a:404e:b0:773:cc16:ef11 with SMTP id i14-20020a05620a404e00b00773cc16ef11mr446302qko.13.1695146013184;
        Tue, 19 Sep 2023 10:53:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.24.71])
        by smtp.gmail.com with ESMTPSA id c7-20020ae9e207000000b00767c961eb47sm4153927qkc.43.2023.09.19.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 10:53:32 -0700 (PDT)
Message-ID: <6509e01c.e90a0220.e12a6.f935@mx.google.com>
Date:   Tue, 19 Sep 2023 10:53:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7068464959553099463=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ,1/2] emulator: Skip new line when using util_debug
In-Reply-To: <20230919162745.894828-1-arkadiusz.bokowy@gmail.com>
References: <20230919162745.894828-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7068464959553099463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785675

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
GitLint                       PASS      0.72 seconds
BuildEll                      PASS      27.95 seconds
BluezMake                     PASS      856.86 seconds
MakeCheck                     PASS      12.43 seconds
MakeDistcheck                 PASS      157.60 seconds
CheckValgrind                 PASS      257.99 seconds
CheckSmatch                   WARNING   348.58 seconds
bluezmakeextell               PASS      106.98 seconds
IncrementalBuild              PASS      1500.71 seconds
ScanBuild                     PASS      1069.65 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:420:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7068464959553099463==--
