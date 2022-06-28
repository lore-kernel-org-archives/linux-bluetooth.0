Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jun 2022 23:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiF1XgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jun 2022 19:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiF1XgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jun 2022 19:36:17 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6E3B00B
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 16:36:16 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id bo5so13417397pfb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jun 2022 16:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jBW7f67owstenCZ0OMitd3yn+VlIbcHxVmIKhrOAUxc=;
        b=kROU6nxzKnCO0gQdjlB3OVWpuaxGPllhaFjLPxNK687LqkYmI/KPv+TwdKIxvUm9KS
         GKMSKc74H9RJCuFDf56Q3tC21rfskZeUuct7gRuIg64w9N2chr1lCJDQOLON/dV155Nx
         6INMMdaIy5AfwrI/Zbun+G+GPd459o7WDUn4ZcHOKRJx3FK89zJFUIHK/RONj0uK536m
         Zj69vtzrAbm8SvbjSnV8tUJLzT3sq57CI83b/mTVwpmQ5YN7GKRQo0xp7vuyfZypaXkB
         WqbH51/q2yPwAYih+vim7jZ+gh7sX1ShodJIkhV+qQZLgri/0uyMtZhfaC4vItghYXwQ
         2VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=jBW7f67owstenCZ0OMitd3yn+VlIbcHxVmIKhrOAUxc=;
        b=ymcCBpCpK+qv69DZxditVH9BHbuKqbMRxKnh9RbyIg6bgoTySV8FtMEvEWY+6cxNSw
         j4z/4a+8JJHPkmOl8IhRRCc3aEYriH3Jmya7RWtR5Y/T5fhOQ7oRIldeg0NA9xf6kWLk
         kTYZa2WUyAcFinlal6NBrEAeB3dSaLmIhpvQ1Nkvd0YA1UcNadQJNDRJCp5OeoGNUy9O
         enaTSdktMIB7IHauc0A/xq4votysKX6dN7k6/39DZW8LYhAWwLktDvZefT3qaQCP4PHR
         EKGT4bBJokfpw4bUuCT6kMHxVtCFrrjdFql/nU6IWywUn8UZoORelpDjwYDHkwqkTM73
         a6dw==
X-Gm-Message-State: AJIora/kfQ2iPBbAFtQ4RWDpBzF5Yq918iGZLyoFGU+cuG7gFzEIsSsj
        7TwSQ241EhbgPZwJEiM0Nghj89+ns3iPJMOA
X-Google-Smtp-Source: AGRyM1uJw6HZKip5eV5lgMe+/rX71VI/acnpbqbliqSmIHpfbeDRPfo6Z9yQaIhEIOUPEp5voWQT1w==
X-Received: by 2002:a63:1502:0:b0:411:4cc0:3ec1 with SMTP id v2-20020a631502000000b004114cc03ec1mr377963pgl.91.1656459375531;
        Tue, 28 Jun 2022 16:36:15 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b0016a0bf0ce32sm596864plh.70.2022.06.28.16.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 16:36:15 -0700 (PDT)
Date:   Tue, 28 Jun 2022 16:36:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 216186] New: NULL pointer deref in klist_next triggered by
 Bluetooth HCI_Disconnection_Complete event in 5.4 kernel
Message-ID: <20220628163612.2974d48b@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



Begin forwarded message:

Date: Tue, 28 Jun 2022 22:32:55 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 216186] New: NULL pointer deref in klist_next triggered by Bluetooth HCI_Disconnection_Complete event in 5.4 kernel


https://bugzilla.kernel.org/show_bug.cgi?id=216186

            Bug ID: 216186
           Summary: NULL pointer deref in klist_next triggered by
                    Bluetooth HCI_Disconnection_Complete event in 5.4
                    kernel
           Product: Networking
           Version: 2.5
    Kernel Version: 5.4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: john.klug@multitech.com
        Regression: No

Created attachment 301301
  --> https://bugzilla.kernel.org/attachment.cgi?id=301301&action=edit  
5.4.199 kernel patch

https://bugzilla.kernel.org/show_bug.cgi?id=215497

Also:

https://lore.kernel.org/all/SJ0PR13MB5755C82B210AF2FFC96C2A1AFEB29@SJ0PR13MB5755.namprd13.prod.outlook.com/t/

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
