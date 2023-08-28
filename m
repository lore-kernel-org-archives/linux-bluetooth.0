Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCB6C83F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Aug 2023 20:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjH1Udy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Aug 2023 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjH1Uds (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Aug 2023 16:33:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195BFF
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:33:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2498810b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Aug 2023 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693254825; x=1693859625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f+JCFnaTJaqyLP9wzBlZd/iWZDGAtAnlGSPE6Lqw7v4=;
        b=P26REecn3+RXcZb9C5tlPQnACTtRdIr2y79CExWU6Az04b6m5lR4lwJUGap5NJ0eue
         kvf9HGxWQOyRyv7gkA4Y5889CRyk1TFmazNKUf90+k6Ga7ZKkGnpj+t58JNN5zOJMAqa
         DB3IKclPWVAvqJb4o3opoxRbqU8T5G+kdv5jXq7zclw8tjrrli+oSm9Hqpva9sujHA9P
         7bUgy8PKMLGh1Fnl5Bf8t6/WpPHKTp6USvyGrppFoGX1ZVlR3ojaNQRPXmSjMKOBzCCA
         iS1psP28SxCqxDMyKCMkcz4k0mCJ1ocM4YTx0kHBZtm7PPpQ/qsgEVHij6giCw0x0uwI
         0M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693254825; x=1693859625;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+JCFnaTJaqyLP9wzBlZd/iWZDGAtAnlGSPE6Lqw7v4=;
        b=YYXYJU7Ai4DHPmGX3A5As1wVFUZaOEpnZrkuj6v/y8b3DMNAPoDQ5LPSCHrjeWSokS
         oF2vtKIVrjZ5tCcbI/godbXOSrvdhEdqcPIeUACLbosk61MtCULyvMToQqhuGO2es6xD
         dIaxKQuGfARbQO/ff7PZ4JjalOVlQdvEvkl3/CQ0botybQfknA+GGHngyeax+zMqr05Q
         4YR44stRezJCJam0R+PCgE6r53MGd5dD06i6zv7Rb1tRv7H5cyykgLOpM+/HlTt8lm0W
         OGs8I8ysAv0vpAGSKkiW08qAiESX2G104SrMpe+PomkAMXDmSaa6JwFmzoi1JNhOMavJ
         KsYw==
X-Gm-Message-State: AOJu0YyRL/ug+hR8E5L9zTOODHa/E0xO4ynm9v1+o1F+0HNICXSjnc7/
        EelnUtON8ryKvM4Z5AI/NzGbXhczR4w=
X-Google-Smtp-Source: AGHT+IErTrLUeAanE9EyRPmn+BanwRXPqo71GfnXzj5Vr8fww0jscqs6toDmbSHdmV2F30cAAy0q3w==
X-Received: by 2002:a05:6a20:49a2:b0:134:a4e2:4ac8 with SMTP id fs34-20020a056a2049a200b00134a4e24ac8mr18757552pzb.39.1693254825364;
        Mon, 28 Aug 2023 13:33:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.166])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79103000000b00668652b020bsm7043862pfh.105.2023.08.28.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 13:33:45 -0700 (PDT)
Message-ID: <64ed04a9.a70a0220.6e6b9.b1c3@mx.google.com>
Date:   Mon, 28 Aug 2023 13:33:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6604001445266025069=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] bap: Remove duplicated code
In-Reply-To: <20230828193011.551312-1-luiz.dentz@gmail.com>
References: <20230828193011.551312-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6604001445266025069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=780033

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      26.47 seconds
BluezMake                     PASS      787.73 seconds
MakeCheck                     PASS      11.98 seconds
MakeDistcheck                 PASS      158.02 seconds
CheckValgrind                 PASS      252.91 seconds
CheckSmatch                   PASS      341.71 seconds
bluezmakeextell               PASS      102.89 seconds
IncrementalBuild              PASS      657.14 seconds
ScanBuild                     PASS      1034.51 seconds



---
Regards,
Linux Bluetooth


--===============6604001445266025069==--
