Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33EAC00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 05:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbiHAFDN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 01:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiHAFDL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 01:03:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0412ACE
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Jul 2022 22:03:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f192so137704pfa.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 Jul 2022 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:from:to:cc;
        bh=/ooQACyUALO2wgRFJtTuTLZUs4EPoVTKWLoH8rO75PY=;
        b=QBWj5ox+PC99YAmpv6CDCAoTQnnKQ/Udnhcqs+/40IzjE/dGGq8QppBGTBTtfM++IC
         nFtOjZ0w+y9AUkWdpZslaPmyh+yWln0KYAWd4XC/lD3LgkVy+kDWMWxWLou0UHaoUmfX
         ISO/LGdKkmjIrHrnbRMcmviwq8enFnYXmhl1p2SVVoz6KTcgp0wZ+/9l1e2IAIJwch8z
         qvoAaQ3UfjZ9KpTHbnkjgkYI54iVrigCILM00PXUMdtEAEjllWumt6FPw1wiuvEG04k/
         FYX9gqsuV7QRDwPdX2aVgFeptc0puZPdz3O8M9a58Rf/NNqQDzWSdzmUVzJCXxsZAY/r
         WL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:to:from:reply-to:subject:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=/ooQACyUALO2wgRFJtTuTLZUs4EPoVTKWLoH8rO75PY=;
        b=GxW9vdM+y+dvp9zUr2C7UmN9pivWoClJUsQPRU4iyRPrgAsiHHbuh9+LuQucHHst8x
         aq19t/e/Xs9Jwc3wTWnxvnVTX4sytyF8ubOfsm37DdqGTkcVw8RPmiMm5ph5bYG4S8d0
         iWsiiVKDaXlEwZ05L8qxROn5MxVuVj7CVPWh3GaZ6zlS0szS30kfkBX2iYgzvAJc1xtY
         a0kxS2EhLWV8T0u2vEJ0SEycGcP/DC8CfqltwTiyZj9oEO7SZcfhvgFPXB+8WPBlcGgK
         dGc6cNgDkrc5R9Bnei5xkcfFFcmYPBOAudMUetvh/MJhYkOXrtXrltPF3qvcEPqLU0xA
         Xo9g==
X-Gm-Message-State: AJIora+uo0OCY7wMO0WDsoE/1iPCX/gH0itPc86YP45uSxjlgAHUjxU9
        2uWkP6gbL8Vk9vPB7j0nrvyThzneyoE=
X-Google-Smtp-Source: AA6agR7EPNcCY5ojspVybw5yXgKyyvHxPn6fSTrdamaJCpGNAfViWEkuzLo1czPGBDDOEUQT9gaiTA==
X-Received: by 2002:a05:6a00:414e:b0:52c:d919:985b with SMTP id bv14-20020a056a00414e00b0052cd919985bmr12414696pfb.4.1659330190261;
        Sun, 31 Jul 2022 22:03:10 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.172.52])
        by smtp.gmail.com with ESMTPSA id l126-20020a622584000000b0052c92329115sm7014566pfl.218.2022.07.31.22.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 22:03:09 -0700 (PDT)
Message-ID: <62e75e8d.620a0220.755e1.aabc@mx.google.com>
Date:   Sun, 31 Jul 2022 22:03:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3762772946293114265=="
MIME-Version: 1.0
Subject: RE: Bluetooth: Replace IS_ERR_OR_NULL with IS_ERR
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, shraash@google.com
In-Reply-To: <20220801042918.292541-1-shraash@google.com>
References: <20220801042918.292541-1-shraash@google.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3762772946293114265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: include/net/bluetooth/bluetooth.h:494
error: include/net/bluetooth/bluetooth.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3762772946293114265==--
