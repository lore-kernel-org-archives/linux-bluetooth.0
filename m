Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99DDC001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 21:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjHIVQ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHIVQ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 17:16:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B1010CA
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 14:16:27 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4085ee5b1e6so6895301cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691615786; x=1692220586;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zMaWeJYdEeRrARXdlCdC/uTtESIiz4jbMMTwG0Oihd0=;
        b=fwN07e/uvlLvcUVT/CnRxcc/wSOZnOpdI9S5eBtWrOphrQxhkHAI5tEINb2cmBOlOp
         FpeJBSbFhWpw9KiMgcsJ0I/Z410J9WMsLtbvY2eumW6lW8FtTk2/Li9zoCY32VbqnPzz
         j9AHMWkSKp0JTx64sRoI5f02/Pt/6HQCvgZ5R9MFcvh9F3DVXBhg8isvDii06rAAw6Nu
         1aU8PKMr1VxzpAzLqI0MZ52pd7CKtIoWLxlGWWtXf9uI1FuTBEiQ/ktKmL2hjaO2MSXX
         AxwdhWTh8AaM48A8JCTv3hgWkLyuMmDHSypKGwOlpL8u4Xe2gmG9CKCJMkJppjB/wLSM
         4toA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615786; x=1692220586;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMaWeJYdEeRrARXdlCdC/uTtESIiz4jbMMTwG0Oihd0=;
        b=RzapT5bUJB0qBZKlXi6oTYOUMdtMDEs6xk9rXwCwwDUMKoMY9lfD0a71cKvfXicGra
         csxnxHpdMX8w+i8UMout7qPyaQus5QdlsvbK7uwqthcKnX4TlteyJCW/qIrU4tzDYnCu
         jdhhuh0uyoSND6X74LcCq6JipUpuHDNlwinpbLWDR7QUewJU2z9JgCbmqtJDDVcqW5LO
         8pAhWqpShbXo0BHjyW4Jvj3DYH43Sl8kQZR2Y+abf/CpJUbxS0lga7BQYJG632jZ48be
         7CS3TrFPd68GQMv38SLPRs0TAtb1pi9rMa5QGBpyEpbas9rco3L3U6lItZfse+3ohumT
         RqJg==
X-Gm-Message-State: AOJu0YyhR4iHDF1v3U5tU9P17JcF22I/p/uKj8aF0Adjwtkzyl5CvopL
        oNHkjV25+2AoHYHCFEcN50L2NFz91q0=
X-Google-Smtp-Source: AGHT+IHRuQBDjpM5Wi1Z6k2uzA96weoGBspSu+In36QrBCabNNbdJkF9hyic8pAAU2F+ILhJYnLS2Q==
X-Received: by 2002:ac8:7e83:0:b0:403:b63a:afd with SMTP id w3-20020ac87e83000000b00403b63a0afdmr143022qtj.9.1691615786061;
        Wed, 09 Aug 2023 14:16:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.61.188])
        by smtp.gmail.com with ESMTPSA id b10-20020ac8678a000000b0040ff25d8712sm15651qtp.18.2023.08.09.14.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 14:16:25 -0700 (PDT)
Message-ID: <64d40229.c80a0220.3a28.0143@mx.google.com>
Date:   Wed, 09 Aug 2023 14:16:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8916598636388849960=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] device: Fix not probing drivers at startup
In-Reply-To: <20230809194620.1595792-1-luiz.dentz@gmail.com>
References: <20230809194620.1595792-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8916598636388849960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774671

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      27.92 seconds
BluezMake                     PASS      884.46 seconds
MakeCheck                     PASS      12.63 seconds
MakeDistcheck                 PASS      161.48 seconds
CheckValgrind                 PASS      260.45 seconds
CheckSmatch                   PASS      351.02 seconds
bluezmakeextell               PASS      107.80 seconds
IncrementalBuild              PASS      738.38 seconds
ScanBuild                     PASS      1131.15 seconds



---
Regards,
Linux Bluetooth


--===============8916598636388849960==--
