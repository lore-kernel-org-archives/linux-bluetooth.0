Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEDEC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 10:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbiFHKF0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiFHKDZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 06:03:25 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522121737FB
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 02:46:35 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id hh4so14481489qtb.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jun 2022 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=hCC/K15B3BxiVKx0t44OnW5HtB3eT8gKl8nuHOvF+5Y=;
        b=ZMV7FBiku+NldiDPYAdsop8Ywm3hob5X6a6BebDybUgQmkKKi1EtKePiq8k01sDhhu
         ZBJ+ifDf3sNycnIsj9IVStg+uNoSlsIU3etXtdRwX8YmW41QX59ddGGO8INthn4RjwVo
         HjLmffgaIR+qiO3tUxuNHVwHWaa10/J8JP9kQZI6saAaFX6yokDYnna8AuuPCHXZKLVO
         /rYn4M8HPX0fCB+NhQf0tRbGirWuLDTK84DTYigZp12NBzzenrmEzIYuvbuhZG64WOPJ
         ZtgrmrvRBZDmrZ8lXCUPxCOM2g/rS9InKZ3YcXrlcrDOYuvs/1ebkaS9snqtFZ8zCDWY
         6L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=hCC/K15B3BxiVKx0t44OnW5HtB3eT8gKl8nuHOvF+5Y=;
        b=YfJ/8KJclCiSMEnyROOunFuXa+C+AjiA0ITl5XkRaFrhGPcVkYFdFPtdlA4FtxaRGP
         Xk9eliijMpiz7yk2DLvcpr8ko2wFUIxPj6RtgisQbEOuO3j2ixDSBHuOhEOAe2ia+631
         0U/5YqElCA6YibGQMMxhpg/Aj5RIH84PaECXAyj6YfpSEN+sGBHVyrOwEJxaE3gxQgTh
         m8HbFOoEpFNV8tOtzuuviLuBcUetxvxfTPX3hM6EqSA2RkIcAOC0yxjpekObQ0aa7CQn
         63MkfxgS1SQj4dHBsGY+FRXD72S+cOU+3EZarqHzg2veCiQyxhS5qKdTzY82NO0As2Nm
         8Zrw==
X-Gm-Message-State: AOAM530W0u7CWLy85pR0gVabIcUjXOQ8BoFXcEW9NVBlIwNpKc38ynQL
        SMFtmysAmW7gggJ4QKFh1mmKnTVDJe8=
X-Google-Smtp-Source: ABdhPJyr1hqG951LI4XFUIervDs5uYIvAv1+KNLD3GqYDjkJvSZg2IdSayxz/loQU6q7GANZ+qaZ0A==
X-Received: by 2002:ac8:5702:0:b0:304:f767:a72d with SMTP id 2-20020ac85702000000b00304f767a72dmr6716918qtw.579.1654681594063;
        Wed, 08 Jun 2022 02:46:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.23.59])
        by smtp.gmail.com with ESMTPSA id br13-20020a05620a460d00b006a6af4b40b1sm9130167qkb.73.2022.06.08.02.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:46:32 -0700 (PDT)
Message-ID: <62a06ff8.1c69fb81.52ba3.b971@mx.google.com>
Date:   Wed, 08 Jun 2022 02:46:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2503054467986553133=="
MIME-Version: 1.0
Subject: RE: [Bug,209745] Bluetooth connection to Logitech MX Master 2S lost after each reboot
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
In-Reply-To: <bug-209745-62941-NhFslXbwwo@https.bugzilla.kernel.org/>
References: <bug-209745-62941-NhFslXbwwo@https.bugzilla.kernel.org/>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2503054467986553133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: git diff header lacks filename information when removing 1 leading pathname component (line 21)
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2503054467986553133==--
