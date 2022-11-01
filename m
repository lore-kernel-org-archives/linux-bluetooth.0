Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84196FA3741
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 00:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiKAANS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKAANR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 20:13:17 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D6120A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 17:13:17 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id x16so7036842ilm.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 17:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k35IYUbXOmmklSJFOCo9mWyupU5Rl95KIFauq2RgGiQ=;
        b=YRYGKqrnKNOoi73A5iIrJmVlot5c8VJ1h1zkd0tFypoHJch7hJM+7SpVf/eETBVZ+6
         PUzxv7LYZTMUenkrlJ8Ukdi/gvAy0u+Z8fGyTew+16yf71TrOgubup7UoZzP3IKhWjrD
         Xj/M+D9ZvGltGNZ9VnQyVs9HT5Zb3Ra+Zt8omrJXcIpdzgmFHx6qNZlnUCcH32fE/zRj
         x8ANNXHEdDELmOP3uGe7/Nrm1Lq+ViRpjnz8Re1ELdVuj6s2VGs5syUCggtn473m1QYE
         ixQABqg3epQlSMpaNLRj3ITVK1UcQgjOycHp2y29G5B/7WKazPRNppmpSpGoo64PJXpv
         A/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k35IYUbXOmmklSJFOCo9mWyupU5Rl95KIFauq2RgGiQ=;
        b=EWvMVpZMPsJOea0ohGeFuPMjhjUpHS12Pc0YoyDouxIKeDcBlsOnmyaKfdXHEQw6u8
         ennhBPndxx6mrs0FZ5lmfSYGwob5qBwDT+HI5dIdhbARDvUniNbPb5fVFrQfT1nrg5CZ
         PjfH3cZqlHwpVi12QBK5z+yGJI1YyZ7Vs6SMJGR+ilEtIBwzrDQi5ADAoyk4cK1dUqNF
         U3WWLQXAHR6LH/OvmeA38YkU60euV1McLeWSH0IDecaCcmTUS/uXO1ZD0X7gJnkWz61V
         9yvMXskIgdqQFaV17CxRPDGyxZ+/Te5VeknwBlEohvj2Vk0xAXE/ZNJ/iLDwc7Uz0OKM
         gO3Q==
X-Gm-Message-State: ACrzQf2yzYOmwiH+g2FnJtPNLze8ODOpRTHCQxn3Av585GoS8bO6kht2
        xSnh40F7ISDcc5TI++75405Wcl/NKvo=
X-Google-Smtp-Source: AMsMyM7WxIGfVmX+OK2+8SdMd5u9Iv8+svLBnqLW/3AG/QXHshDh6MgV/OtZV/HPam6m4r+C+4wxgQ==
X-Received: by 2002:a92:c5c5:0:b0:300:91ca:a237 with SMTP id s5-20020a92c5c5000000b0030091caa237mr7525104ilt.319.1667261596209;
        Mon, 31 Oct 2022 17:13:16 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.17.31])
        by smtp.gmail.com with ESMTPSA id d197-20020a0262ce000000b003753b6452f9sm3199861jac.35.2022.10.31.17.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 17:13:16 -0700 (PDT)
Message-ID: <6360649c.020a0220.ffbe7.5766@mx.google.com>
Date:   Mon, 31 Oct 2022 17:13:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0815403588540234612=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: L2CAP: Fix accepting connection request for invalid SPSM
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221031231033.2718204-1-luiz.dentz@gmail.com>
References: <20221031231033.2718204-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0815403588540234612==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690674

---Test result---

Test Summary:
CheckPatch                    PASS      2.61 seconds
GitLint                       PASS      1.53 seconds
SubjectPrefix                 PASS      1.27 seconds
BuildKernel                   PASS      33.98 seconds
BuildKernel32                 PASS      30.91 seconds
Incremental Build with patchesPASS      52.58 seconds
TestRunner: Setup             PASS      511.82 seconds
TestRunner: l2cap-tester      PASS      17.23 seconds
TestRunner: iso-tester        PASS      16.10 seconds
TestRunner: bnep-tester       PASS      6.36 seconds
TestRunner: mgmt-tester       PASS      103.63 seconds
TestRunner: rfcomm-tester     PASS      10.15 seconds
TestRunner: sco-tester        PASS      9.48 seconds
TestRunner: ioctl-tester      PASS      10.63 seconds
TestRunner: mesh-tester       PASS      7.82 seconds
TestRunner: smp-tester        PASS      9.52 seconds
TestRunner: userchan-tester   PASS      6.52 seconds



---
Regards,
Linux Bluetooth


--===============0815403588540234612==--
