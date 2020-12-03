Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEB8C64E7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCE42086A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 13:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgLCNQN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbgLCNQM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 08:16:12 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63593C061A4F
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 05:15:32 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id y18so1909797qki.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=T1QWNzGG+WwJ1an/lZc3hELNZ/+Ku7JubWUqqfSjBWY=;
        b=OYlGE7MaWzVQejzYEMprW7o8buU1geP4jfTaENr8Z7k4Bd+r+X0aCnD9d1YjeQ/Xp7
         VqkULRqo0kogTdMS3dkaUTKDt5pTa2GDG3gMm32qhA8qJg/6ErV0qBLkTv+vau4wg6gW
         fckHWlKodDsreGDOOyLdtIefmsd8PXtWRdLv6fIiRXPQRjtlMLywMdmsaOS7lWQ9RQMj
         y6MfrD6ObaXhtmz7Le+tQ2xSzrVj68fQRde1UVr+4liOVDSIdDOC36s+eiG5FxHirzwf
         kz16yvbbeudDSSGuvWeISTvVo4bUyvexpzjWB/sjjEU3JwydkibRygJDRbFxbE4K86Q3
         iR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=T1QWNzGG+WwJ1an/lZc3hELNZ/+Ku7JubWUqqfSjBWY=;
        b=bD+9UucNREXt1orDF0uDmrMCu9HTfPG6iVG56TCSZva7DcSLQnb7A5ICITG7kqAEZQ
         JT1PcojhlyIDdyBkSqECCF0tPzDcQCOvJVSoqeZCZ4+/C8hMouyzq96DGb3vsnxkfLxN
         /rTCv4ragxmxUuaWaXFWDRLLEAUGNTHWJ1WMFNGFeHdGT+sPUjYSK1WRbJg3u4F2Wqpe
         /OwBW7G7TUVzNIFNhCGfJj71UUm0bHdBpKNdhf7EOjG7mIiNIRKO46i8PrqQNb6RVMij
         TANkoGrnH8XzR+mqqNT7IHJUHc1V/cexNAI5MSGvtcoO5f6EECvzTujSUEcDldUU2aEy
         /QFA==
X-Gm-Message-State: AOAM530nyo9wKqyzlbxxknII+GJv8IEDlCKqrCX7RZhctOHd7TYCnPX0
        YqHdzUh1MxxHpc/WRs0f/GktfVTqnnTr1w==
X-Google-Smtp-Source: ABdhPJyBSjX0diWqDc4XpGm1HnhIdKYLWeEwLQztrTsjTWwEmfWNFmM7FwOW7ycxYiouwZgmuyW9lA==
X-Received: by 2002:a37:67cf:: with SMTP id b198mr2783372qkc.471.1607001331139;
        Thu, 03 Dec 2020 05:15:31 -0800 (PST)
Received: from [172.17.0.2] ([52.188.126.208])
        by smtp.gmail.com with ESMTPSA id a83sm1205671qkc.77.2020.12.03.05.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 05:15:30 -0800 (PST)
Message-ID: <5fc8e4f2.1c69fb81.35259.3b35@mx.google.com>
Date:   Thu, 03 Dec 2020 05:15:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8313064631365003028=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gubbaven@codeaurora.org
Subject: RE: [v3] Bluetooth: hci_qca: Add support to read FW build version for WCN3991 BTSoC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1606998001-17424-1-git-send-email-gubbaven@codeaurora.org>
References: <1606998001-17424-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8313064631365003028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=395449

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - FAIL
Output:
Bluetooth: hci_qca: Add support to read FW build version for WCN3991 BTSoC
1: T1 Title exceeds max length (74>72): "Bluetooth: hci_qca: Add support to read FW build version for WCN3991 BTSoC"


##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8313064631365003028==--
