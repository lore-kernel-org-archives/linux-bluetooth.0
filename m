Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F4C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiHVW1z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiHVW1y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:27:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFE940BEB
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:27:54 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 12so10668284pga.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=wl/eoyqwJrYswHfasGffVmbVpHOzDDqpKIcXHlC9ar0=;
        b=jhIIuXj11Zl+Q98SgTJazU4/EDaKIjBLlUc7qtedkSqUYwCd+niWrOFIgIrkix15Jv
         YXGzhOzLFlLaYqp8VPJ6FWaQQ15jy93f3xc70J87ab1zqorN17rrLyjl2LCWpByWebmx
         hxgAcZdHHIkAvaDh45IPu0LYNvwqyHyT2HlnjBCA202MQH+SHH1S6/6fU0hj50jSeq91
         838a2OFrG8cT5to+IvQjzLEGiZRhmg3l0e+Z8ovR1kcVnhmhsuehzZDmqLfjWF+ZLyHf
         SVuij/8Zm3KzNzfszkDUIUc4kaCrHAO54YEe92+ibnSuufdLTcWNRqxbXFHs88f7NczK
         ZocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=wl/eoyqwJrYswHfasGffVmbVpHOzDDqpKIcXHlC9ar0=;
        b=vW+lemEXIgBeE8kbcNErGZcU40wqwxMVfM/ULqcQ92OCHi5asa36BHNgOTEEhCcXLJ
         y5nKGSntaAS702c3i0Q4R7O5R/KHd4TOCOxNXBfvXPsGAjg3trKv+o6rgtS9qKKP4KQj
         UWoO6KO5goVRN5LN77BcAv+FLrfysauNVxkhbP0Ene2/bF7kQN3YQffpDHw6pHM6z4Ev
         87r1IV9CF2OiWrCP7NizC/9ibPTFdvJ1KtVII7RoGXFfVdEv1LFe9ZhSQYYcU+Mv/D9D
         ub8Bm1zWeVilt4DEplSEZjW6MikPj76KDEwg4i5OFQ2AsRKbiLkiyoY2LVMtdVkvlmef
         e1fg==
X-Gm-Message-State: ACgBeo1ms4SEbPYsj6cxamGdbpCk0mLehYPlePEo0UdReeSQCyBI1El2
        3GJH4OHoYocux93dvpcLRKyD/2gRyPs=
X-Google-Smtp-Source: AA6agR4bSaT50Gsu6jGTE4ImgVOxS8FVLfZ1tyR+V6FtqRQZmjuMYAePTcfEZVQ1OK62IWZyMthudA==
X-Received: by 2002:a63:1e5f:0:b0:419:d6bf:b9d7 with SMTP id p31-20020a631e5f000000b00419d6bfb9d7mr18805687pgm.593.1661207273572;
        Mon, 22 Aug 2022 15:27:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.21.25])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090341c100b0016d9b101413sm8900298ple.200.2022.08.22.15.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 15:27:53 -0700 (PDT)
Message-ID: <630402e9.170a0220.63f9c.0570@mx.google.com>
Date:   Mon, 22 Aug 2022 15:27:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1459466613830109478=="
MIME-Version: 1.0
Subject: RE: [BlueZ,1/2] bthost: Add destroy callback to bthost_add_iso_hook
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
In-Reply-To: <20220822220025.541691-1-luiz.dentz@gmail.com>
References: <20220822220025.541691-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1459466613830109478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: tools/iso-tester.c:1167
error: tools/iso-tester.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1459466613830109478==--
