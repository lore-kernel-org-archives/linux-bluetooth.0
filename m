Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66632C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 02:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240788AbiKRCbH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240477AbiKRCbG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 21:31:06 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB00554F9
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:31:05 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d192so3636939pfd.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ydnUwuipHwFSKdFDCTjQPkBqEpaFVDv0pMR6iOg5Txg=;
        b=Oz/0jONjhj10WZrWLLzpvPl0rmufSGQvPly874RZTTSkmT1qJZI3y6GLUht00JAVBn
         +LMyNqev4GS5UJ0JxmHSrlHieuqkW2OP7/ie3OQ8Qavmc3G+sHugkDmr9T7UY3Grc+G8
         mPipcHCFtUmHVvtL8v20VfngBPvo04HcJZxtjDJh9d5+4o6yvioEoAJl00TzendYpSIe
         hgu15MnBBdAvCj8aOZjftoCMfWCovPkY5Ghp9ZpdKUsNQdMzhWOcM+eq0W73oydUWSoZ
         MJlPSeerCRi+6t4ItVFk2TkHnmJiE79AlQKKNBFOUKC95MzYYAwTpH3hijoAoEA28IJb
         MC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydnUwuipHwFSKdFDCTjQPkBqEpaFVDv0pMR6iOg5Txg=;
        b=aXOOlbGfNmDA22A+Gb58t1JYchLPisY9zNzaE/PvhfvIGRvhrmx9tipkfQiMH9hRn+
         Ka9qPA5zMY2QRT6PRE6w4uEtFf9jCOf4RpKdLLWdLg0nbv5N7u29VicFl1+ebyiV4Ur/
         1DIOoVVc1gnCkPT+yPazTjen6DYbLjG85OswoyQwPEtUieXi/cImrcpQbhiMmk4SbZsk
         lz5HPPgoa4Y9+c+fR/w4uvgxvIiPX7/g7IzHSzxI/XvE7nrl7X0rvXRcg2/XXaoBknc6
         vPDzF7zofG0VlAuWWeF4Lms3ux72GeGXJ7e7p3EsIBi0bLx6NG5wYx2ojUrfpv39yvNC
         YpHg==
X-Gm-Message-State: ANoB5pkSWZRK3dp9YPqNG7Qdy/Z5KTpjBXwRkHf3d199Uo4a5kdOoZut
        qEGlOyEaiQ8/D5ReiS+Fe3q7pr0+raI=
X-Google-Smtp-Source: AA0mqf5EA6DY5/AFLTplBxcE488JNK7pZDGSNVfSavs6oXf4W95j8kbafavE5gG7ishzUbexfgn97Q==
X-Received: by 2002:a05:6a02:117:b0:477:55c:847c with SMTP id bg23-20020a056a02011700b00477055c847cmr4738643pgb.224.1668738664956;
        Thu, 17 Nov 2022 18:31:04 -0800 (PST)
Received: from [172.17.0.2] ([168.61.71.27])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d2c100b00186727e5f5csm2134266plc.248.2022.11.17.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:31:04 -0800 (PST)
Message-ID: <6376ee68.170a0220.f2337.38d0@mx.google.com>
Date:   Thu, 17 Nov 2022 18:31:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7313392640704869779=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7313392640704869779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      33.32 seconds
BluezMake                     PASS      1103.76 seconds
MakeCheck                     PASS      12.30 seconds
MakeDistcheck                 PASS      185.86 seconds
CheckValgrind                 PASS      302.99 seconds
bluezmakeextell               PASS      119.25 seconds
IncrementalBuild              PASS      919.62 seconds
ScanBuild                     PASS      1341.21 seconds



---
Regards,
Linux Bluetooth


--===============7313392640704869779==--
