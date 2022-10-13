Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CCDC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Oct 2022 21:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJMVyK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJMVyI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Oct 2022 17:54:08 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5BB80F48
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 14:54:00 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mg6so2148613qvb.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Oct 2022 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gV1K/kBUWIbGz4a0PSxX6hKkM5Hl43giYfiNBo8QIeA=;
        b=iDUajBP2s46qFvG+P6NYihIqMPeey6KJpS/ZrmBwDNVifiHZCg1NW0fum6zUa58qLa
         tOH5ewGBVsvMdqKdfHLqIvP9ugRMuaiwgsDLGHPwX+HW1lMmGkTk5y/146o64qiTXf07
         Rfq6roXpO6gdVNMzOxphVzs2TRUSWDK/5w3var/CrOiKZgqIk9fZhvACor3oP3lpV+SS
         naAuW2EyxDRLFy5ZdRBuPVOh2tm5xngyHf9vvt8rKg7lWagzKEO+Z7TUOpHeGwskBhXS
         bctGzhW/HCe3CyJg962o7QCo6TmCPilloL1jUvhOjWfxfI3Gb3H9D+t2nWXSFrrQMSBU
         nacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gV1K/kBUWIbGz4a0PSxX6hKkM5Hl43giYfiNBo8QIeA=;
        b=fT1yXY4gcjTILIm7xK42cb+L2GWDvN7j9TNF1IcV4gO5uq0i2LYaErbq5V551Jmzcc
         p0L8IasWEWKUrUnrjhTQdZdrfBh9eGXUaeiF7y2mgdhTDV8luKp1p7olLmLGF+zL8Nev
         3iXnvVcQ9w79J8I3dlELdIC2izG1pR76aLZvjZMQ1SgOsh3bLWe3lyk5bH9+TlQZPZL8
         uJZsD0DI+lDEeFL+zmUxbTU56kG5ZqDQaBgVV07GTaf7yLOQeRujEKLb1m7vP7RSjWEU
         PkJTsECgiizPeUqfle+wv61dh0kt8SCwpr7IhEhtX9sKP0gyWm1vw0MBUgt6MqF42BMV
         Vsgg==
X-Gm-Message-State: ACrzQf1iTdWrqzBbm5McRVgKvVWtMDjuODuFmIYH8plStlQsXsaxPuAZ
        /Vp+M9kwcqUeIwmiwFvvgZYrHRZq+PWSqQ==
X-Google-Smtp-Source: AMsMyM439eu3lnbL9EH1rXvH4T2vOgH7GC78b//Xf86ZaLfDOfVSCCSjMI+ha2qewb400/LX1h0QWg==
X-Received: by 2002:ad4:5c4c:0:b0:4b1:b8f0:6455 with SMTP id a12-20020ad45c4c000000b004b1b8f06455mr1569111qva.27.1665697961509;
        Thu, 13 Oct 2022 14:52:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.65.98.121])
        by smtp.gmail.com with ESMTPSA id a25-20020ac84d99000000b0039a9b55b829sm769768qtw.29.2022.10.13.14.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:52:41 -0700 (PDT)
Message-ID: <634888a9.c80a0220.ffc42.35b6@mx.google.com>
Date:   Thu, 13 Oct 2022 14:52:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6231825547499785240=="
MIME-Version: 1.0
Subject: RE: [Bug,216580] Jabra Elite 75t (ear buds):Unable to connect and use (`hci0: Opcode 0x 401 failed: -16`)
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
In-Reply-To: <bug-216580-62941-7qZVrHoZim@https.bugzilla.kernel.org/>
References: <bug-216580-62941-7qZVrHoZim@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6231825547499785240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: corrupt patch at line 14
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6231825547499785240==--
