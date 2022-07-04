Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4341EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jul 2022 11:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiGDLHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiGDLHF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jul 2022 07:07:05 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE2EE20
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jul 2022 04:07:03 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c13so9395533qtq.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jul 2022 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=gd9Mi6lDb0YC9AyBGh1VthKifPLSPoEgWAvb8Q5t96c=;
        b=M+ynDERYcoF3uKE6UefxweZX95U86uTjRTLNNwYxEf4U2MQiPXxYJ/99oyB4RtqK52
         /bHk+Cg/UwQ0kE124YzAxB5jCqQeo3fwvXBIaZwvEbJ05fO4gr4k/xVnUfMhc4VJTcyd
         0OKN5vlCpFzgjG/nTsb/v/9ppNId+i1gWo3kSl/WVC9ZEz+eLU6m+tro430ZHRsrQJDc
         HIJNvBjMrIVLekYCkQJpXu+ztTxd1yoDrekpYfuPl5h3WPJiFT8O0LkaA1C4p8BdY6sm
         JQXO9E1hIPdbH+J+kIV8L5YFRbrNjlXqzqg9hzdZkPlgfik4mqJ7n3GjvBe0y6V/IOcE
         oL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=gd9Mi6lDb0YC9AyBGh1VthKifPLSPoEgWAvb8Q5t96c=;
        b=hF9NOuYRjiJ3wdqSSMpYri07Dp3qyiKOMKms5Xxi5qOC62vF32fFnpwyp1g0KBWmhQ
         F4zCRbpMWXJN+x++n0Shx2pBRWIUj40TZtvk70X0UTqWoEPLQtbDaKc6CY5Ky7XAcbBw
         V/tS4QKypigZhdvxgxOihCLklsHhQbmFnbaGs+bhNZuBjtfYuN8mV2HqbUplZbHZMihH
         /+TeGcQb5Q8kMmRZv4P628HFDAt7ivcR3QXZ30g2XJQPuAN0UF5Prnc5Y2hFXkuL2cwg
         40aJdPFXIb7wpHmvAj3i9xmrhdmWK6z33vLfYkKY06PAG7FOG49CGrBqBpfqaxbH4ZAp
         qi/g==
X-Gm-Message-State: AJIora9ExUXUpaSlUT6KRJos4phNZa5CiC481LUmhXdlHhw9gNfyB/XL
        xs7JAVVmOhRD7waHbLm8Ax5QbyGtBdcfVg==
X-Google-Smtp-Source: AGRyM1u2p6HOjh248kTJ+fScb4q+baZGPVcbRLcxqatdMa1sS5zVobf7OrUcto5SgwMGE05yGuh2VQ==
X-Received: by 2002:a05:622a:1650:b0:31b:823b:62b2 with SMTP id y16-20020a05622a165000b0031b823b62b2mr23310184qtj.109.1656932822653;
        Mon, 04 Jul 2022 04:07:02 -0700 (PDT)
Received: from [172.17.0.2] ([23.100.22.173])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006a708baa069sm19070638qkp.101.2022.07.04.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:07:02 -0700 (PDT)
Message-ID: <62c2c9d6.1c69fb81.9177.d9be@mx.google.com>
Date:   Mon, 04 Jul 2022 04:07:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6324254257187938560=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yinghsu@chromium.org
Subject: RE: Bluetooth: Add default wakeup callback for HCI UART driver
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220704183320.1.Ib7423c21f71003643a5bbe954ed0538ee532b29c@changeid>
References: <20220704183320.1.Ib7423c21f71003643a5bbe954ed0538ee532b29c@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6324254257187938560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=656284

---Test result---

Test Summary:
CheckPatch                    FAIL      1.75 seconds
GitLint                       PASS      0.96 seconds
SubjectPrefix                 PASS      0.80 seconds
BuildKernel                   PASS      31.48 seconds
BuildKernel32                 PASS      26.88 seconds
Incremental Build with patchesPASS      37.68 seconds
TestRunner: Setup             PASS      463.74 seconds
TestRunner: l2cap-tester      PASS      16.58 seconds
TestRunner: bnep-tester       PASS      5.69 seconds
TestRunner: mgmt-tester       PASS      94.94 seconds
TestRunner: rfcomm-tester     PASS      9.05 seconds
TestRunner: sco-tester        PASS      8.93 seconds
TestRunner: smp-tester        PASS      8.91 seconds
TestRunner: userchan-tester   PASS      5.92 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.75 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: Add default wakeup callback for HCI UART driver\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit fatal: unsaf ("ace/src' is owned by someone else)")'
#82: 
callback since 'commit 4539ca67fe8e ("Bluetooth: Rename driver
.prevent_wake to .wakeup")'. This patch adds a default wakeup callback

total: 1 errors, 0 warnings, 23 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12905037.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6324254257187938560==--
