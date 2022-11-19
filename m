Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B843C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKSFdC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSFdB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:33:01 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB168288
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:32:59 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id w4so4499401qts.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JsInQDGC1C6TES4lACYSFMr5Gh+ajdbaaQJA2xiCxWE=;
        b=XODuCXzZODVFGjuC7mqFVd9lWz/8PD+0FDPIsScmlkXzGuB6cx8aneRxiL9XPuDeKw
         QVeldtG+QfsDuZ/2z5EoYdEUrtpB9YjoO5Nw7bUSGWPgytBRkbVJUNLkvpmmA2PwRho+
         Fq2Nas4uvhmCaOwkOAKV/lvs5xBsIaTJIVD819kR2x0GaCCxTqwEdjJ8dxHsyZ0UJ+Hh
         Oq2MP+YYHPfSjIj9z3Yj0YQUoc7+PTIHQ68Ggf7FRno7TxNh1Kv8HFgwKz3+EDeTc6te
         DV0xabLIUxbr1Iu/Mu9PwOApZ7dA2zHIcJskG/0v8fju3ex4PiS8mqGnIuXSc926j3ip
         J1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsInQDGC1C6TES4lACYSFMr5Gh+ajdbaaQJA2xiCxWE=;
        b=zW77V6ZDcF8sJhpoygpSrKsN14LEPNHSOy+c0jnb6XzPUmY8XrClhoCFpYja1AEjFA
         niuAKtJPKVg2HkpELyb8ICjshB2IfmGNT6Eu4aj+ToXd4f7UmhmI6kowq9qFEtwFinLp
         6yQlmrWFR4eQ48j2dNuPv4z9vb0cggzQvnfPzio+fodDFSo92AhcWo9Egg8LJtqJcll4
         mNpWIAvJ7Npmf0Xq2pXPtD1Yv4LvEjy4oQoeQ+DfHHZVAGuHD4tim6QDRCFWJjS3lXzt
         iDm/wSKJb8I9dqJIk2ECiQ/2HTD70PK8rz9VTVk2AI2mU32sYr+GsxaahE4iDuGh/CNO
         lwiQ==
X-Gm-Message-State: ANoB5pm0ySXbxw2GOeGEeZh32TMPGX5lt2gtMqyFmOnHXmFTmuWn51sc
        08bXC3ZUr3C4rSnQa2XPQON3PXSNFKZe+w==
X-Google-Smtp-Source: AA0mqf6EoEQtLO9E1b1Q9ZVDGBiHG//BKPX90QimCj9rcRcbdcLgqWL4xLV1rdUT6GnNcxt8GjXCZA==
X-Received: by 2002:ac8:7415:0:b0:3a4:a229:b974 with SMTP id p21-20020ac87415000000b003a4a229b974mr9486811qtq.255.1668835978749;
        Fri, 18 Nov 2022 21:32:58 -0800 (PST)
Received: from [172.17.0.2] ([20.246.113.255])
        by smtp.gmail.com with ESMTPSA id bq40-20020a05620a46a800b006fb7c42e73asm3875740qkb.21.2022.11.18.21.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:32:58 -0800 (PST)
Message-ID: <63786a8a.050a0220.39371.2e20@mx.google.com>
Date:   Fri, 18 Nov 2022 21:32:58 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1106713868642590789=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [BlueZ,v3] doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052513.57081-1-hj.tedd.an@gmail.com>
References: <20221116052513.57081-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1106713868642590789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695796

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.20 seconds
BluezMake                     PASS      735.33 seconds
MakeCheck                     PASS      11.22 seconds
MakeDistcheck                 PASS      144.01 seconds
CheckValgrind                 PASS      237.33 seconds
bluezmakeextell               PASS      92.78 seconds
IncrementalBuild              PASS      598.25 seconds
ScanBuild                     PASS      942.18 seconds



---
Regards,
Linux Bluetooth


--===============1106713868642590789==--
