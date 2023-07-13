Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033C6EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjGMMYb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 08:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjGMMYa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 08:24:30 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7738B139
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:24:29 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1b078b34df5so546821fac.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689251068; x=1691843068;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hR1W/CdO8R6wIXCaYUjYmD5cRhq1BOwpEuTtJpz16uU=;
        b=e1QmV5n9NXsK7u5ovomaI1+UmhVocywaxX5CuwjCMKobaTgdEz8Zwchjz4qexg69aR
         pqmCg/eeuRDS1bPYXyKzAPXBqp6TK0w5Gzo9dpuJE3dGJ1a1AVHaTOrfk3bSEgpBwAj4
         SczVgMKcY1J1+vgSoQgcE7snvcOnlfLxFnfb93rCymsJQkcuh9CDGerqvk3j2UCsHAAD
         2iUw/Y1pUdRgb28/Ac25Y3GonNwi59/2bjQaWC0BlEQqOmrvzZrPqeyu5Uv2sta2BYjR
         y72VV22oia24kJCNJFZApTdAKI7j/aM0Xvm9tJs7WT0/aMyVa1oCnCGQTLIBsDHoDa3P
         7Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689251068; x=1691843068;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hR1W/CdO8R6wIXCaYUjYmD5cRhq1BOwpEuTtJpz16uU=;
        b=LFrJ4XmOXzLAyYo4CAB1ddh5jEzyA/dbHilsaVQNam4z0bHx50UcotPv3TfeOvAtUo
         EJyzQPoRytHX7dzqw9Y0AXg9T/OsnJG2MNFC+ZUOx9RGyiYkU/0RpfToAJr4MCrsGFc9
         1uKRhtlMEsI9+KMSFY0vN8NJ/WtyajQ0XV8OIi3Q9CCsV6nz8WQReKLDKNdDJ9o0Nq/F
         /mOLLVOLpMIoOaPAgPZ84oNCfyBOtMw33dWbrOy5gt3SOHARzl/vk9ELYDCg4SaTIdm4
         6tZIM/ZIsSsHUc6ONYtXRnV4XRmHQN5uJLHeaGHiLJTTp0r1J6vBRha3OKdtTdX3T1Xb
         uqVw==
X-Gm-Message-State: ABy/qLbXN/3Fr9qIqlNnRrYtBINNmdvp/vqtdNRx716tgzwvwjnGvyMY
        FPYkbtOWXCXjPjHQCMwY7kSBfLvWinQ=
X-Google-Smtp-Source: APBJJlGOqsm+BRG0c9+wsmEWPYoJAAR5tiPS3DSutv8ion+FMBZppX3JbQp9M69hG/Koa7zlUeJgcw==
X-Received: by 2002:a05:6870:c1c5:b0:1ba:199a:984a with SMTP id i5-20020a056870c1c500b001ba199a984amr708493oad.55.1689251068553;
        Thu, 13 Jul 2023 05:24:28 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.140.53])
        by smtp.gmail.com with ESMTPSA id eb46-20020a056870a8ae00b001b03e0c0970sm3003234oab.2.2023.07.13.05.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 05:24:28 -0700 (PDT)
Message-ID: <64afecfc.050a0220.f7d9d.401a@mx.google.com>
Date:   Thu, 13 Jul 2023 05:24:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0862077602091538413=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,217651] BCM20702B0 Bluetooth device in MacBook no longer working
In-Reply-To: <bug-217651-62941-kV6141GIe9@https.bugzilla.kernel.org/>
References: <bug-217651-62941-kV6141GIe9@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0862077602091538413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4103
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0862077602091538413==--
