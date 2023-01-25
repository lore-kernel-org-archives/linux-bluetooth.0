Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF7C38142
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Jan 2023 02:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjAYCh5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 21:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjAYCh4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 21:37:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22A49423
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 18:37:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o5so14908957qtr.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 18:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aFDMdh/xkTDpiL7znqPFJMo8kBfbEUUM6lI/k1cSNiI=;
        b=SbGrCRb66sf0moealgZKRZgp5i1NznfM1w+gJxRo74GK42iqja/KjlnFT3YYxZ1L3k
         hZGHeCEEpLyLcwzX9d/5M/UZ5LuztYrTQf1zvrJtHLNa2Y8GubVHRo/N2jBloLl4JwLG
         0jro4YC3Bho2trPPvcTmPbeYhb8GTRpbccDxG3FfvvGFyMJQ3TUWr0JhHZUJW8I4+KY2
         Eniw9bqsQthT2ePV7SlhcPmzMUb87t+dM7VtnI2WzbzET7dsRJ60oXDB+gK585yHL1qq
         w96tnJSM/XZ67+hLBnXHhah3YtGLPF7PZkFfkF+EccVI12ptXU1dVnvFIqD4p6ARvEtq
         DB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFDMdh/xkTDpiL7znqPFJMo8kBfbEUUM6lI/k1cSNiI=;
        b=eduZLUrfqaLyQUbJqx4EYtpP0ef11d0c0QXXfzMO4Uq9HBGvZnhJdW9DyysuB05Gc9
         TtofoD8IJIdhS4l8HW8TzaXpSw+gkPLupymgoXLg9W66aMUVvB4GhMPLp/q80CuXGHEv
         e3WljyxV86FxJbCQ97eKwDulNSxsLrNu2N7JiMjbeGf2zvdPqxmBQir2f0nKaKjHI18I
         tNdUGF50Qqv7Ono6vBwRGB09A/RQ6Ioht2pgu0D8es6kbtacPcMYE0EfkjO7s/OGBmfh
         LglExJ8ngxKY3kVxBsEhL1u9EWmnvtPWsfqzOF6UmQbWU9ohH2Ukhg89szu5jYKZ5rut
         1ciA==
X-Gm-Message-State: AO0yUKXicWqhLrxniCii7f1Op5Zn7686tr1qxBnMaabU5UT6qvNmv3e8
        rEk5W0X5bcSgFaawPq7PoRBv8OTVH8feyg==
X-Google-Smtp-Source: AK7set/ZL90viGtEcWfoos5ixGBsb5ZT5RiaTzNPHLGvQZeAj1YAququPQ/NnKOVqS484zHZhwJPUQ==
X-Received: by 2002:ac8:7e8d:0:b0:3b6:3022:688e with SMTP id w13-20020ac87e8d000000b003b63022688emr1400135qtj.53.1674614271868;
        Tue, 24 Jan 2023 18:37:51 -0800 (PST)
Received: from [172.17.0.2] ([172.176.163.146])
        by smtp.gmail.com with ESMTPSA id o63-20020a374142000000b006b615cd8c13sm2516388qka.106.2023.01.24.18.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 18:37:51 -0800 (PST)
Message-ID: <63d095ff.370a0220.2be7f.9588@mx.google.com>
Date:   Tue, 24 Jan 2023 18:37:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3730209079445069729=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] shared/bap: Fix not detaching streams when PAC is removed
In-Reply-To: <20230124235923.3623705-1-luiz.dentz@gmail.com>
References: <20230124235923.3623705-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3730209079445069729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=715328

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      0.99 seconds
BuildEll                      PASS      27.87 seconds
BluezMake                     PASS      1017.09 seconds
MakeCheck                     PASS      11.69 seconds
MakeDistcheck                 PASS      154.62 seconds
CheckValgrind                 PASS      250.50 seconds
CheckSmatch                   PASS      332.76 seconds
bluezmakeextell               PASS      98.83 seconds
IncrementalBuild              PASS      2597.74 seconds
ScanBuild                     PASS      1010.50 seconds



---
Regards,
Linux Bluetooth


--===============3730209079445069729==--
