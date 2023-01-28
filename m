Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288D3C27C76
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Jan 2023 08:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjA1IQo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Jan 2023 03:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjA1IQn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Jan 2023 03:16:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D285F771
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Jan 2023 00:16:42 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z3so4731466pfb.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Jan 2023 00:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k+51GqVhRsV8g2sIP1YNWJQ9/g1H2A6qvcJQU6rohW0=;
        b=bod0vhL3cR7bTa7Jjlvs5Ml9Le+MZZa02i60PDIAxxphgqeosJpAE7MgSOOgXkpxMH
         gn5QoQP4bq6822TZR7dyAL18SIzhR9GUvvnTAhhEOGXS4GrEfSNJWU4Rp6iYP+oZXEZF
         3w7cp2wh+ApbEFu5KnWOXdJwoKCfogfdBTGrmzk6+JMFzO+YASpj/swBkjNHBXWBbOzU
         uz9dzQaa/xtQsuvtkbDJ8QGJourgwW8M8jjN+skwFHopJwm0ycfUlxwsMcKVUMsgQJSj
         eXkAOtUwYOzw/jFpfc0146Gdsr77btXvb0ZzQrDXtxE/IrJ/krbuu+nnnVx2z1GWHIwv
         2u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+51GqVhRsV8g2sIP1YNWJQ9/g1H2A6qvcJQU6rohW0=;
        b=E7AFTw95usHxO1k/DNRuscNkTRoyEjx9g9wphpNMAsITh8clOtQzmt2W5Z2L0jSNub
         2zVdsYGoyYSeOdIpFHyxjhKcp+xH6jLAEltj4vRiJT9JwueOsouo45E9Rc2VtDpkDG/4
         Soa2n6w9HGFKkQic9hFPSzMlqFGKdylvOzZCvXgTlvahInOleaghK/uMfaHdpWTO3ZLo
         bCOTaHmEQkJUMMBloScOxYpvFeDUVGeCMG9kFe8XU1qR0eDNyDLgxuuEpH63/SEE1mHV
         OLINtnoN7BqQQHFAmj3DU5oV4g2VV554B99lAo9gbGm8D7NJEuvD3jG0uqsBHMYNyty5
         7CDA==
X-Gm-Message-State: AO0yUKX2zRxyH3JzCwUV5Q3tJzvX8HLdsLQE9c1f1Jlb3m1n/O96cfS8
        A5MES2hkkgDgL28D59iE8vMUPneD8Yo=
X-Google-Smtp-Source: AK7set8Yp8r6zOnqB8flZkS1Ob25dDs7/FrElHsQar+hYpt3Bj9Z26QHFrWLKa+V7QFBgyBSc2s7KQ==
X-Received: by 2002:a62:1e05:0:b0:593:a131:3692 with SMTP id e5-20020a621e05000000b00593a1313692mr202365pfe.13.1674893801544;
        Sat, 28 Jan 2023 00:16:41 -0800 (PST)
Received: from [172.17.0.2] ([4.227.9.17])
        by smtp.gmail.com with ESMTPSA id c10-20020aa78c0a000000b00582bdaab584sm3815164pfd.81.2023.01.28.00.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 00:16:41 -0800 (PST)
Message-ID: <63d4d9e9.a70a0220.5ef34.68d5@mx.google.com>
Date:   Sat, 28 Jan 2023 00:16:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6042122914273892518=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcin.kraglak@telink-semi.com
Subject: RE: [1/2] shared/util: Add CAS, HAS, TMAS and PBAS UUIDs
In-Reply-To: <20230128063733.18131-1-marcin.kraglak@telink-semi.com>
References: <20230128063733.18131-1-marcin.kraglak@telink-semi.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6042122914273892518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=716526

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.49 seconds
BuildEll                      PASS      26.46 seconds
BluezMake                     PASS      771.91 seconds
MakeCheck                     PASS      10.72 seconds
MakeDistcheck                 PASS      147.81 seconds
CheckValgrind                 PASS      239.91 seconds
CheckSmatch                   PASS      319.65 seconds
bluezmakeextell               PASS      96.13 seconds
IncrementalBuild              PASS      1222.26 seconds
ScanBuild                     PASS      961.02 seconds



---
Regards,
Linux Bluetooth


--===============6042122914273892518==--
