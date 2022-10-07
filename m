Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D1CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 19:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJGT0W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJGT0S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 15:26:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28164925AC
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 12:25:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so8086664pjs.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 12:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NgCHJamyaRgRj+6DJ5MwFFu35aKkX9Xhh+x4eAjogzs=;
        b=EgDfkpezx/+ATmx0WDZlQ4WNAsv92n6ydV//MZLSLfc8IfwJa/t+OuyKSDLHMtzYV7
         vyNA+tPmFAFopHfQ5sSlV0sYtfx4DolgjCH/SrpyWFfEQoh5BCyytsvZ+w26E3Rfn5E1
         llTAkG55CskqqfGbhBxBYeXN7UpblLzDGIiUb7mJ/NTHix9gVhm/6zSIz+jzYesRBAs5
         ZtegvR5+Rg2JTsXMno5JOoXFku8X0ElNehM353ctAArgOHMlPWhuESyFCM5NEKdDf+wE
         90kdMlmnZEC1yLE6cHCj+oIMlU/x4540JnfSfqhdHWIjKyMIJd2qWuYMvROW9Akx57Rs
         1pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgCHJamyaRgRj+6DJ5MwFFu35aKkX9Xhh+x4eAjogzs=;
        b=B6zKbNZApKAAEKWoKfwwSx2xLKKqsvhQDamXB83AN00xcg37h2W1wrIOWlcwSxuujk
         lHTa1jfNq5nnb3/SpZTqTr84lTdtlKvY83GEbjw2oB9MVJQlTlAwq7QFeRbdHGCOxX6n
         vUNgG9scjjhaQNBlkJFjKNsLiUL2I9u4I7dK99wnfN7OmiX9CnCDxbGT9OMTaoQWRGs+
         zsbBeE4dSmx2LEFHJzO2IGP3xW/qZajIx1gG14Holvi93xMjN+ZBMZfCTDRn8Dx5AFmc
         tn9yKEI9taZgEMy+6BGMD20t5MaIt1CA4X6CB1eyapAj6R1PVR4lKUdtTH8Vf9iBT+QK
         9chg==
X-Gm-Message-State: ACrzQf3HGp5vRToV7Msz3gQxjJV47IfKBgWxlucXOiaw/PvV3EzvxqYr
        dBjnw3rGN2jPK5HKpyYup24qYa9IOVVe4g==
X-Google-Smtp-Source: AMsMyM5LNsT8VLXi1l9s2ceqRCOHiWjnUAtp2lOz3OqAjG9wHih9DjCelAAa0ldTPaRSIKCcqLe4Lw==
X-Received: by 2002:a17:902:ea0b:b0:178:336f:eaec with SMTP id s11-20020a170902ea0b00b00178336feaecmr6370863plg.53.1665170753145;
        Fri, 07 Oct 2022 12:25:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.126.144])
        by smtp.gmail.com with ESMTPSA id b140-20020a621b92000000b0053b0d88220csm1960159pfb.3.2022.10.07.12.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:25:52 -0700 (PDT)
Message-ID: <63407d40.620a0220.722ff.3a02@mx.google.com>
Date:   Fri, 07 Oct 2022 12:25:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1473172437329579554=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: [BlueZ,v2,1/1] shared/bap: Fixing memory overwrite during ASE Enable Operation
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221007174516.22335-3-abhay.maheshbhai.maheta@intel.com>
References: <20221007174516.22335-3-abhay.maheshbhai.maheta@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1473172437329579554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683769

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.48 seconds
Prep - Setup ELL              PASS      31.74 seconds
Build - Prep                  PASS      0.80 seconds
Build - Configure             PASS      9.83 seconds
Build - Make                  PASS      1073.29 seconds
Make Check                    PASS      12.13 seconds
Make Check w/Valgrind         PASS      339.06 seconds
Make Distcheck                PASS      278.58 seconds
Build w/ext ELL - Configure   PASS      10.05 seconds
Build w/ext ELL - Make        PASS      102.59 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      681.59 seconds



---
Regards,
Linux Bluetooth


--===============1473172437329579554==--
