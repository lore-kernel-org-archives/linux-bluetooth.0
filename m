Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591A0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 03:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiGNDRA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jul 2022 23:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiGNDQ7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jul 2022 23:16:59 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9AF252BC
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 20:16:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f65so346277pgc.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Jul 2022 20:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7xnt01jodMOgh8dpp4KkM95KTy2gpXr5v5QovCecwSU=;
        b=UFIuKrmseDVydZD2LgS8nJNVbqqQLNe1XpRrhw6dixDE08tKqd4yRSwUh1KoqHEQHs
         UU9tgpZ44dSpAzD8fdNCLgkCI8epc6Ea4YJD2hmWBMhkLA23bIu336BAea7Ls44IBW83
         m/k07KBPI1GnXhpQsB/uIAh9hqWpd7CoaI9t2JgeozKjEtAIfJaZJscingAdOtCofDKD
         lzFW+RGVILY9syfaD04b5nVGR0mB3W+3Ui+ZOiW/r2HmfwrZRr4eZaFtwfEO2PiFViEy
         /1kx7BgQMOSXYk9ffBXs7uJRPYdJqacy2R5rauzPHCHbuVxMIFJ6UsxaXfpp8ouNAWgz
         G6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7xnt01jodMOgh8dpp4KkM95KTy2gpXr5v5QovCecwSU=;
        b=zLfkzJoU/Tt2KVK+aeJOJIIs4aSATajAURakRHiZyf9MByP/A03lywL9150AL5RC5s
         alzNcRrMCQKxmaavRRO00HQHUdIw3bA/LEzL3/ayyLB6xkblJLCwxw635Sri/eesxxvL
         U2jSS9b+QCSfhNAWCBnoePtVlD9NYVpSP4x3r7yJJVQ0wr6Wr0amzIYj1JYSIL56Gmnj
         JQxM1WMdX3cy8e3yrNdUELsc4/aM5e+2g8flqP7yLoc84TVdKl45VdjNRemWhvYx4QHu
         d4S/QnKp4WEVwvj1Tb0zQBGg0wcUQlFDuY+vLQx33snkw/9wOXn7SUYOg2imOPTP8c9C
         CWWA==
X-Gm-Message-State: AJIora9CAPPrFuE8IChk3gTB4qpd7Kc0ixwxi11mtyC9daeUGmKZqskX
        rv2BqZ0m/6KI8hgYHGD7abxEBoMJSL8=
X-Google-Smtp-Source: AGRyM1usUrcgAw3OsIB3ut93yalg/vteo5cbLme7gz+4VuL2CwArQTplfWG+9Q/2R+eje6D4A3/eYA==
X-Received: by 2002:a05:6a00:24c1:b0:518:c52f:f5 with SMTP id d1-20020a056a0024c100b00518c52f00f5mr6353218pfv.15.1657768616848;
        Wed, 13 Jul 2022 20:16:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.60.93])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902c40800b0016be0d5483asm166245plk.252.2022.07.13.20.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 20:16:56 -0700 (PDT)
Message-ID: <62cf8aa8.1c69fb81.ada1a.0746@mx.google.com>
Date:   Wed, 13 Jul 2022 20:16:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8242800990063026188=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: hci_sync: Fix not updating privacy_mode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220714002236.3540353-1-luiz.dentz@gmail.com>
References: <20220714002236.3540353-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8242800990063026188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659501

---Test result---

Test Summary:
CheckPatch                    PASS      1.81 seconds
GitLint                       PASS      0.86 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      38.36 seconds
BuildKernel32                 PASS      33.29 seconds
Incremental Build with patchesPASS      52.35 seconds
TestRunner: Setup             PASS      567.70 seconds
TestRunner: l2cap-tester      PASS      18.89 seconds
TestRunner: bnep-tester       PASS      6.72 seconds
TestRunner: mgmt-tester       PASS      111.46 seconds
TestRunner: rfcomm-tester     PASS      10.33 seconds
TestRunner: sco-tester        PASS      10.27 seconds
TestRunner: smp-tester        PASS      10.16 seconds
TestRunner: userchan-tester   PASS      7.16 seconds



---
Regards,
Linux Bluetooth


--===============8242800990063026188==--
