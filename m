Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F31C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Jun 2022 23:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiFZX7G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Jun 2022 19:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiFZX7F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Jun 2022 19:59:05 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541B2AFC
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jun 2022 16:59:04 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z191so8007373iof.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Jun 2022 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=1up/OHcFvNYeM7pcVBCNrs+NuqffaAQGZRj+6YY1KyE=;
        b=R5vpU69M+RWX9l0RtqJJJ7Mr1xDsDcGqAqGUD28FZA+4VnLJtCI0McQ2jFXMh5Yqa5
         XTCxrZ21Aaax1rU+U6Yexn/o+LslCLXeOPff+WAOGujd0IdTdNbw2IhLdoY3wfC9QpO4
         LSgq6sOd/adqTbQX5tJaaAAQpht2lgEVjKXzAMXXxAigYirJvwmzSgeUdUJk3zBaIDJO
         bfYbG230DO7ZxZhYmwEOOm9nQCAyeXZQp5rMHbRNPUVQBej/O6oO+pnvUC/OCGzXcck8
         OwUsTDWc0s+ePLEfsSChir6lYVcUMU43wG47Hq/sOsoejzDQXuT/VQ4EtrfOJvMYKTCh
         Bn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=1up/OHcFvNYeM7pcVBCNrs+NuqffaAQGZRj+6YY1KyE=;
        b=mBYrZklJ0W7FDKkQxlQGjYvGa2xQg0jQqpbyeONUrjKzA4siSMs8rmBeL14Uai9jvI
         nFzhZVz0NkPTHZjw15rWQ78SKuWZbEroakDX1kHuruwmRaAQtcwLxc0kfJD0S4MdHEAT
         lH7wQsZovPz32/PDjmQTnkcIe0bRRS5O6SqKSVevJKQATlPnffSuIJEJpsUW5Fr3ZUrw
         kSqXyAkd4sLFWq6xW8LN5IsoYlYneDOxDoBvIFZRJTIx/uTvyOps/e2wDbjwHOWKKEZE
         IpYLAZGr3ADM+gbN0WCVi+uWUV8NbQbWam7xmaXCFGMaOmjEom5KDkZaMbNG6RcqheCN
         /uOw==
X-Gm-Message-State: AJIora90zMMRcBK4qtfLzxjY8XCFhEBpv9PzNdTNPEJsdGmYx3FlGff2
        X2UveiluFpgjIjUdpdFxkKxTugLKpvk=
X-Google-Smtp-Source: AGRyM1uyF8r6Lno7r2JMnjteg0yGe5A8UzCECg/e/N2Ab6yDo8YaG/QRtJEU6gjUvlQ4vS2CzOiJHA==
X-Received: by 2002:a05:6638:2053:b0:33c:a139:d305 with SMTP id t19-20020a056638205300b0033ca139d305mr365029jaj.285.1656287943286;
        Sun, 26 Jun 2022 16:59:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.9.48.100])
        by smtp.gmail.com with ESMTPSA id y9-20020a92c749000000b002d8fbf31678sm3876589ilp.82.2022.06.26.16.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 16:59:02 -0700 (PDT)
Message-ID: <62b8f2c6.1c69fb81.2fa1e.3fd6@mx.google.com>
Date:   Sun, 26 Jun 2022 16:59:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2716777766761892398=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v3] Bluetooth: btmtksdio: Add in-band wakeup support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <848d3d5baf23eb78411a9672b8973ae3c593db98.1656285304.git.objelf@gmail.com>
References: <848d3d5baf23eb78411a9672b8973ae3c593db98.1656285304.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2716777766761892398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653986

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      32.11 seconds
BuildKernel32                 PASS      28.16 seconds
Incremental Build with patchesPASS      38.75 seconds
TestRunner: Setup             PASS      481.60 seconds
TestRunner: l2cap-tester      PASS      17.44 seconds
TestRunner: bnep-tester       PASS      6.14 seconds
TestRunner: mgmt-tester       PASS      103.10 seconds
TestRunner: rfcomm-tester     PASS      9.59 seconds
TestRunner: sco-tester        PASS      9.44 seconds
TestRunner: smp-tester        PASS      9.46 seconds
TestRunner: userchan-tester   PASS      6.37 seconds



---
Regards,
Linux Bluetooth


--===============2716777766761892398==--
