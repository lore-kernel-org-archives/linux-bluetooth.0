Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0653CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240867AbiKRFaM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRFaL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:30:11 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6B87A49
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:30:10 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a27so2527686qtw.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aVw72z1jf/vaF3V6jO8Lt17VpJxSBbjDl6hsJH12hKY=;
        b=lK8Zf8j1iC7DXdJEMWqSP4NsrX7nIBxDd7CiRI4hgoaJ2u2UUG6XiHdBYK65fMQRsV
         DkTILnYZNpjZeVCcKS/BWsayk/ej4v1sKMIXF2KvpTDrj/xY86kU3ps6Oh2sbK5yknhX
         gneYq6qbdGWydt9dGKTJ3soDo19ey8G928R1XlrH9UXAFDBkj7fgG7gBmg1r4y4qwR1y
         DMtftqvRsRAJVgC2XTXS4WexqDt/BvdWWkxgTEgSswAPc0UhSs/IYFLibvdnf8Dv1eZd
         YqM3Tb7vAwrFnPhPiPg9TAxXiu3cbVT5rOphIX+rzH/5WCUoBsQnywjwC2kGWk7B5h2E
         Ylwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVw72z1jf/vaF3V6jO8Lt17VpJxSBbjDl6hsJH12hKY=;
        b=IXV0ng+kwpFxsy0d29sy+9mMcm1Uffxq9tOkJTfArtfhqy+5Rlf9LIGEOjDH3WR9P7
         eZqce6dgybmE6cznUFU7sbRtilTp/MSkPY6vS/zRvGRa1vVas5+k0++VjOgBaPBbwhIp
         e7IJNMjLLb5fb2ffAzySyc4HYaSrxvJ4MyDDNCD4MHd15K+7bOsyzxVD+NS9L6EBNNEB
         pMKl271SQw2nbFnUqJ3V8I/6r+7F/Y+rT4LFQWi5zRiS6/R30tLZrs8eeEcFsIj+HdT4
         BdRA6Mn6YXC3l17n52fwrcfTe/PLJo5hTV36h/7iQ+v2r9ufP+vntvQyVBNPQPtdHTyN
         FFtg==
X-Gm-Message-State: ANoB5pk8c6BRd/vrVHi/wQliTws2lO3PHitrrgPJRivZvgxonyjXJzgh
        QZWznQ7cKISTYm5z8lYJAAdp6SkDdU1p5w==
X-Google-Smtp-Source: AA0mqf41JvZHb6M1w+9wErqZW2UWUrqJ24MNLaAbLnmA7DV7mS9bX59Y6jrcQdgmtlUGwJzSnYCaFw==
X-Received: by 2002:a05:622a:1a8c:b0:3a5:237a:5fe8 with SMTP id s12-20020a05622a1a8c00b003a5237a5fe8mr5306712qtc.599.1668749409192;
        Thu, 17 Nov 2022 21:30:09 -0800 (PST)
Received: from [172.17.0.2] ([20.10.190.200])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a424900b006ce2c3c48ebsm1838651qko.77.2022.11.17.21.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:30:08 -0800 (PST)
Message-ID: <63771860.050a0220.9827d.94a5@mx.google.com>
Date:   Thu, 17 Nov 2022 21:30:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0153434938034999759=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0153434938034999759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690652

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      34.17 seconds
BuildKernel32                 PASS      29.89 seconds
TestRunnerSetup               PASS      420.10 seconds
TestRunner_l2cap-tester       PASS      16.04 seconds
TestRunner_iso-tester         PASS      15.41 seconds
TestRunner_bnep-tester        PASS      5.39 seconds
TestRunner_mgmt-tester        PASS      104.21 seconds
TestRunner_rfcomm-tester      PASS      9.14 seconds
TestRunner_sco-tester         PASS      8.54 seconds
TestRunner_ioctl-tester       PASS      9.80 seconds
TestRunner_mesh-tester        PASS      6.65 seconds
TestRunner_smp-tester         PASS      8.38 seconds
TestRunner_userchan-tester    PASS      5.65 seconds
IncrementalBuild              PASS      30.65 seconds



---
Regards,
Linux Bluetooth


--===============0153434938034999759==--
