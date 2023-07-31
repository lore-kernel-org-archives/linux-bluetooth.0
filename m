Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A59AC04A94
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 09:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjGaJSK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjGaJRz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 05:17:55 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666E1B7
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 02:16:55 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-78374596182so207843339f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690795015; x=1691399815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bXD8cpI9yhBkM3xFtblY5iqLCgSqtNZXN6UReUiZ2Jw=;
        b=n8QxKDg5pL5M7E6wAl98doVQTJPhQolroHrwUrpc33NiS3CsF8yi7YK2WDoOLY6sF3
         Bz83c6TXjytw0cdf8bjC1/GaZ4mwR45ODcgtl5UWiWtIf8B1pZHReYRSFO6XwFiQe1Af
         zJkkmZGiphGEIHPm5d3Dk+Q4bkDu8G6pW1PhbRgh2rYkjp6rLY7MYDRY6CyyAsKLRf8U
         YuhBIhUMucZ4dpcR68kUzyruU3xMB7sRiNTPVRVJUWgYLViUnKiR0alw6Y3Ca/LaHn3r
         Rq9tmA7q7YATIW4UHlP95pVE+yIptJfnGCwFntSoEAWPetLnFQwhcQ9BWFPdZ1yoVasX
         9qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690795015; x=1691399815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXD8cpI9yhBkM3xFtblY5iqLCgSqtNZXN6UReUiZ2Jw=;
        b=Cxdv66W9QPxZpCmsYbyICBWoSIubp8u24/yWmyzyIm8gCdAAvyfsKdkGXDl7gdJm/U
         J+2Mwh+ZDh4DN3N6YQ573pPXiu/OMtFkAD0yWTtYB6HEs76bGdLJi99zgC0/EFQv1UHp
         IYsfIzi1ezZK5YjDYhL4jNyqqu/3tV6kS5xqdaSWEmBF/COzfh7LT64FLTt26h8+uNoO
         bsTaFlX3q9JRtYi1WKUVHz/4V14m8rohNBtz7a2hPTHI+TAk7pRGkyunEehLHjaV2Uyt
         xT0/HcxzIcFrZgXaxubt5JDFY4SzyAkjXhGnV8CKKEQ+LJHq5jwFoJ9ykR0dhwY0fmiz
         m0dw==
X-Gm-Message-State: ABy/qLa4Z1bMc6p9sO/ZiOX2PBcMoa7lB0HyHfWCasc4f57WwyWHLeo2
        e/QuFwGiZbR9TLCx/c/R+oRK0vT1ad0=
X-Google-Smtp-Source: APBJJlHZ0E8qlqhP1srBti+uP/Rfef7ggKE9rGDffrez7Yy2gO5nIvtN5NveIWUmA7jWolLDSD3/Yw==
X-Received: by 2002:a5e:920a:0:b0:785:d28f:1526 with SMTP id y10-20020a5e920a000000b00785d28f1526mr8568930iop.3.1690795015118;
        Mon, 31 Jul 2023 02:16:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.27.96])
        by smtp.gmail.com with ESMTPSA id d20-20020a5d9bd4000000b00790af7745b1sm202673ion.20.2023.07.31.02.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 02:16:54 -0700 (PDT)
Message-ID: <64c77c06.5d0a0220.89f98.02b5@mx.google.com>
Date:   Mon, 31 Jul 2023 02:16:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3268434092134533554=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] main: Fix a logical error within parse_config_int()
In-Reply-To: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3268434092134533554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=771058

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      26.97 seconds
BluezMake                     PASS      819.40 seconds
MakeCheck                     PASS      11.22 seconds
MakeDistcheck                 PASS      158.87 seconds
CheckValgrind                 PASS      253.18 seconds
CheckSmatch                   PASS      343.26 seconds
bluezmakeextell               PASS      103.67 seconds
IncrementalBuild              PASS      679.27 seconds
ScanBuild                     PASS      1095.06 seconds



---
Regards,
Linux Bluetooth


--===============3268434092134533554==--
