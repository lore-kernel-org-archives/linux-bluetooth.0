Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA19EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 19:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385737AbiBHTCR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 14:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385672AbiBHTCQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 14:02:16 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223CCC0613CB
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 11:02:16 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 13so14509322qkd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Feb 2022 11:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nR1YSstwKHWNA8Yu7n3G9IudJVMJIHZ6cuz139mU1C4=;
        b=GxVkjMmGMscxG84k7l9rHQo86Lb+i3+Sqt+eO/WqPGNq60oAkaIINdr8a3qLlcQWl4
         +apaSsZWkskuSrAzXNAD1eoAwUm3hZg4uzJDxruDKSVkHt1WV2aOQl42EIJXxOZaVJKD
         ub6vCTDebiPn/gye467/MHBnmgyQjoSsocDtf1bQvRZXOtHbbUMZ+z57OVR9y4tvYucj
         KbLnt1SQq0SEaYGkRzUj8lktbjrOOytQWtb1ERNwVYYlbD7fJadJ9GBU1ihpxWG36nbm
         Sf5C9dHtB2AhmZTPf7ZLNzi2U7UkUQ0zND8RNTwBP3MnDx+/fLMBGfgsN5GC6WPdSSZ7
         967g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nR1YSstwKHWNA8Yu7n3G9IudJVMJIHZ6cuz139mU1C4=;
        b=XQnr4w2W7wN3H9HAnZijdY+7ZXQsItlD9YNsTLj5/+3N0pnPUvza2HR+8vztdCIA51
         vbYWYP2nDsr9yRdW3fY1o0wNhvSyHE+ecv+qycLdCnieEZJLOGJWaIu2GZSIvRRKJUJU
         wYegwoFhDVVs5THV2KmMwaMvIa0dttX6hJKKqjDb5XcbLU/E6rRk8Vst80cx7eLRS2Cy
         qFtZfc8Z5Rjodf7Abu0opyX37pJYnXojYBzwvwj3l0IpGFBJxJ1IvzfTkuDZAjw00DRw
         itzvEVynCSMtTLvIDC+mnxNaM0QFbwQo9nAdyzaKDUORvsj+MZ+BxjljnxuzOuDqdxwL
         eGeg==
X-Gm-Message-State: AOAM531x4sFn7MLrImrN25L08Ba/xgtuBFE6Is+AM/BxSichjEOMEWaO
        M3b/H9EBXhhxfj+V/YUm4qw5WFqLoUT5vw==
X-Google-Smtp-Source: ABdhPJxaMKcrZF1pfbF4qNtm4jg2X0ssjE/zC9yRcpCtiVPdFnPC+AA2FM8Z7rn3U3c5Z7kOBVbV6g==
X-Received: by 2002:a37:66d1:: with SMTP id a200mr3436406qkc.148.1644346934677;
        Tue, 08 Feb 2022 11:02:14 -0800 (PST)
Received: from [172.17.0.2] ([40.121.200.186])
        by smtp.gmail.com with ESMTPSA id bk19sm7256168qkb.125.2022.02.08.11.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 11:02:14 -0800 (PST)
Message-ID: <6202be36.1c69fb81.9b50a.64a8@mx.google.com>
Date:   Tue, 08 Feb 2022 11:02:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2675782313255933862=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v2,1/2] Bluetooth: mt7921s: support bluetooth reset mechanism
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <d328920a9abaaaedafc8c4922cdeb5935f6d64c3.1644342794.git.objelf@gmail.com>
References: <d328920a9abaaaedafc8c4922cdeb5935f6d64c3.1644342794.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2675782313255933862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612283

---Test result---

Test Summary:
CheckPatch                    PASS      3.66 seconds
GitLint                       PASS      1.81 seconds
SubjectPrefix                 PASS      1.66 seconds
BuildKernel                   PASS      27.99 seconds
BuildKernel32                 PASS      24.98 seconds
Incremental Build with patchesPASS      41.37 seconds
TestRunner: Setup             PASS      442.04 seconds
TestRunner: l2cap-tester      PASS      13.30 seconds
TestRunner: bnep-tester       PASS      5.71 seconds
TestRunner: mgmt-tester       PASS      101.36 seconds
TestRunner: rfcomm-tester     PASS      7.26 seconds
TestRunner: sco-tester        PASS      7.53 seconds
TestRunner: smp-tester        PASS      7.40 seconds
TestRunner: userchan-tester   PASS      6.18 seconds



---
Regards,
Linux Bluetooth


--===============2675782313255933862==--
