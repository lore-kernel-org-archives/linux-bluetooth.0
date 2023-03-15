Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69804C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjCOSwZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjCOSwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 14:52:24 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB07C4A1E6
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 11:52:18 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bj30so14889928oib.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 11:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678906338;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zmlVqReVTsAY4V85/UOGB87+FxoDhF2fwcGEIC4dKIs=;
        b=NEutkK+56Gq5nf6UFTHCdnoRSAn7C4cq6T12lIRO6CXeJmUtU1H58nHRsVrSY5aYun
         vx32lN1tC3JecxlKZzEFXPa5glf52jHYr91pllZ04/zKQdtvsRrZPZ54YWZhHpGDDn6g
         N1bo4dQR/Dw6NNlyrt691uo/aoqDzFpJG4mOuMi6o/Bl6lKhrOOmnFrJ1XIlQVQptT3e
         K1WdqVNRr7nbhl7SU5rNs93yGtZEiWH1dlGrwnsYNWUuqLA1OIQ3ysSBktYXP7+95mIa
         mne7BRFPzZn2ISEmo7TPdK0aYUOvRBRoP44HKbDZ8opq8AaF4qfDkY6x4dR33xnBjPYK
         fbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678906338;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmlVqReVTsAY4V85/UOGB87+FxoDhF2fwcGEIC4dKIs=;
        b=7uj/KJhpP+klSb2hlXxk3vdX6n988/8QN9NK6ifDkCl4xnJxmenuO9azHkDNT6jr52
         wwt4bhcUd/ICKF2F26/9UU3SVJNBvDL/WTa5OFUoy4zvrpoO4aXRVyyGDBE+iWh5rF8N
         0WnvCd0ufaPDx1x1tDwo2j7YcQ/Qi4Q6P6heCpe6QM6lpf+8STel3tVsOZR9QHQaKqP9
         g+6OtRFGj4XoKFr6qRy9U0O6gb4ebnIFJsJwPBIhtAaGc1ZYCz/y0FNoVEeIfoX0jOtZ
         J5XNs9O5y19LxAGcRm8VdqQONBMv66fLBnn+eYT4vaN8MUGT3vkaDCgiwylVR+Eujvy5
         FvpA==
X-Gm-Message-State: AO0yUKX0/iFJ0Vpo4cDEMXgd0Jtr5vAONmodygMe/qC0R6cKN48TwuSy
        Y2jqqDLdCfiyNO0iWAo3GpMVVIhULhg=
X-Google-Smtp-Source: AK7set8T2UEEDjhPT4PdGljMzKWzaBjc2jULlMqAVZCW1mR/7J9ziku7KMhzIuSt3LBv7NVbkpBxHg==
X-Received: by 2002:aca:d03:0:b0:384:1c31:d0e3 with SMTP id 3-20020aca0d03000000b003841c31d0e3mr1515601oin.43.1678906338100;
        Wed, 15 Mar 2023 11:52:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.43])
        by smtp.gmail.com with ESMTPSA id e29-20020a9d491d000000b0069b193c5d7esm639838otf.38.2023.03.15.11.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:52:17 -0700 (PDT)
Message-ID: <641213e1.9d0a0220.aaaac.3534@mx.google.com>
Date:   Wed, 15 Mar 2023 11:52:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1646917210902726393=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com
Subject: RE: [BlueZ,1/2] mesh: Filter originated Provisioning Data packets
In-Reply-To: <20230315172610.13796-1-brian.gix@gmail.com>
References: <20230315172610.13796-1-brian.gix@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1646917210902726393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=730438

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.62 seconds
BuildEll                      PASS      28.26 seconds
BluezMake                     PASS      913.57 seconds
MakeCheck                     PASS      12.44 seconds
MakeDistcheck                 PASS      158.01 seconds
CheckValgrind                 PASS      262.77 seconds
CheckSmatch                   WARNING   349.89 seconds
bluezmakeextell               PASS      105.25 seconds
IncrementalBuild              PASS      1503.12 seconds
ScanBuild                     PASS      1072.16 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/mesh-io-mgmt.c:537:67: warning: Variable length array is used.mesh/mesh-io-mgmt.c:537:67: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============1646917210902726393==--
