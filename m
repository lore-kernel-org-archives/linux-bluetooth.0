Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C9CDB465
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Oct 2023 16:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjJSQgT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Oct 2023 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjJSQgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Oct 2023 12:36:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAED11D
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 09:36:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1caa7597af9so15466405ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Oct 2023 09:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733376; x=1698338176; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eSEves782A28lfB7/nK/wRBX62Domdlq5XBqMnOKN8g=;
        b=TzD1g2j1535ztOw9nmQ2h0vZmHKj3Oj4I274lCeHCdiSYk94QUPrjCVh91yc04oLQg
         MTwaA9Env7Knx8pG0phPM6H342ny2gKC00fRor6WsLagDDxMn6Ad7itqdZflgdoqyiIt
         h3dPeGUAmuk9kjf7AvCPinS8i07EjTlZe69p2nAc7Eh+H6jwK9Rra0n4/j4txd2L6nd2
         Th0fqzGNB6uvX3ng0KZReHDEHhBUWJsmSZ2ZunSVo7+We9zPxOygdqJ6K0+XJsvaj4lw
         wn3sw444QFPfC8gOnY17Tj4qqYpoRKElEyNefDUs/dA7pd4XYSqCJ7GI+h1O6lBUtGGk
         BW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733376; x=1698338176;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSEves782A28lfB7/nK/wRBX62Domdlq5XBqMnOKN8g=;
        b=DajEu3MYNagfWr5tHCs2dpoGdnh4CYQufe/wU+Jl5zEGmy85jy9EnfnU0KIBHye0Ow
         +aH6qQ2TwDV8VsNSsmO0wMQcXVZx1GNy/L1GB/Riq0lB1ibQOgNadDK22VWYZRY2sM71
         0oDBXf5x5hmZydJADmew9buvYGxCXesN+QMJUJJMcf7ayjDvvp0fJelU8F0lt1BlTm5G
         FDIHGav4RfeaggxdmdPAarxmfJCk9XqaQsZNNXMQRvfA/C1hNxSO/iuLIlzqpibLyOsL
         DDyTmNZYptHwGHm9bD2/qPm2app5YNTaXxvlkyiiLhYEkhSqa4cAWG3edZZhant53wAh
         USwQ==
X-Gm-Message-State: AOJu0YypZ5YArhQ92yg7v2bgrrDbfoCmStZCF23/HstYTWlZURghvsVD
        I7xz0PIexvc5m85XKgnu1b5M6A054Mg=
X-Google-Smtp-Source: AGHT+IFW0gH6/1OanWPJuoNociypDtezuqqqBmToWi3ay8z4DSfgP2wuirvrukZjmlGajSrVyDUP4A==
X-Received: by 2002:a17:903:6c7:b0:1c0:bcbc:d5d with SMTP id kj7-20020a17090306c700b001c0bcbc0d5dmr2417336plb.61.1697733375712;
        Thu, 19 Oct 2023 09:36:15 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.245.119])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001ca4c8edf21sm2148379plh.170.2023.10.19.09.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:36:15 -0700 (PDT)
Message-ID: <65315aff.170a0220.795e2.7133@mx.google.com>
Date:   Thu, 19 Oct 2023 09:36:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7484860399455837090=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for bcast receiver PA bind
In-Reply-To: <20231019145037.4776-2-iulia.tanasescu@nxp.com>
References: <20231019145037.4776-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7484860399455837090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=794779

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      33.82 seconds
BluezMake                     PASS      1161.27 seconds
MakeCheck                     PASS      13.17 seconds
MakeDistcheck                 PASS      221.42 seconds
CheckValgrind                 PASS      339.20 seconds
CheckSmatch                   PASS      467.63 seconds
bluezmakeextell               PASS      146.93 seconds
IncrementalBuild              PASS      1055.04 seconds
ScanBuild                     PASS      1431.62 seconds



---
Regards,
Linux Bluetooth


--===============7484860399455837090==--
