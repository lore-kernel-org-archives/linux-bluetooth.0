Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D3C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 08:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCHIlR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 03:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCHIlN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 03:41:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC8B85B0B
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 00:40:50 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so1536293pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Mar 2023 00:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678264850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl8NTj9wIGC2Z7HcWr2/Ogfq0j02FPacbdp0Z3PuKcI=;
        b=Z/uIM623xq62ohuHiBlMQ8XdNUfFQcqoSmXMHVXyXyV5FZzHe5dPK5EqHdw+QHq8eW
         1yjgH35jilB1jiPHIrlxBAf/2cE3k3nSaQagN9h2R8WoOpJ8GfNKDmkr6b0IpqRYiPAE
         3LEBojcdq355p33bsTImNvzZ+F3/NS/26wr8MoNRRGgkY0+pecjeh3GaJL82sme564UF
         JGFMirZ+xt6RZ6yv/OjxSkKNr6781f/kQesIwWh4hOww5qlXBl/hGXrbK9/H0qMZmLF7
         vdgcDgdMZ3gWqNpJJYYp/bxVyMr4IMlHQ4nDvzSgBI01BDm4/291uZelVFYmqoe7LDfq
         A0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678264850;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jl8NTj9wIGC2Z7HcWr2/Ogfq0j02FPacbdp0Z3PuKcI=;
        b=FsNpFfB5SmV2Mds1VA8OU/xkc1K10ncDcFgYgTZXAmzQRAN19+lhiccGn8K9aBZmTC
         GGYwnFDfe5bh1EYIKUhlbcDPUXIhPAH9mPHApJQS+aY7C2oySRBaq0u7LfupKxi7dzW5
         BKhBjFfeZ9bbHgkiLrcaTIb7uI82Tw+i05NdVn0ntT37B6D+Ez0h3RT69/C2qj/jAyVH
         81gaR+DGBkxyb94ZNVb3O79Cnn9PAOcIt4DGZBpPA+rnD+LISypvWG6ZwZB2iBe7eDPN
         /yAPARmRyWjgm6V35XpTIhqFkojl437RQg0gissXB/2EalIKud7ACS9ziAtvhh5WvDRW
         nLWg==
X-Gm-Message-State: AO0yUKUSCtr+hT5LR3iIr20gC/iKdLmAhJ9I4UAIShs5T7M7FtLrAOwA
        TVotafxu5B7bAUMRgf+ubjQK0l1wX6U65w==
X-Google-Smtp-Source: AK7set/6TQTGpfHgxDBOsHUtt0iBFzZha1yb+ReA3E4w7JBXPiw6vhgTWQPDBzDsJHxiIvlMq7++1g==
X-Received: by 2002:a05:6a20:9305:b0:cb:e98e:d1eb with SMTP id r5-20020a056a20930500b000cbe98ed1ebmr15717820pzh.29.1678264849907;
        Wed, 08 Mar 2023 00:40:49 -0800 (PST)
Received: from [172.17.0.2] ([13.88.59.99])
        by smtp.gmail.com with ESMTPSA id g3-20020a635203000000b005035f5e1f9csm8827767pgb.2.2023.03.08.00.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 00:40:49 -0800 (PST)
Message-ID: <64084a11.630a0220.bb3c.0e5c@mx.google.com>
Date:   Wed, 08 Mar 2023 00:40:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9112618336926817450=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btinel: Check ACPI handle for NULL before accessing
In-Reply-To: <20230308075837.5559-1-kiran.k@intel.com>
References: <20230308075837.5559-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9112618336926817450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727769

---Test result---

Test Summary:
CheckPatch                    FAIL      1.09 seconds
GitLint                       FAIL      0.68 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      39.89 seconds
CheckAllWarning               PASS      43.61 seconds
CheckSparse                   PASS      48.66 seconds
CheckSmatch                   PASS      132.79 seconds
BuildKernel32                 PASS      37.94 seconds
TestRunnerSetup               PASS      553.43 seconds
TestRunner_l2cap-tester       PASS      18.92 seconds
TestRunner_iso-tester         PASS      21.80 seconds
TestRunner_bnep-tester        PASS      6.97 seconds
TestRunner_mgmt-tester        PASS      132.20 seconds
TestRunner_rfcomm-tester      PASS      10.79 seconds
TestRunner_sco-tester         PASS      9.90 seconds
TestRunner_ioctl-tester       PASS      12.01 seconds
TestRunner_mesh-tester        PASS      8.58 seconds
TestRunner_smp-tester         PASS      9.87 seconds
TestRunner_userchan-tester    PASS      7.17 seconds
IncrementalBuild              PASS      35.82 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] Bluetooth: btinel: Check ACPI handle for NULL before accessing
WARNING: Possible repeated word: 'Simics'
#77: 
Hardware name: Simics Simics, BIOS Simics 01/01/2011

total: 0 errors, 1 warnings, 27 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13165350.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: btinel: Check ACPI handle for NULL before accessing

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
13: B1 Line exceeds max length (381>80): "Modules linked in: bnep intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cstate input_leds joydev serio_raw mac_hid btusb(OE) btintel(OE) bluetooth(OE) lpc_ich compat(OE) ecdh_generic i7core_edac i5500_temp shpchp binfmt_misc sch_fq_codel parport_pc ppdev lp parport ip_tables x_tables autofs4 hid_generic usbhid hid e1000e psmouse ahci pata_acpi libahci ptp pps_core floppy"
14: B1 Line exceeds max length (91>80): "CPU: 0 PID: 35 Comm: kworker/u3:0 Tainted: G           OE    4.15.0-140-generic #144-Ubuntu"


---
Regards,
Linux Bluetooth


--===============9112618336926817450==--
