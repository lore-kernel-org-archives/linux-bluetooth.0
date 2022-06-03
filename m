Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171FAC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 16:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbiFCQ1p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbiFCQ1o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 12:27:44 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8465159C
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 09:27:42 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r84so6354581qke.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 09:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ZBeoa+ieNcNVExpqwFvj5k+MJ+rM73ohVm4dejk1Qpk=;
        b=c1Bmhgqk9QExal9Or44txzo7n63CVpO+d12hViOtA+Hh3CRj8O0ywGgfgsrOxx+Icb
         BeRa1uL3aH9dLZQa/A6Y54Hxg6nGA4Ks+ZX5yty9BuC8G7MeYhSFXlMbiYsB+Pfwxyhv
         ox+a61GKtio5i0G3ouzKNMXyXZgJBxDIN/cNyjR7FmTZrWeVy47TuchEVmlSPnSPKPf9
         vDgUye/2TFy9BNedh+xbIJ4M+tuClCZY9JofsaOjxdxRimaiff99Nr5hBtdPhYv4Jyvt
         Rd5ctQ+dO0z38PzlnGS/vl4MfRtNjqvSFbzlm/uVQGQ/WW9m6lnu9hjL22g83A0Dw0sa
         gLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ZBeoa+ieNcNVExpqwFvj5k+MJ+rM73ohVm4dejk1Qpk=;
        b=po9QhAOTt684+gWk3xFSpBGy/bDTbmZYqbPuTextbct92P/hPBGjNg7jLYCBMYjBpu
         7xnPaDCbTPgoiYnuK0cMCjZkYb5SwwOHlcIoSU1Flcc5RKeTOZXhNUZq0vNxdhax3+jQ
         /faWKK7GQPyKEunhDFxJvwenqvUs2bY1ehhyQnFMnbgWpXbBfJHbFIbBtMef6HFyh4H1
         shWJbIegOe7170j26HxXvh65N4VXI1Dq9jk25T+tJtnz3qUQ1BLN6HTdCuPSDifPGVLq
         sZQhKgPKEA6TejoSi4sEd1qfKPc5BW0DGmqimf/3IfoUrWgBrp+TjIlrpCwkyrUQqf6q
         WERw==
X-Gm-Message-State: AOAM532Zb4DJ7CNMiwypmtVK01gch5o7SLNvhfsZiefNNzkWDlZn9eH1
        b4aKJ/Wz9wNVVhlApXw/ux4fAaZ4sf1wxQ==
X-Google-Smtp-Source: ABdhPJwzYSIIJhfUfSfxPwRI3ba1jAXkSvsRw5k+dWxjp6bkwaaWsI5mF1bg01JdfYyiLcWxoHNnJw==
X-Received: by 2002:a37:6341:0:b0:6a6:7636:f347 with SMTP id x62-20020a376341000000b006a67636f347mr6506049qkb.48.1654273661402;
        Fri, 03 Jun 2022 09:27:41 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.125.251])
        by smtp.gmail.com with ESMTPSA id ca27-20020a05622a1f1b00b00304e43ac0a5sm29305qtb.79.2022.06.03.09.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:27:40 -0700 (PDT)
Message-ID: <629a367c.1c69fb81.c1344.0377@mx.google.com>
Date:   Fri, 03 Jun 2022 09:27:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1299158536062313690=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [v3] btproxy: Allow to select multiple BT controllers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220603145447.45655-1-frederic.danis@collabora.com>
References: <20220603145447.45655-1-frederic.danis@collabora.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1299158536062313690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=647234

---Test result---

Test Summary:
CheckPatch                    PASS      1.55 seconds
GitLint                       PASS      1.03 seconds
Prep - Setup ELL              PASS      42.53 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.56 seconds
Build - Make                  PASS      1398.83 seconds
Make Check                    PASS      11.29 seconds
Make Check w/Valgrind         PASS      442.76 seconds
Make Distcheck                PASS      229.56 seconds
Build w/ext ELL - Configure   PASS      8.57 seconds
Build w/ext ELL - Make        PASS      1377.99 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============1299158536062313690==--
