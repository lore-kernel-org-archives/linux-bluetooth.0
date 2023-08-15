Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AADC0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Aug 2023 23:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240512AbjHOXE3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Aug 2023 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbjHOXEU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Aug 2023 19:04:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CFBC
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 16:04:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdef6f5352so13768745ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Aug 2023 16:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692140658; x=1692745458;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Asxs7IXweAZBjcfwvFotJGoiTQEkWmDfDDnsuF3fH0=;
        b=qUb64jn03IQFMxSMr/ljiiHIQlZIV4G+qyMsUTO32dz/DOWk93zxDQRa+oWwj5ZJ2c
         mCr6XyOGWUguySQBzormVzRSLyLrqWC3UsSmvu5+tYcKzSjV6xrm/6P+88tC9WLBtKEl
         D2ix7iiYHbWFNXwnmiqFuwUFQdSTAPNx/TFSw2FQ1q8gkQXXJfd9SKuUwS3iJzinVkL5
         wuKtHDokVhHylTBCE+ltKDfro+P0bgIqN+g+YPWxq3NDJNPhPTy15beuNiXBgQzn2SbY
         +ixeCQllISiKhLNnnjbJlo9pSzLEtuhq418nYzs9ixoWiulddKZtGXbM7UXPy8PHwT9t
         ITcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692140658; x=1692745458;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Asxs7IXweAZBjcfwvFotJGoiTQEkWmDfDDnsuF3fH0=;
        b=WfBIPQsDQyfzcS5g4Oo3xQ35ymTMQYrI7xvHX7PtlhU6Ypnfid554qPKOdua6FRbb0
         0a5AhaRYOn4zhtKZeDXh1S0mdQfvRS24jDmbVwCzVVhi3Gr1fQZXn4wgyHJBPfwpSzaY
         OSb0N6PPNqNqELwPgHKT19PyWE8tKAStOpjBpi6OW9ZJPkUIWijdB7LGtbyiUCnQ/ipC
         CY6vEqaOnT4pn5G/lvceUDDKgGsH3jxrC3z8xJxj/UECgrYq7LyILLZS73UyIgY/HVWn
         Cnq87c4H/zQO5IwLczkW2NA1dT6+IYLX0+2T5ts/4Gkpsjg1+wVlMI5pxMlFlwlIejLP
         e+Wg==
X-Gm-Message-State: AOJu0YwpKySVTx2uLi+rXqascwIPYuIUhrCa3YGFVoibO98BPMLFiocv
        XTWtlPKxJbkiOx+Xb2IYmM2CgahQQNI=
X-Google-Smtp-Source: AGHT+IG6iy4ZcMhRecSzRhs9sk4FMerFmRObLlyugJVQ1k/pN2mm3agkpERDqdMaeFKv7LYyaE5mgg==
X-Received: by 2002:a17:902:f7d1:b0:1bb:3a7:6af7 with SMTP id h17-20020a170902f7d100b001bb03a76af7mr199525plw.23.1692140658142;
        Tue, 15 Aug 2023 16:04:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.161.17])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001b8a3e2c241sm11640056plf.14.2023.08.15.16.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:04:17 -0700 (PDT)
Message-ID: <64dc0471.170a0220.ad654.67e5@mx.google.com>
Date:   Tue, 15 Aug 2023 16:04:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7764968727665891370=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_conn: Fix sending BT_HCI_CMD_LE_CREATE_CONN_CANCEL
In-Reply-To: <20230815221803.2491905-1-luiz.dentz@gmail.com>
References: <20230815221803.2491905-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7764968727665891370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776432

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
GitLint                       PASS      0.25 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      36.85 seconds
CheckAllWarning               PASS      40.66 seconds
CheckSparse                   PASS      47.48 seconds
CheckSmatch                   PASS      129.79 seconds
BuildKernel32                 PASS      36.58 seconds
TestRunnerSetup               PASS      559.87 seconds
TestRunner_l2cap-tester       PASS      27.79 seconds
TestRunner_iso-tester         PASS      57.80 seconds
TestRunner_bnep-tester        PASS      12.98 seconds
TestRunner_mgmt-tester        PASS      249.00 seconds
TestRunner_rfcomm-tester      PASS      19.17 seconds
TestRunner_sco-tester         PASS      22.09 seconds
TestRunner_ioctl-tester       PASS      21.92 seconds
TestRunner_mesh-tester        PASS      16.05 seconds
TestRunner_smp-tester         PASS      17.13 seconds
TestRunner_userchan-tester    PASS      14.02 seconds
IncrementalBuild              PASS      34.47 seconds



---
Regards,
Linux Bluetooth


--===============7764968727665891370==--
