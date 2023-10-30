Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06907C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 17:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbjJ3RS5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbjJ3RSw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 13:18:52 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB299
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 10:18:49 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d11fec9a5so27984676d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686328; x=1699291128; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IJy8fwYxWgenp/IV+dKFW7j6b252TVVf7xAsOj9NCh8=;
        b=CUwmfALvX5nExHPObTymH+RMnGWU6f54cH3K+yXpj/j4aPcvD+flh08HZhKPPBJngI
         hUQjkjzsrUUz0vQMpl3vW6MUN2cUvNRzlFen+IGUFzy2yT/J12IBF0Igc/PjQCHrI8u2
         ShXtRaHyffNVzpqWxK0PfonfrH1XrFeLgHfFC3j1tkAUoMBYvYy105Sg+sYXnEKwA272
         DXFBem2UdSUdF7yzDxYIShFV6JNBm/wkfyAOeizb5XVOSGEaIng5GevsPeEvidksj9Q9
         hZoPr8U22nnv4kmPo2LDtAEt8cF26uYSDgzC5lh6gM/JUv7SXUltWz/ujU1pIJFoalal
         S31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686328; x=1699291128;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJy8fwYxWgenp/IV+dKFW7j6b252TVVf7xAsOj9NCh8=;
        b=WJGc7DCJSDIO61hNXWCE4zp75q5zqTqxzeIhbgLtTRPHe9RXRiGw9GkF3/SdX8jCKd
         E6zT10drf7w9DH6O16MWgVcHCrxd9AxwQzKY7WOOPGeaLYspksjFmnWUQFQH/+A1GUcM
         T2KeSK+Ura8m3RehywXVqrBIQp5Ve8EJGlSPGPYUSLLA8kC0L+U20xzv6OHCjv18EIOj
         0LLmpt3k+SXf4065VhI7ZDdpgCFuceaLzGLXqRX25hDM/QMdfz1C24FfbS3GdKdObg2e
         83VsY0IsHy6LzqTrp8Xdhvpo4lI7PSgHHavmR8AHUi0bBWFy3uJRDmArnkRpaEK5HoJ0
         voqA==
X-Gm-Message-State: AOJu0Yy0tc23glncUUyS2yZ27pYEH+6L1ijxQswo+GXAsqSPDnry4hh/
        ZHbnTgoyzB903I8EB67QU0wjyMDiyzc=
X-Google-Smtp-Source: AGHT+IFGHtZJkcxBNiVk/SI+TxQRH0A6nSipl3Xk1FWS4nZisQo8u9iA6Now8tWeIk8eEqK5v2AKDA==
X-Received: by 2002:a05:6214:268d:b0:66d:bdd3:5d5 with SMTP id gm13-20020a056214268d00b0066dbdd305d5mr11975747qvb.0.1698686328140;
        Mon, 30 Oct 2023 10:18:48 -0700 (PDT)
Received: from [172.17.0.2] ([20.185.155.248])
        by smtp.gmail.com with ESMTPSA id c11-20020a0ce14b000000b0065823d20381sm3572093qvl.8.2023.10.30.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 10:18:47 -0700 (PDT)
Message-ID: <653fe577.0c0a0220.c1660.d40b@mx.google.com>
Date:   Mon, 30 Oct 2023 10:18:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5490286125926199155=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Move io handling out of src/shared
In-Reply-To: <20231030153903.4248-2-iulia.tanasescu@nxp.com>
References: <20231030153903.4248-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5490286125926199155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=797651

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      28.24 seconds
BluezMake                     PASS      880.93 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      174.45 seconds
CheckValgrind                 PASS      272.55 seconds
CheckSmatch                   PASS      361.79 seconds
bluezmakeextell               PASS      117.14 seconds
IncrementalBuild              PASS      733.02 seconds
ScanBuild                     PASS      1083.89 seconds



---
Regards,
Linux Bluetooth


--===============5490286125926199155==--
