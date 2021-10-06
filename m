Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA65CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC52560F12
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 20:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbhJFUi1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 16:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhJFUi0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 16:38:26 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E5C061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 13:36:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id p4so3925896qki.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 13:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=rmuctVnp4Z0sVYr3m/4SHpu4lwiuW66pyjA72FfpniM=;
        b=q3+XkZZW5evzo53vHXMEU03xg63icdpaWCKP55CnJEihKYVfzuKUVtfsPwF5BLbtjV
         7MJL//PKC4VHozgkcC6jgP10jg+vSfL/iDPNt5VI3BNQcnY3I+J3Y3A/amAvWozpJzkN
         wa7+xZOIzQkh1397ht7MOFdSoyN4P6lkdkCspDMpVdS7UMyPZQjmGgBZSF7pek4k2tKm
         LuUjzdRnAoEOzocFVM9te280I2O7A8gCB3lFKIG9xCeOTmYVndM4MEHgzSnpDOPPyYlQ
         aQ/pp754ZwqaBf7zgCrmfxbH0hpgCsU7kC0rQ4i5O+xY6LT6t0xJt3vWlsRA/vZ4VSIT
         jMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=rmuctVnp4Z0sVYr3m/4SHpu4lwiuW66pyjA72FfpniM=;
        b=6lgpoA2s3uM3lnqw6EqY3LYFxVOAZFUBKeLFzWI/RwOi/mT/2eKqQWx9GC61CvI/HV
         lNX0msakFgm5/Cl2LFTSMioF+K6tOpMCiiba0a+SJ8e05lZ/taEawYOXfUXI+yerRCUZ
         pRb4LiyE3QaOJgoIITlHiAvU7OLDf/W+4nrkqroP1exRggFjy0rVEUXw/9tLTCn1GiOt
         AX/OlHYG9t+e6AQJ5o9dIGa5EuUQGwUTkIwqanbbT5f7Zvqmg5ISQ80iOVBEuKe6ol69
         AS1yMtArj9n6k5wTj+qD0wz999lnu2fUI2A4D0c1BQG5JF+My0u+fiOXBkijCXX/OMLe
         COpg==
X-Gm-Message-State: AOAM532lJnwCnrW1xdWa+b8ijXKB0cqK6HVdq+diw1FJ3k8OlJpofMFa
        xb1UgNlJBak17sMffL/02GnmDP3PFvI3YA==
X-Google-Smtp-Source: ABdhPJz03XAXJgt9mR2si66M82Kb2x6oCLJm7tCRm0xWcxKNuoQOV2cDlfWTevnfPV2AcD7HWxDPVg==
X-Received: by 2002:a37:bcc4:: with SMTP id m187mr240066qkf.192.1633552593108;
        Wed, 06 Oct 2021 13:36:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.119.155])
        by smtp.gmail.com with ESMTPSA id x6sm13167097qts.79.2021.10.06.13.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 13:36:32 -0700 (PDT)
Message-ID: <615e08d0.1c69fb81.c7a41.c15d@mx.google.com>
Date:   Wed, 06 Oct 2021 13:36:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3635373424452603752=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,1/3] doc/tester-config: Enable Runtime Debugging Feature
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20211006201300.186055-1-hj.tedd.an@gmail.com>
References: <20211006201300.186055-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3635373424452603752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=558775

---Test result---

Test Summary:
CheckPatch                    PASS      4.20 seconds
GitLint                       PASS      2.80 seconds
Prep - Setup ELL              PASS      43.71 seconds
Build - Prep                  PASS      0.49 seconds
Build - Configure             PASS      7.98 seconds
Build - Make                  PASS      184.67 seconds
Make Check                    PASS      9.53 seconds
Make Distcheck                PASS      224.44 seconds
Build w/ext ELL - Configure   PASS      8.74 seconds
Build w/ext ELL - Make        PASS      184.53 seconds



---
Regards,
Linux Bluetooth


--===============3635373424452603752==--
