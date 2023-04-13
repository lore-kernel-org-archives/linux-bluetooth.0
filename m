Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74CFC77B6E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Apr 2023 22:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDMWSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Apr 2023 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDMWR7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Apr 2023 18:17:59 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E5101
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 15:17:58 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t23so2537803oiw.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Apr 2023 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681424277; x=1684016277;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x8+k/CurHp99f1lI5aO1umTbMaDXm12623MZUB4YD2M=;
        b=YpqpjRTwuaomFGH6JJH05/HmV0o1QE7yYQb+YwsxUNP8JZJcJMicctyuB+KkmK1M4a
         V5w0S/QNyWAe2Z82rqNypPyt2WPl0a/oJyqO1/tQZgRyJhmhsmE0K4W3GQmigVw7mlcB
         fg/0hn/NYNfnSemsHRi2TUuWQxPsE1ainqLwvGCuFCdxg8mCq/QCRXvllmrrJDXCPkbD
         RD4iXuDCE0mBBjR/imiWzJuQJ4nN382rya9rWo5NPn/xiilWlMDKyFwzw0VNZf3CqRAM
         2uyAruQ+p4N4mKpbkPRR+O81QKAs0qtLbiT8ERrgDkxrZd9gqaMyD6Z1XT/jl5Sld3HL
         aSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424277; x=1684016277;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8+k/CurHp99f1lI5aO1umTbMaDXm12623MZUB4YD2M=;
        b=P/1UkKv7eBVFUMwxap1rFM4cTK1z/SZhx6DWwpvrQeQhNJUij6Qlk9wdWJxwUfLFQ6
         RkdEu0lIA/LAoviqnn5Fg81ACZoyrpQnKtwk76IUSlyHIWjUFzeh0TRdQX+zQtyQl9oM
         YNqzkQDf1ivMVmJtpPbQ1u5JoSFrjNFqKPmPY9YbS30kissZrpBCH1foimaXQhHrdLAR
         n9tlQZ8M+8zxrVrw5m07frSlBESG4i57yjH7NXG/MW0inVmyeLuJLD8z127wwtrDG2UY
         Kg9Lihktp6FpneGFaQeU4NS9wSMvkEKkBGUcJYXeuHuMXqUmFDfX7/0HZVS+3ybfDZvM
         wVgQ==
X-Gm-Message-State: AAQBX9cLXizzYJnBNXH3xdaFRjpLm7rvO+kutmesJu0EHwxFkBoRtA0A
        SqR92o3MA831TPRDOqY5tNj9wzPVU1s=
X-Google-Smtp-Source: AKy350YJGlnKUYX6ejiDeHcmHFZ99CZ0HTo04KuOoyXaemckvsPdLlXjiCPbg5iyrfgKxpJBCMuYHA==
X-Received: by 2002:aca:1c0e:0:b0:38c:1670:79e9 with SMTP id c14-20020aca1c0e000000b0038c167079e9mr1922651oic.45.1681424275679;
        Thu, 13 Apr 2023 15:17:55 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.141.233])
        by smtp.gmail.com with ESMTPSA id y15-20020a544d8f000000b0037841fb9a65sm1117471oix.5.2023.04.13.15.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 15:17:55 -0700 (PDT)
Message-ID: <64387f93.540a0220.3f570.7130@mx.google.com>
Date:   Thu, 13 Apr 2023 15:17:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7598807360968079965=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] btdev: Fix not setting CIS parameters properly
In-Reply-To: <20230413210450.961897-1-luiz.dentz@gmail.com>
References: <20230413210450.961897-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7598807360968079965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=739615

---Test result---

Test Summary:
CheckPatch                    PASS      1.02 seconds
GitLint                       PASS      0.56 seconds
BuildEll                      PASS      26.49 seconds
BluezMake                     PASS      780.21 seconds
MakeCheck                     PASS      10.85 seconds
MakeDistcheck                 PASS      152.34 seconds
CheckValgrind                 PASS      243.86 seconds
CheckSmatch                   WARNING   328.29 seconds
bluezmakeextell               PASS      98.58 seconds
IncrementalBuild              PASS      1256.93 seconds
ScanBuild                     PASS      1005.44 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/btdev.c:412:29: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============7598807360968079965==--
