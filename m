Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF49CCA473
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353478AbiFUTzE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiFUTzB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:55:01 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED28CF2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:55:01 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id c1so21639245qvi.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lXPd/cMScig3L7kAvkcuG/uSKHIojMQArvtQh7WpR7I=;
        b=dTENSAWuACClAFkfEtbLGE/p+znOHREoj05XCjMxvOq/mChLMa+cdh6F/EKiiUy41m
         tBTruzRoJeiKlQVUspPJqZV1bQymN6tyUOdXF2AjAjhOoMqko1X7/T1dxlySR40bN0ab
         zQIkKHPyFWIIGLryM9AbL7tp6Sz91HtxhymfOf4g2St6XEn4m6fAhj4W3BTsQzvPq+rD
         rZfGvEoNeNFFMOpvUBAfO0/ofoLOQ0oKJwgplC7T/IUNp1NxrKDtWZwT2BExI3y2D+yE
         kZyxKKX4BP+CDFU+Fbw1E6psb2NDO3+zTawcYyNPeOl35B842NJd+ggE6kraCSOf42xF
         Ta6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lXPd/cMScig3L7kAvkcuG/uSKHIojMQArvtQh7WpR7I=;
        b=VAu/v+EAoFp3EFJZDUbHZvmcOFw/DYh84AalIZ0TxtCNs3/Gsxg2MUULmB0p3TcefL
         N9cxis+auyTBdF0uD9l7Qn4XMit6oKNpOMALh/LfAIPrv4YgzqgplSWVe2fI3h0us3EI
         xkAmqIK+SZDIO9vnLc/UEZsW+hyQag7jzQ1LxB7VcHHFS1ZD6XJ+IrrYT/Mp58JZrfnF
         6PWGhDPGQMS+DoGWgaPbshJhK6/3WBCi3oc7rB3A3dqJ0/KqdaGjL+MW2fUmGJvlxUqJ
         3O0ERHkBUtTONd6RJwGxuevhW38Rq4JkgMlggDUSylphqQk6pPjg+8+bd6pgdz/FCawx
         BlQw==
X-Gm-Message-State: AJIora+IQer3+eKZ418+H2DPdTzKfzlvlCTux7CQg6zWTl32Qa16TYKw
        asKSqEDbg8i+UyQb1YqYViF3EuVWOqiZvg==
X-Google-Smtp-Source: AGRyM1uBONtL8rhGYRzpbpjpgEbw0NNDYTanchYGsIqpRdLPvxvPPoLb+nfQ4g1LDMeTfFTPni8Rqg==
X-Received: by 2002:a05:6214:238a:b0:441:76a5:2331 with SMTP id fw10-20020a056214238a00b0044176a52331mr24213409qvb.96.1655841300080;
        Tue, 21 Jun 2022 12:55:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.1.177.246])
        by smtp.gmail.com with ESMTPSA id d84-20020a376857000000b006a77e6df09asm13744478qkc.24.2022.06.21.12.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:54:59 -0700 (PDT)
Message-ID: <62b22213.1c69fb81.434a2.9a8d@mx.google.com>
Date:   Tue, 21 Jun 2022 12:54:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8998122595532440428=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND] Bluetooth: hci_sync: Split hci_dev_open_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220621190914.2159875-1-luiz.dentz@gmail.com>
References: <20220621190914.2159875-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8998122595532440428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652485

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
GitLint                       PASS      1.09 seconds
SubjectPrefix                 PASS      0.96 seconds
BuildKernel                   PASS      32.20 seconds
BuildKernel32                 PASS      28.37 seconds
Incremental Build with patchesPASS      38.41 seconds
TestRunner: Setup             PASS      474.76 seconds
TestRunner: l2cap-tester      PASS      17.57 seconds
TestRunner: bnep-tester       PASS      6.13 seconds
TestRunner: mgmt-tester       PASS      100.63 seconds
TestRunner: rfcomm-tester     PASS      9.67 seconds
TestRunner: sco-tester        PASS      9.50 seconds
TestRunner: smp-tester        PASS      9.55 seconds
TestRunner: userchan-tester   PASS      6.33 seconds



---
Regards,
Linux Bluetooth


--===============8998122595532440428==--
