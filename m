Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4D5C6FA8F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 22:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjHXWeV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 18:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbjHXWdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 18:33:54 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABAB1BEB
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 15:33:42 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a88ef9444bso242016b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692916422; x=1693521222;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uMmZrCSlSbU/Xbhpr1P/31n8z40+ffREE+AIeSBRVqY=;
        b=HdBjgIcpcKGGfjpws8yTKUORWIcCh05yv6F583S9Lqx25zAQ2Yk0b6QWaIO2zLCnS6
         0hmGJaJ3hO2mf4tQR18iJqekDEkt4jt5eSjCy1rCRDlBBcd4uMPfnPS2/ir0TBuYY4SG
         IWwdgGPnQiwwGS3yDkiL4qZmZxGUmleLFUiJhstc4lrU4sJaYnjJVSxvDklesaRAkE7T
         2trzw9J3FATuo5RRBK8mtzRnPpUTUbshK3rQ8RCYL4fhHgnHk7J1+m71bZNnlQwEZgWb
         1jRB2XdQvpSIAwsVoIFQkkWTR5PkAgK8SP/jFDq/fw0NMZE2a5FOL7MXbyc9dp6AuEKA
         j/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692916422; x=1693521222;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMmZrCSlSbU/Xbhpr1P/31n8z40+ffREE+AIeSBRVqY=;
        b=NO/Ljg0elpi8fLBcN2+slJQ+UVeS0XNx0vLMYaaOA0NUnmOf+W1DhMLsJr8o/gjSNL
         urXtuRfPYfcKre2PMe1tDAln0aGmdUvq2U3s+oYECofFsiW8+ynsl5/9rphp2+W0LCMq
         2MK4ww+/lDypMjyW/OIgZGY2Kpy2os7dqiojxHnfWlk5BXaz1NGxwsvdI0E0bptTcecT
         1/93BEdGaRVtLNL/Nzj7HcLHTvjHZqxXqo4QidKxFYCIRryrqz0DxSIuryAgMzaGho04
         0cC+VI+OIDim24YnRgVhRFV1FcNGZ1WzrXPwXFonn2oR5erFq6o23jObjI/BfnEwV7oq
         nVww==
X-Gm-Message-State: AOJu0YxRa72unUkweyOtpfd9Olorcxq8PfqLKwpOOASWBMAyjymKmMTq
        If6Oy3hKkEUuFV15YK3zXaH7G4Ke6r8=
X-Google-Smtp-Source: AGHT+IGkdoHhl5Rwwbpe1lrueAbmF2LdoP3PYR2BithslH2TECdqe4u6jKJCGkA5DBDAWSbnl/KrTw==
X-Received: by 2002:a05:6808:210e:b0:3a8:6693:135d with SMTP id r14-20020a056808210e00b003a86693135dmr1266096oiw.49.1692916421747;
        Thu, 24 Aug 2023 15:33:41 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.30])
        by smtp.gmail.com with ESMTPSA id y9-20020a544d89000000b003a05ba0ccb2sm167499oix.39.2023.08.24.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 15:33:41 -0700 (PDT)
Message-ID: <64e7dac5.540a0220.d569d.109e@mx.google.com>
Date:   Thu, 24 Aug 2023 15:33:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6309778814979832060=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,RFC] media-api: Make QoS a single property
In-Reply-To: <20230824212153.11050-1-luiz.dentz@gmail.com>
References: <20230824212153.11050-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6309778814979832060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=779177

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      26.84 seconds
BluezMake                     PASS      780.95 seconds
MakeCheck                     PASS      12.05 seconds
MakeDistcheck                 PASS      156.04 seconds
CheckValgrind                 PASS      251.09 seconds
CheckSmatch                   PASS      340.10 seconds
bluezmakeextell               PASS      102.47 seconds
IncrementalBuild              PASS      656.04 seconds
ScanBuild                     PASS      1031.51 seconds



---
Regards,
Linux Bluetooth


--===============6309778814979832060==--
