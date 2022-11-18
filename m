Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbiKRF4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRF4X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:56:23 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C508CB88
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:56:22 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id k2so2792849qkk.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=26ro5Ga2okxWmmxteN/1Nwj/djhd9YgjtThJqYlMIY8=;
        b=Pzb7e0bezWJo67HWhNurjSY6iFvPLSTB/3mf2rFKAy2zAq1nKCCwcw9Nyss2DWmX/x
         FseU1mUUldoleLBt6HAbPaKXfpXNtdbazvADKhjn+GElfn7Np0oMNU0wqNG2MJJMM42L
         jO2X2mWr+F2XsSDsODxwPtS5g5FXZQ2sAhnI2PQ79j7ivHNRO8AkvkJ7OwdAEfzEB1fO
         4D5qXNYR8NJqsYuBbtjslMqYfc3D8SlLGtqcTvCu94sEoNpwnNQUh7xu9GtTgD+UG0hO
         7ErVHTEPkR/a5OstwABwAzeWajf9sY8BoG0DaTe/8vEeTimFkK4jfCb8wboG3vA4zKYx
         fFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26ro5Ga2okxWmmxteN/1Nwj/djhd9YgjtThJqYlMIY8=;
        b=CK48zhwoKvRbGBX5DNCdvD7m4p6V7v4svckIJl/oHVqFmUD9U/+IFxk7BpukOuKx8y
         8R4/MlhF53EQAM1w0XkwQEeJM9ZYP8Q9DqVXaKWcpeFVGsoQ+zZcHGkTlXHLZjjs7yiB
         0iByKpgC+w4fmPNNbb74SrR/QGJBVsXK3cDmunYpxLDWnN0Rc0ZLszZdjnEyyL2WiEi7
         c2vFtkLwEOe1EKRLmeAOQ7n41F6Le69ZUQEEW2/ZoIMehOTR8uzCoj38DZTEGrmFTZno
         ht8E6Qg44R0FjnOe2uQGp9JnEmbnjm0jHno1SQhJx2PtjswYyTB0uPRF9NamtWSkQpr0
         nYrw==
X-Gm-Message-State: ANoB5pku2MFIiBNJMrTc/fwhK/PTpFkkD8ux6G2vQWdoUoDNwBCgsKX2
        17YvSP/WarXaBCiZ/OOEI/MDdmm0JtWoIA==
X-Google-Smtp-Source: AA0mqf6pQmE5DxepjVp9K0TqCTax7UdqRLs16VAj2pV2hunvvR2I5SDY5yrdpEMdLEfs+zKjiqYKPw==
X-Received: by 2002:a05:620a:16a7:b0:6ea:3fa0:bbfb with SMTP id s7-20020a05620a16a700b006ea3fa0bbfbmr4575005qkj.473.1668750981464;
        Thu, 17 Nov 2022 21:56:21 -0800 (PST)
Received: from [172.17.0.2] ([20.168.201.176])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b006cfaee39ccesm1847918qkb.114.2022.11.17.21.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:56:21 -0800 (PST)
Message-ID: <63771e85.050a0220.f7432.8935@mx.google.com>
Date:   Thu, 17 Nov 2022 21:56:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0297453069623703642=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0297453069623703642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      34.97 seconds
BuildKernel32                 PASS      31.13 seconds
TestRunnerSetup               PASS      433.68 seconds
TestRunner_l2cap-tester       PASS      16.38 seconds
TestRunner_iso-tester         PASS      15.87 seconds
TestRunner_bnep-tester        PASS      5.61 seconds
TestRunner_mgmt-tester        PASS      107.93 seconds
TestRunner_rfcomm-tester      PASS      9.58 seconds
TestRunner_sco-tester         PASS      8.97 seconds
TestRunner_ioctl-tester       PASS      10.35 seconds
TestRunner_mesh-tester        PASS      7.10 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      6.02 seconds
IncrementalBuild              PASS      32.45 seconds



---
Regards,
Linux Bluetooth


--===============0297453069623703642==--
