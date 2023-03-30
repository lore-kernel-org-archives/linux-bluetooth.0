Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31234C761AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 07:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC3H2q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 03:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC3H2p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 03:28:45 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C33AA5
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 00:28:44 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t19so17586195qta.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 00:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680161323;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/V/XFqLgbmWAoAQjo7N2uj0R5ybWR1NNMNMWlmqjVtU=;
        b=quwykS68N9e3kJ802D0L19qCDa5SXhzyErTkMjVgc8tvof02snlmqkVyuUoipHa67N
         EHTkY5dSR6lbLvYULK46+Fm22QOWmvpr2/aF9iU2eYa7DRKxwHu2ZxnfLQIPeNN+sMc/
         Rsybav0zyiH/UO+/Uda4Dtu/B/2Minvm3xFxS+tG/ZV9BFVs8whdJwq1JLdQ9YHlakMw
         Ly0kV+REb2pUxqJXVZ518sQxfDluwDXYfR2STo3UcL66FyiiMx9jULnbE0JyvpFi8d59
         Hxf2SBui76/I1HPZTs7XKfVtfl73rsZL39uzR4mR7Z6QzBNzXfHZJO0Y3Qwr1ZY8n7s+
         a7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161323;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/V/XFqLgbmWAoAQjo7N2uj0R5ybWR1NNMNMWlmqjVtU=;
        b=2sYGA7jsMVXInWZKU/fIQTvHCLABkvSKH/lYiP4k2Il322UnWdtLJk0W/peqJbuhAZ
         bK8zyFuSKjC38BGIKOekuNwWPMaPMvYxqqRm6VA51Q+rdFosZWYOng+3Ui/dR1UMC15u
         K3MOhVlrI41nC4+/DmJNJ97c5LJUfds1a1oNgz7mpAWxHPNdNcLaFvLwT0LqhIPeo2T8
         KOFTu+ABrfDrRtlJrNxqVS12sAAfG72dhjCPSYPEMQsGCfZxfjyIBzKR2/mn1wjiWbrd
         ZVXg/Yap2pZoU3Z6FqTXejbAWYbI9QXXAiKvV3583QveiqgWjaBOrHK1CVESQbudtMeS
         jwbg==
X-Gm-Message-State: AAQBX9dXCPzMADRYkD8fpwctkYQkqz+olBLZEG0Ro+wFE9OA98NMdS7/
        0sKMkuC4+MnxX+BFpNxwNwNF+ZdswxM=
X-Google-Smtp-Source: AK7set9UKn+g9l4BFcpVsxmbablHLVTg13+0jypTmq8ywzJcuIH4RVwMC8jYlGligPt12Hjq93momg==
X-Received: by 2002:a05:622a:1a20:b0:3e3:9041:3f6e with SMTP id f32-20020a05622a1a2000b003e390413f6emr37690805qtb.7.1680161323370;
        Thu, 30 Mar 2023 00:28:43 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.126.233])
        by smtp.gmail.com with ESMTPSA id 142-20020a370494000000b007468cc74c77sm13283110qke.4.2023.03.30.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 00:28:43 -0700 (PDT)
Message-ID: <64253a2b.370a0220.d821d.8260@mx.google.com>
Date:   Thu, 30 Mar 2023 00:28:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7085873841011236885=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [BlueZ,v5,1/2] vhci: Add support to trigger devcoredump and read the dump file
In-Reply-To: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
References: <20230329230734.BlueZ.v5.1.I21ac5a143b0e42eef4ff71ef04ef0e53a294932a@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7085873841011236885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735224

---Test result---

Test Summary:
CheckPatch                    PASS      1.21 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      27.03 seconds
BluezMake                     PASS      875.35 seconds
MakeCheck                     PASS      11.64 seconds
MakeDistcheck                 PASS      150.61 seconds
CheckValgrind                 PASS      247.98 seconds
CheckSmatch                   PASS      333.21 seconds
bluezmakeextell               PASS      98.98 seconds
IncrementalBuild              PASS      1423.83 seconds
ScanBuild                     PASS      1017.98 seconds



---
Regards,
Linux Bluetooth


--===============7085873841011236885==--
