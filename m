Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CBCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 13:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbiEMNur (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382485AbiEMNsi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 09:48:38 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A19FD3C
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 06:48:37 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id hh4so6809438qtb.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 06:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LSlZipp+0AE0zGb3icKCc1YkuSTgVLSHy2KGqRk6I4Y=;
        b=oz2ehdPAUMrdhTlZzXCqOiGsYkm6PLehtfQP/pXpPWiCxbnA1uvbK0hOTPUhAPofM3
         UtiC3Ly9cuC6yL5pwTzRrWoKNSBC5PArKns52RsQ5NuIgg+UWyWOHVZ04CakRppV1Shc
         RIV59GiYCj8zL3fJHXv+yJgz29HoUkKbFmZW9SmqUixmfqCo4Y8dGINZcqct1/iOltHs
         rT6mQD8QNjuX4sF0gw1QPbLecmDc5nCIt8Nw+QRQYg6SJw+8+59y+IDxUInA/PI9N1JF
         MOL4jk0ftt1zLvFY0V0SUiF4SvJI7c/ae42RV1gcZZWnJA+jgSjjqXkD/O3bw0N45XYo
         Y+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LSlZipp+0AE0zGb3icKCc1YkuSTgVLSHy2KGqRk6I4Y=;
        b=mDljjdvlhCPi00OQZeQcoVUXiAbySQkuge7G8Z8ghavXBqOXXaz+hL6yj9+aw5Lb9g
         rhBQ4r4njuSYV0Dbd7dzpcUtnsgEwpMbidpri9L69R6jHuNcQTY48JLI9s9K4psQicYI
         cLBw+ylk199UXlUwfjLZEyw8IeQnPX8Fvg3iHaJ4rPQF7szl38MMLxHacD89CBUCB9x8
         bTTEai0KurRzd3v2WEInneQRaFfJY4l1ZsaCARKIXMop+nSVzGzYY6uOj0kDxETnaF/k
         2jCPSbLL5DKP2V3caO9vzatbUQkkewSkTJXgwRwIFePWD8z/m7zYD3czooateDDLnleE
         XsdQ==
X-Gm-Message-State: AOAM532g+pWzkZZOBSIPQlKXlyYy4tXoJKVb7VZR/3a1bfTxL7BjrBfu
        DbBGblGw1Q92Ly2q8k5Jm0Colt0Pjak=
X-Google-Smtp-Source: ABdhPJyIOxYMyjTKPkkee3ZCFs/wqvHSF33wtqNkhKYIMnZ/SZY3fkZtR28T1uZDBsxb9ieBo0vwHw==
X-Received: by 2002:a05:622a:285:b0:2f3:ddbd:b632 with SMTP id z5-20020a05622a028500b002f3ddbdb632mr4547325qtw.217.1652449716612;
        Fri, 13 May 2022 06:48:36 -0700 (PDT)
Received: from [172.17.0.2] ([52.152.132.128])
        by smtp.gmail.com with ESMTPSA id bk41-20020a05620a1a2900b0069fc13ce23bsm1357035qkb.108.2022.05.13.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:48:36 -0700 (PDT)
Message-ID: <627e61b4.1c69fb81.40c5f.731e@mx.google.com>
Date:   Fri, 13 May 2022 06:48:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1248649774355339365=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zheyuma97@gmail.com
Subject: RE: bluetooth: bfusb: Check the endpoint type at probe
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220513124303.2192981-1-zheyuma97@gmail.com>
References: <20220513124303.2192981-1-zheyuma97@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1248649774355339365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=641391

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       FAIL      1.00 seconds
SubjectPrefix                 FAIL      0.85 seconds
BuildKernel                   PASS      37.39 seconds
BuildKernel32                 PASS      32.48 seconds
Incremental Build with patchesPASS      43.17 seconds
TestRunner: Setup             PASS      542.39 seconds
TestRunner: l2cap-tester      PASS      19.03 seconds
TestRunner: bnep-tester       PASS      6.79 seconds
TestRunner: mgmt-tester       PASS      116.84 seconds
TestRunner: rfcomm-tester     PASS      10.85 seconds
TestRunner: sco-tester        PASS      10.37 seconds
TestRunner: smp-tester        PASS      10.63 seconds
TestRunner: userchan-tester   PASS      7.00 seconds

Details
##############################
Test: GitLint - FAIL - 1.00 seconds
Run gitlint with rule in .gitlint
bluetooth: bfusb: Check the endpoint type at probe
7: B1 Line exceeds max length (96>80): "[    3.295916] WARNING: CPU: 0 PID: 33 at drivers/usb/core/urb.c:503 usb_submit_urb+0xcd9/0x18b0"


##############################
Test: SubjectPrefix - FAIL - 0.85 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============1248649774355339365==--
