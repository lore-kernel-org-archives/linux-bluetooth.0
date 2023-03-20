Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ADEC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 06:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCTGH3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 02:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTGH2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 02:07:28 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190B51F93B
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Mar 2023 23:07:28 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bz27so170635qtb.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Mar 2023 23:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TGkmhLCcWJ8iV83e+SpESyzsgIc3vF3+8Pvc0KlT8FU=;
        b=iRbjLht9Wb/kZmb6Y+zoItLWmlYiG93M1/gOThwK8gGnvXVctEplE959IIdJCOYzlv
         9fp+ZxEOA5KJONJl2gA5glSqqPE3RSwCGuzZPAgC91KDjjHCCQVnBkBrRcbv/T4ZCXfT
         t5L3eXfudVCIQvEMS4sVyIxKt/sQ259w7C/ptB2s3YrL14Pklrqsz0vEqrexjtoLCRCH
         CW6iRSUKOfdr45ifitOAzz3z4MmvbsojRfJ/cogMiKPUtlJL4eIKi/m6CqAgNFzQ7aAM
         2MJ1wbnePaTGDFddbGf/fUv1P/Lz0Jn9dcNpx7l+sIoDZoNIA6EGHf5Jlv+ZnSPk/1cO
         fSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292447;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGkmhLCcWJ8iV83e+SpESyzsgIc3vF3+8Pvc0KlT8FU=;
        b=gSUDjgvHG8GUSQkz032VoqNJoeqPHPo0TmAjf+rQjjE7IXHsDHnNK/Cr1sonYsvyaq
         9QEDeKD839ZNow7uzJh6phOKSvGdOZiS6Q9v4nv/J9OQ7SNBCXJMlDw05FVMZKMNF86x
         ziis9KAAu5gGN7WrsrxrktmHrvajvfVjN86oz97nvMK39PT9AJJYdVI2Fry1FlFxRaIG
         8/pTk+oGqCT0EQqAjQA3PUsxSCfRnIFFgz+d+/Lrvjg4zWjAkbs20+pKZpSIdQoEHxaR
         ctWR0h0F3iJZYR4Rb8fBkBjB8Ek4yzpuP1cBddhA5x06sYFuvGpH6GCVVzg60tTTmSvo
         jZvg==
X-Gm-Message-State: AO0yUKUhKI3kHYTnEtwMSBkOzao9AECbw81Z30p0+TJw3TR/rftjZD5f
        ajqkKwnyZEtIC488kkyskWVV0xhWYCk=
X-Google-Smtp-Source: AK7set8tuK6OO5i8aA+MW28dXeq7P2uQOL1UnLb+TmmHm6iJ/tPV43dOaiN/1nfI7Phu1ioEG3Pqpw==
X-Received: by 2002:a05:622a:512:b0:3bf:daae:7f24 with SMTP id l18-20020a05622a051200b003bfdaae7f24mr28712445qtx.34.1679292447036;
        Sun, 19 Mar 2023 23:07:27 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.137.177])
        by smtp.gmail.com with ESMTPSA id y5-20020ac85245000000b003de68caf5b7sm3190952qtn.35.2023.03.19.23.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:07:26 -0700 (PDT)
Message-ID: <6417f81e.c80a0220.123d5.6203@mx.google.com>
Date:   Sun, 19 Mar 2023 23:07:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5531967519292495103=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ] mesh: On exit free timer for filtering duplicates
In-Reply-To: <20230320050618.314590-1-inga.stotland@gmail.com>
References: <20230320050618.314590-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5531967519292495103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=731677

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.24 seconds
BluezMake                     PASS      744.98 seconds
MakeCheck                     PASS      11.38 seconds
MakeDistcheck                 PASS      147.43 seconds
CheckValgrind                 PASS      240.10 seconds
CheckSmatch                   WARNING   320.59 seconds
bluezmakeextell               PASS      96.84 seconds
IncrementalBuild              PASS      602.89 seconds
ScanBuild                     PASS      950.63 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/mesh-io-mgmt.c:541:67: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============5531967519292495103==--
