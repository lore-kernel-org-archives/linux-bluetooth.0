Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C434EC54EBD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Jan 2023 00:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjAMAbP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 19:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjAMAbN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 19:31:13 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E674100A
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 16:30:54 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id d188so5476619oia.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mFkQOQYxDnJavLSO2TiOV4YY7DGtgbNim/7misooHJI=;
        b=l6USxF2PRGU9BKG5m3ULZ/yP20PtET3uYibCeRWJkoulHpe2WjzhlISF5SOZao2zdQ
         TZU9SUnvye29Xgl/vPLgMBdX+6FUeT2dC8e3dFbCVUIlbKeIrBWYoPPk4ZM9KuWE1iq3
         /S9ZkhXyNdJNXLPe7LpdHIkJTfiIDn0Nci33SqeQ4HymdUwJNCZEoP5cpO2gr4zPj2+a
         PCZzj26qMnDZMPpd9AcPN10gZWhM43bXe6m+awfBwpvoY0MEOyfnEBXogGjrNjcltFcv
         5ULzJ3TiXbiaNtSQ1W3RmIC/S8yl3AwWJ8Ay417QfWUb3c95wh0PRWZcCGtw1pZ5d7T4
         dwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFkQOQYxDnJavLSO2TiOV4YY7DGtgbNim/7misooHJI=;
        b=RU+ynGuzBf7T5E4PvgoBQGDtYW5yQA+sqvCAZBgcel/JhJ59qIF3y7KHbdE2DUixrj
         tHv9B0p36KQM6GA6a0qwc/JjVndbgm78oQSv1xTZUIrpiwOMC7eLURNTuc5ihMdYxM9f
         5FmCjZT8QRSfRAhpya8nv6P3KZtuiojQYer5VsNmiYLSysOEf26rHk8oCE99wivCArz5
         XoRK61SqL3tj41o/61nvdnDiGlSYm6gO/iz0emK2UBZEf8NYi+N6UOngEKYm3scq5RSE
         roXpR4bWUESdA9SCIbla5BmiIAo7pj89gyEl5yMGHHgbkqjmerD2v9eCDZYJhzPXwME8
         rlFg==
X-Gm-Message-State: AFqh2kqgo9PKS60F/ZkJVXSiap/INZ5D0ywWS2bWJ+xE08/gqF2GD0mT
        5NQi9tnWQZt3iGbGTFJOzHQytNLEt3Y=
X-Google-Smtp-Source: AMrXdXtEUXh9wTHVV1qmnWQxOwoX19yKj85SQX6nc8mGXA04TsF8xu0Ise7BXseCX9oAfJ7F4wDtMA==
X-Received: by 2002:a05:6808:1493:b0:361:9f8:84e7 with SMTP id e19-20020a056808149300b0036109f884e7mr46288243oiw.6.1673569853805;
        Thu, 12 Jan 2023 16:30:53 -0800 (PST)
Received: from [172.17.0.2] ([13.65.246.129])
        by smtp.gmail.com with ESMTPSA id db11-20020a0568306b0b00b006391adb6034sm9851170otb.72.2023.01.12.16.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:30:53 -0800 (PST)
Message-ID: <63c0a63d.050a0220.aec60.1a39@mx.google.com>
Date:   Thu, 12 Jan 2023 16:30:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4846464029249684778=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jingq77@gmail.com
Subject: RE: *** hcidump: fix array boundary issue le_meta_ev_dump ***
In-Reply-To: <20230112232112.212021-2-jqian@calamp.com>
References: <20230112232112.212021-2-jqian@calamp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4846464029249684778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=711516

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.78 seconds
BluezMake                     PASS      760.11 seconds
MakeCheck                     PASS      11.57 seconds
MakeDistcheck                 PASS      148.88 seconds
CheckValgrind                 PASS      239.87 seconds
CheckSmatch                   PASS      320.10 seconds
bluezmakeextell               PASS      96.40 seconds
IncrementalBuild              PASS      610.04 seconds
ScanBuild                     PASS      954.08 seconds



---
Regards,
Linux Bluetooth


--===============4846464029249684778==--
