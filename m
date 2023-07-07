Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24C9EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 00:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGGAhl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 20:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGGAhk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 20:37:40 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367621FED
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 17:37:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a37909a64eso1150066b6e.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jul 2023 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688690252; x=1691282252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ssnGxmGPvo32AeHKEROSdVGYuS0OxoSddimN8JRriHs=;
        b=Dwkgz6L6E4i48eavAMtuGEEYlxHd11cY89eF1X89exrwfbq8N1btAro59kULGnCilM
         C6rCKVnQpp2cbGBmNq9AEC6LqgWiCJjs4jXt/SvymSt1L+EaHh/s9GVXF7iNjc5Uf5x9
         14rCqqW114vllxNNnQUIATa9khwnNS4Xg81g3w6MKMGn1BHbn6+vSamCRNHl9PsSGCAo
         COmBIhWXHPS8387Hhuf4tDBiKqUp+9UfKsGRnLoIgd3zkbH4JEbFIXEKw0U3BqkkWhid
         UrJ0ku+4qLb1ricCegDSH8nwB81SkTDNKD9UNOQch0OJCBCkgxx7ohGb4ULfA0u9zrEU
         1ELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688690252; x=1691282252;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssnGxmGPvo32AeHKEROSdVGYuS0OxoSddimN8JRriHs=;
        b=fVFMIOqSW9V+A5Wxhl/4glu5MdUZANgTf2zN9x9cte6WIEqxtkoKx7xex3r/dE9VR4
         VFa4UQDRl3zmWvMSGSRD0YVGK/nUpsPeu2IRJLsfX2eSUNqWVZgiHSGqfZBjS5UPRzJL
         7X++hXK8uG6fcn/y4F+6nD4eBOAGpPJO/2Oblx5yyzZntTNd0kjfweLZRiH6NKnPa8x7
         a/4Hc2ah6pnojOYFDTq41eo7AGvDIhtYAkrl7AWeQB+Wpa6XFqwS4PYLngLhm0FTcPJw
         VcNKdDfs2uUdBbV7NTdjQPmSmT5DCG9aTkk6/OhJB5p47K7P/n/mVe4TRxVSlANtbGE9
         GUOw==
X-Gm-Message-State: ABy/qLZMPcCeW8axd3rqV8bWX1pNncXOjQrF6oiOy8FvRpVWIhE1LIxm
        oIBHv4CNniIu4H5HDM5OnAjzZh8yBY4=
X-Google-Smtp-Source: APBJJlHOEjVwwknXPfyqFFkkWyy+xTEWcwXmo+1fGGVL4DStFsAJ/2Yttx09oYR+SpSXumSWwommww==
X-Received: by 2002:a05:6808:1598:b0:3a0:3161:ee2f with SMTP id t24-20020a056808159800b003a03161ee2fmr3607238oiw.57.1688690251914;
        Thu, 06 Jul 2023 17:37:31 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.99.48])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78114000000b00682562b1549sm1797776pfi.24.2023.07.06.17.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 17:37:31 -0700 (PDT)
Message-ID: <64a75e4b.a70a0220.614a0.3fa2@mx.google.com>
Date:   Thu, 06 Jul 2023 17:37:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0023505492421661649=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] test-runner: Add documentation
In-Reply-To: <20230706231000.451145-1-luiz.dentz@gmail.com>
References: <20230706231000.451145-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0023505492421661649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763265

---Test result---

Test Summary:
CheckPatch                    PASS      0.35 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      32.81 seconds
BluezMake                     PASS      1206.36 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      199.60 seconds
CheckValgrind                 PASS      325.36 seconds
CheckSmatch                   PASS      453.07 seconds
bluezmakeextell               PASS      135.38 seconds
IncrementalBuild              PASS      1069.81 seconds
ScanBuild                     PASS      1433.81 seconds



---
Regards,
Linux Bluetooth


--===============0023505492421661649==--
