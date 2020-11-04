Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2409EC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB09E206FA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 19:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKzO7gnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgKDTWP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgKDTWP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 14:22:15 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA6BC0613D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2020 11:22:14 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id dj6so6482785qvb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2020 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=hwup5ZrXQfBy//6euZ44GKkMbTbDRMhCV95XN66py68=;
        b=CKzO7gnpi9zo9341T611LMrTmpn5qRmz9FMguChQeE5pYiUhoB/ZHD3q+298fT0Iu1
         sDTSW/DiadC+Pqa9gUDrpQkJaYyJ+z6LkZGjYRI/CMj8Q7hWTCKu4KCphVbb/XwgciJX
         dpPHR37Q/oOr68WKmRfc/jonzRXN2lkhfoBWT3mjDVrcNBj+bvIUp81YjKB/Wl0nrbFc
         W9iBwPmpkePL0NIDBWxtQX12V67DT2eYvhX62zN6FPzXWDIctzEQbyctlaSmL8hVhF0A
         xRlMgHwcoiVzaGZ6QAao+XEQfrykyqlcWrW+yLRgxZJzfz/CFTo4YK/aeWZ4E9nCljWE
         BOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=hwup5ZrXQfBy//6euZ44GKkMbTbDRMhCV95XN66py68=;
        b=qf3NA7IKoWsGBB4bbuNtW0fWSp/1XEoVS3iF1At7qAX0AmzyaYUtbMYgUKfg1alvQT
         kDmFrrKxxVLid1zyu/QF6jByv5Wqs0xD0z7kzl0rrafRYz/f05ck2gDKPQZ3ZDNSPrXY
         b33RG/OQHlydodFtpWllrtC4jFOhPtYXxAlEhj60ZbB58oondMmNFjNI4M7N4lYvQewt
         EmP53OjKaQmnBReCrjOD9QTaX38gRHMK/IKu2hEEeKWtFC5zVnhVzQH8BmA7YDHWigvL
         tpBDFmNGwRuOFsvWxoECkACk9/BDeArRjhC/15eW5JW+QJhg2XftmZv69tSCGiPF6xPD
         HfBQ==
X-Gm-Message-State: AOAM533LdRWFD6hkX33mLJczW4CsEHK4nPW7KYV++nLWeA6k5/7clL/a
        F6gM9PcVFGenqU9+BDH1kFlXgJuehbG0Qw==
X-Google-Smtp-Source: ABdhPJzPFEwuBDghPhdONcWKp4qGHGEfA3UlqhpPYP82fBVKtTrFEhbr5l1xRpnKyRnKwOSyYxtklw==
X-Received: by 2002:a0c:fb47:: with SMTP id b7mr30422042qvq.25.1604517734000;
        Wed, 04 Nov 2020 11:22:14 -0800 (PST)
Received: from [172.17.0.2] ([20.186.72.54])
        by smtp.gmail.com with ESMTPSA id n6sm3214076qkk.6.2020.11.04.11.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:22:13 -0800 (PST)
Message-ID: <5fa2ff65.1c69fb81.25747.138e@mx.google.com>
Date:   Wed, 04 Nov 2020 11:22:13 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7589427673443420154=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,01/11] emulator/btdev: Add debug support
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201102191232.1848737-1-luiz.dentz@gmail.com>
References: <20201102191232.1848737-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7589427673443420154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=375773

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============7589427673443420154==--
