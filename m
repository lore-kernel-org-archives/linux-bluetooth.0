Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C4E776E9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 01:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjJCBvA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Oct 2023 21:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJCBu7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Oct 2023 21:50:59 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD2C4
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Oct 2023 18:50:56 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-352697d8cb0so1368705ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Oct 2023 18:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696297855; x=1696902655; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cldaNHO7IIjBejfhD5lWyF7/3PfuIGO+69AMwVSNNeY=;
        b=Ekdmhw+JQ3pMEuv4n5OvSd3qQAc5SQThis505jQdOJ3XUrRp01bNCEOB52F21w8U+I
         j0SXV2uSRVWVyWGGkOGGVShe6W+0C7b7lPPMru14viXJcZa+QoJ84y5vCVfQ4U5qy74+
         jr2actzIcaUnoFPhCP2TgoR6kFjDK+o3HqmDAnqtuW9je+ePY5AklLFRp9urzxthhtbh
         Oe7ym7q1zF5mlgCZTsjN4EHNDR7EulRrvlEbEevU4k+GkvU0cmexPG6cg9ft4g3Fw2MX
         AYcHSECeUBrmWftS5tffTEdS0KG96K1LXtmkmTjWpPF9KbqYgPu8yGFXqDV90mYkJF4J
         Ye2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696297855; x=1696902655;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cldaNHO7IIjBejfhD5lWyF7/3PfuIGO+69AMwVSNNeY=;
        b=KHhKtAjHcVY7ui0lEVyr9a10/T5w7QlDBnamma82w3y30coD8dT1ubXozxqyTbY1Av
         xy/mveYUvGwaXmUggKPxUNGpdbDwKQlpmc4hYMyvYXitz/YTHizFh8RFfr+yzMTXGWMS
         x/1yioPeGrknWEqlBFazhd+i6s5CJKSthSN9YnQDf7SfpVP/bHGFFUB0sChx8wHKF3y+
         ZHG4QPBECr+LFmqR32ez7Wyz/KKJWKV5rM/GvTvo0smtzpiWD8KPQzR9m1TAl3dCuOPO
         ekqSRVslftMQ9lBIHY0mong1Clmm/9Nsth6fv1Tr5uaMbqb+qgBYUilkceRnnLGKhEyj
         zyjQ==
X-Gm-Message-State: AOJu0Yx+DWz6YYOfMAoo262fnQsKfy9uEaPHOHggO/164RYNzb+uP8iX
        sLYRgeQBsENKjgxI0gJfliH2QQHqOPk=
X-Google-Smtp-Source: AGHT+IHPfFK/21U8Kf4k0Ww6/UCMcMXpnoN4thAJAnBKIHNsuQcsR1idtONcAueK+f5cPgncpUvIEw==
X-Received: by 2002:a05:6e02:1809:b0:351:3769:10a5 with SMTP id a9-20020a056e02180900b00351376910a5mr16493871ilv.29.1696297855316;
        Mon, 02 Oct 2023 18:50:55 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.51.11])
        by smtp.gmail.com with ESMTPSA id s3-20020a02cc83000000b0043a11ec651asm63332jap.169.2023.10.02.18.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:50:54 -0700 (PDT)
Message-ID: <651b737e.020a0220.baf30.00ef@mx.google.com>
Date:   Mon, 02 Oct 2023 18:50:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7764908950511623298=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/6] shared/csip: Fix returning invalid data to attribute Size reads
In-Reply-To: <20231002231311.3104749-1-luiz.dentz@gmail.com>
References: <20231002231311.3104749-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7764908950511623298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789421

---Test result---

Test Summary:
CheckPatch                    PASS      2.70 seconds
GitLint                       PASS      7.02 seconds
BuildEll                      PASS      28.76 seconds
BluezMake                     PASS      979.14 seconds
MakeCheck                     PASS      12.63 seconds
MakeDistcheck                 PASS      163.32 seconds
CheckValgrind                 PASS      264.15 seconds
CheckSmatch                   PASS      356.79 seconds
bluezmakeextell               PASS      109.03 seconds
IncrementalBuild              PASS      4989.81 seconds
ScanBuild                     PASS      1092.62 seconds



---
Regards,
Linux Bluetooth


--===============7764908950511623298==--
