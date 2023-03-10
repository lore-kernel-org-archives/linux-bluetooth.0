Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A833AC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 21:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjCJVgu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 16:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjCJVgr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 16:36:47 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7A412D48D
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:36:46 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c18so7343151qte.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 13:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678484205;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tVZq24wNXWvoBdT9SPFXEe8AQbEYrepfH/WwFHQY/X8=;
        b=pCjsOOgl+JTAeYFN3Wf4sf98PJ4k4gEVUHF4iCWFTMEgVIp76I/l214f8IJ4hoJD5I
         +s8wZcAItqXXbyL/swc/MORLujM+W6OpQdyz41AoBVK7SZ7o2Sx1qnRgeFhraMAoYKxZ
         hOuysqhlsM45ZN39jmqJU2QweqibAX2ym3PIcH1zW9xAtajHzsaS7h4vG2AbloY01O2n
         6Ifk5XhzgIbHhaq3kI8Tfu/HnwcwTS5bZbzQiLv0IlTmyKk/W+k7IrdAu7uo6Vlppscv
         CfPTojt7x3JNMUEfct7cOhXvnvp3DSNkHlEkyC5nyKRvoWD38NKUgtZ/AErDPCQf9wnx
         dEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484205;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVZq24wNXWvoBdT9SPFXEe8AQbEYrepfH/WwFHQY/X8=;
        b=UYKcpILJX3gBBmmkZvhmXI+gAZxc7b8EVbw29RRZte0/DswN9lDiUj2eHH6q5M0ytD
         116mlMOrekjhcj24MOy48HPFRoAKkMIVg0VR29XV4Kipu0bTCyWlpNVntMvofTXCpktP
         b+fmdE53ffrITw5+wLFDiUDxeTXB+Lh2MgUpkvAZn6CG43B+3Yak1TWF7uOCFBKQWU5m
         HeKdKqDE1U1qPgH3f5PUIQWd8oTBQ3BhuiutGWyzcrIjWx3UJ8eLnLlCxSf1MJbMmVD9
         90B3HpyfMqBqLhmcxQiXR2R2Nuc5sLc5N49fUIv8I0enLue1V9sH6pRXZEfRvJiwJGL7
         Wq3Q==
X-Gm-Message-State: AO0yUKXM5sp5sCf9wqbcNuv/4m0c5uN/6Di1jLHoX8JQmOHIcW2+TuP0
        oo8T/1vEMrEtcZ447Ipb0XXj+n7bFTQ=
X-Google-Smtp-Source: AK7set+hPMeKv0rzcqkiTritfKF4WS1PoLWH3Aytf2X0jW6zcR3lzdtjOXLkZSRv/6Ox2x2mRXI1CA==
X-Received: by 2002:ac8:5cc2:0:b0:3b0:98c3:217c with SMTP id s2-20020ac85cc2000000b003b098c3217cmr46147920qta.6.1678484205270;
        Fri, 10 Mar 2023 13:36:45 -0800 (PST)
Received: from [172.17.0.2] ([172.177.254.80])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8580b000000b003b86b99690fsm588736qtg.62.2023.03.10.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:36:44 -0800 (PST)
Message-ID: <640ba2ec.c80a0220.76506.3a5f@mx.google.com>
Date:   Fri, 10 Mar 2023 13:36:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7088733254366319277=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,1/2] iso-tester: Update High Reliability presets
In-Reply-To: <20230310212700.3873714-1-luiz.dentz@gmail.com>
References: <20230310212700.3873714-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7088733254366319277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: tools/iso-tester.c:108
error: tools/iso-tester.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7088733254366319277==--
