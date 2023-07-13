Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 06:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjGMGRW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 02:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGMGRV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 02:17:21 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6F19B9
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 23:17:20 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-56598263d1dso323150eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 23:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689229040; x=1691821040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L55rlK0wI/3Z7W6cJlefvuc1u9MRUcvoT6xIb36GJMc=;
        b=IjkqzZ9iAd64ngnnPuZiwOs+oe1zRGC8vllTdU3bo+U4ArSSDrPzVB44RxyRpT+/fT
         1L53wzfXsMYOs/ZVajrKyavLnbZKFC7Ef3hx7KkAZnZ3NVbIG3HZiyHDUbccDE5X02u6
         aYWkt4HToXfcNI6mqObM1QqpOmMC1IBBVBuSCoQyY1TBnECa4VuMHQAJbWgrtNXEpkpo
         GKk4LNIHdwfeajx3eYSCHn1oVglR7iFVDNhlyTNd3MZA5haqE5Le3ovwHln80zdlidsb
         RXP4jkje1tLufiSh0sMpXnimI66p+MDDoLYTyoyGpmzU8+aLsFfMK6sn3qzpXk2ILVUl
         XOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689229040; x=1691821040;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L55rlK0wI/3Z7W6cJlefvuc1u9MRUcvoT6xIb36GJMc=;
        b=jym411lKZ/G6iMi/XQfINjrHbXlcaoRwZuZjqSqZUGEENFjGyYmG6h4sNjOOJFwwow
         5n1yLdZjm3rZOXg6quI26j8bOqMVCTGZkzLJWf9CAvZOApypGPnL3G99cUyAFGlbLCrV
         tXf+8EsCkvHcIRumrbvm83DAzTs5gOVnrNZw92Q4RF1xtaxk6yuOXyxiaYPTjkPQkW9j
         56KH0EMMtXemYwNCHy0LVgrMGBjUsYolHKgGPGoSLgPbKPLIaDvJx63tRQsSZFpgp3gU
         Ox0PHhwkq3Ky2y4jc30wM95FLfqLnTXRkxARckpIQtJqP7JhR+OVU+Cxw+wKqjcjojt+
         0O4w==
X-Gm-Message-State: ABy/qLa5JzMPMrfkZvh11CC1ffslsZxWRDZ6CtRYblEFpQW/Njbj9NYT
        OpfaER7BiQCoBc/d/u56rb8BPQR01uw=
X-Google-Smtp-Source: APBJJlG7Qkti4BfHmRR7VcmNTjD6zK8Egq9UlmpHvIM8OxIVDoJBuTBzNEcrmjgj1aESyWJMYuEjBw==
X-Received: by 2002:a05:6870:a547:b0:177:ad57:cb36 with SMTP id p7-20020a056870a54700b00177ad57cb36mr951843oal.27.1689229039727;
        Wed, 12 Jul 2023 23:17:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.221.241])
        by smtp.gmail.com with ESMTPSA id a23-20020a056830009700b006b922956cecsm2638658oto.25.2023.07.12.23.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 23:17:19 -0700 (PDT)
Message-ID: <64af96ef.050a0220.19c53.1ceb@mx.google.com>
Date:   Wed, 12 Jul 2023 23:17:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6681348995281659322=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, bugzilla-daemon@kernel.org
Subject: RE: [Bug,217651] BCM20702B0 Bluetooth device in MacBook no longer working
In-Reply-To: <bug-217651-62941-RkBcMY1icy@https.bugzilla.kernel.org/>
References: <bug-217651-62941-RkBcMY1icy@https.bugzilla.kernel.org/>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6681348995281659322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4104
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6681348995281659322==--
