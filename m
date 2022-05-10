Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D26BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 03:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiEJDFn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 May 2022 23:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiEJDFj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 May 2022 23:05:39 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFE506C6
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 May 2022 20:01:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 185so2892610qke.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 May 2022 20:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=xluTuZbjjC9Ejxo+ju1vrlm07/AcYaXPqZkNiXUSlp0=;
        b=oIDJbl4g1EScqQCLAuJpLhyjbmrMBNH6FFb/kjHfFz90rATnWxzn7Gt3DH3X+/dC1h
         SiNtzol4gx5rPynIcHKauLa6N9OnWVO+9s14Vg0Fs7/RJwXhESwuEEWE8NQoTUyrD12G
         9fdgBETCyssFwQY+13NpCP/oxsKod7b6CXaOf/YbsTfFmRiduIkJFcOkl7V4WFnC3coZ
         A4vGKR9UgxrGQrgGOCxM88fmdmUqqGuVKtbSsQNiQ83exnwWrYi+FUFCkyQPDrceF8aL
         ICXy04mAFqmiimtUphD6/7CYYfsysNLxltVMe22AaYgblUOqzqiZvyUu8FeLnnhQ/ODH
         wMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=xluTuZbjjC9Ejxo+ju1vrlm07/AcYaXPqZkNiXUSlp0=;
        b=3sUmx2xoTc1yZXZeuvXZEyz6gvkkMAx+4Mm5dTkFsHaeZueQvZHwpoxrPt68HoJoiO
         et3xsBqF3d2P7+lhePRRGuu3Vh65LYIgtay+pq3P68mvAmSy5cfm9+LDbw+YZ8C65aR7
         ePc44YY77leBdpvFrEQpyW1DzCJTwJTrd/KFN5Z74UZt0C/s59yM6MiZAQcA/y/ciKDb
         Ueq+xqhPaBwyEYZaJpo8JS8us0vub2xaFV69HZ+cdrw4JsOtm/4y2JKrQC9voY+GZvNR
         czlqPQ+m76pdcZKjRMoTK2fjhZugna1nJUVKcdb5SaFrg/2LkPkgoCKbG8aHAUIcSxYt
         NyLA==
X-Gm-Message-State: AOAM531HqSzPN8whUz7HWFzV6HU/hyQEbI1UqemIWTxPBX4MAuCTRN9Y
        68XcDykjBQuZR/Fp7JnAPtaKKikc73wZVA==
X-Google-Smtp-Source: ABdhPJxojUYng4fklbqf8J7ksPnsOc2lH398xISAgMHU4RRyp2YDlltoMLbOxOkvB8mLgGVpoYljfg==
X-Received: by 2002:a37:278d:0:b0:69f:7705:61a9 with SMTP id n135-20020a37278d000000b0069f770561a9mr14527355qkn.190.1652151702183;
        Mon, 09 May 2022 20:01:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.232.222])
        by smtp.gmail.com with ESMTPSA id w75-20020a37624e000000b0069fc13ce237sm7919810qkb.104.2022.05.09.20.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:01:41 -0700 (PDT)
Message-ID: <6279d595.1c69fb81.7678a.8645@mx.google.com>
Date:   Mon, 09 May 2022 20:01:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7711041441650369195=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: device: Fix pairing has failed due to the error of Already Paired (0x13)
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220510012735.1698-1-wangyouwan@uniontech.com>
References: <20220510012735.1698-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7711041441650369195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639955

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       PASS      1.03 seconds
Prep - Setup ELL              PASS      53.23 seconds
Build - Prep                  PASS      0.85 seconds
Build - Configure             PASS      10.89 seconds
Build - Make                  PASS      1805.67 seconds
Make Check                    PASS      12.83 seconds
Make Check w/Valgrind         PASS      537.08 seconds
Make Distcheck                PASS      282.72 seconds
Build w/ext ELL - Configure   PASS      10.84 seconds
Build w/ext ELL - Make        PASS      1707.43 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7711041441650369195==--
