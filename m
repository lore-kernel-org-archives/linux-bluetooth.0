Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6603C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbiHKWAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbiHKWAk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 18:00:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601DF1D0C5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 15:00:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gj1so18893286pjb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=mqoSl43RID8a7Q0TtsO9QtMtsb9iqi/en47esZP5J+g=;
        b=U0rrryg3FF1NcfSqGgAF60TU33QrlGA+5nbuMY3rZBP83HjjwLWHiZ6xHamH+2ngJx
         Z6+HRnPZQIpimhAKit3RoueN/AslogUmmUdUDlgOPYTwG1ZY6MEAENDpLWOaW9v3tFyJ
         d6ma+Db5VnomD5KWQWZ9IEixVbv6fNLN+afn2A1g8mvlb4e5Ta/sLykmjMFtCF/1SgGw
         Zx1yDq/fV7uJbK8NqoAuhE7+VMocKJprOlghNoGUlPpwHVE/2BYn5vScsnZlMNTfcb4d
         7m0pIHll2SrBRIoDBXoKPn1zr72iULVkOR4DLm3qMLtyVAycRxyUO3LyPatny8W//mcU
         wLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=mqoSl43RID8a7Q0TtsO9QtMtsb9iqi/en47esZP5J+g=;
        b=LfhK+SJmnaBQ+sMtGEXzH9SM9Py1IxuRndroxVGXLJbh92rIN6V/TR2UIYZEivomL5
         zqvm0ctq9ld0jw4D4A1uL7XFJ3G/SCmc+X8xgRv0SCR364fIxsa9XOsFA8xcEdb3xPt/
         NyVA7fIhPbBVxa6JLrMOpKpZsk5hEIGdmvNDK4nFmUP44EPg0FRMoXMMq3ECvI5xaiHg
         Ozho0cKFPccaoCvaR8A6fsGiMu30cveXrTPs32vHvALzDFScEUCXwvnMoPbTd2JRb9bw
         trQzBKUQ12K/32NMed4hYdwvioGFVeOx0c/dEuv5Gx+zo9vKImi53rnJEZCQSBWOpAuG
         X8lw==
X-Gm-Message-State: ACgBeo2Tx7d0mzFfcTcIMVV/g2aYbCGqzZ9k1jIxv+aXQFg2OaH2P4/a
        Wux4BhSn2X9osESDhgHqiC+PqJJQFG8=
X-Google-Smtp-Source: AA6agR5Mke7yhHKd7FnwriJoMan8tBDerY58WcmjYOkyYRdW7jvP1b9zoTRp9jQK7edzf06eKH1L5w==
X-Received: by 2002:a17:903:50e:b0:170:d829:b3bb with SMTP id jn14-20020a170903050e00b00170d829b3bbmr1110550plb.93.1660255238604;
        Thu, 11 Aug 2022 15:00:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.253.69])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902ce0900b0016be368fb30sm141891plg.212.2022.08.11.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 15:00:38 -0700 (PDT)
Message-ID: <62f57c06.170a0220.4a56d.04f6@mx.google.com>
Date:   Thu, 11 Aug 2022 15:00:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1208313346176411157=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix suspend performance regression
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220811212435.273142-1-luiz.dentz@gmail.com>
References: <20220811212435.273142-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1208313346176411157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667005

---Test result---

Test Summary:
CheckPatch                    PASS      0.88 seconds
GitLint                       PASS      0.47 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      32.86 seconds
BuildKernel32                 PASS      29.48 seconds
Incremental Build with patchesPASS      42.50 seconds
TestRunner: Setup             PASS      491.87 seconds
TestRunner: l2cap-tester      PASS      17.10 seconds
TestRunner: bnep-tester       PASS      6.38 seconds
TestRunner: mgmt-tester       PASS      104.11 seconds
TestRunner: rfcomm-tester     PASS      10.03 seconds
TestRunner: sco-tester        PASS      9.69 seconds
TestRunner: smp-tester        PASS      9.66 seconds
TestRunner: userchan-tester   PASS      6.73 seconds



---
Regards,
Linux Bluetooth


--===============1208313346176411157==--
