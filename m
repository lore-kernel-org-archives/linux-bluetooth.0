Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE4FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 01:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8A064E3B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 01:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhBLB73 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 20:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhBLB72 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 20:59:28 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4096FC061786
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 17:58:48 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id v206so7436297qkb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Feb 2021 17:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=KmprqgpOaPZLbKB4m0rpLNh66zdB/Bt9XjLh6q3SnNA=;
        b=ophpLNyevCwDTAhpY9sK4P1DadQxcBRZYKU7fiIPGzZtj3yf/K6nIOB+us3A2dzviA
         ceXvYkmVnsQyL2mEPhL7v+nl/+FP1x6RoIod183ztbeUqOH0QVQd9G1azzvUaqyC2qCe
         be65caexcuWcM99cDnbKZPTmOQYcRyNbKRpXZhj0tKC1xUpzvWqglotISpdWY6p5axVM
         agN0MNgUdOXCmv645VoJyrdbtfNvR+TCtBkRlcAFuFqkMsG/CFnaglEJgiXtnB1Q9Xnx
         c6+911RXtV+1JWJxWq8l49YvnKvhn6n+u2+qjdLEYPPNaHnqL9R+NUCbXgjIhmAyrfg0
         Y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=KmprqgpOaPZLbKB4m0rpLNh66zdB/Bt9XjLh6q3SnNA=;
        b=a3148kibWDuPW3zI2b+dFO/TX16OR9z4SGbtzc+gN0dn62STC1L3oeAyZF8Rye6CRM
         s6oUwRxy7p2KISkGo+Tf2qNqvsDrc87fHXPH8UpPCXWR3lsqpjv/bZBsnjRNZi4151WA
         vgeJJrd2ScmMGTUyqdVelQoQjKNW8Hz4KJNo7GC/4FNHm6BZoTVfSkQ2ZwPHNnr5VT8f
         6/XRyVfDZcWOdooKN27Y7h7nqTFPyFmmjErSQqpKLJFGmCFepkWfP/cPmP78jbmuAd8H
         U5y1tWeainvLD43Hzr3MrCWZsDndllOFzwMsyzY7f/KcBEuU4DY0PBL2HYGBXYoQpIfq
         Y9Ew==
X-Gm-Message-State: AOAM531cBiZI7m7w5sujA13RLpo2J3pQvVzQyLBeGGRP3ifc55rBoMtE
        mmXvC2IX8STbfDqZZgkJmcALaS4JYeZR7Q==
X-Google-Smtp-Source: ABdhPJzr4C/Js48s5Ue4NYyYixR9r1flg4M19VKHosMuNFRSDhQRjrts8JxgSCpsR1kcM2gTTn4DSA==
X-Received: by 2002:a37:48cd:: with SMTP id v196mr742898qka.406.1613095126947;
        Thu, 11 Feb 2021 17:58:46 -0800 (PST)
Received: from [172.17.0.2] ([40.79.255.182])
        by smtp.gmail.com with ESMTPSA id p68sm4297981qkb.69.2021.02.11.17.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 17:58:46 -0800 (PST)
Message-ID: <6025e0d6.1c69fb81.47d5f.c03c@mx.google.com>
Date:   Thu, 11 Feb 2021 17:58:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6462740565561794114=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1] adapter: Add adapter cleanup watchdog
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210211172813.BlueZ.v1.1.I0b1ea92cf6c47ac45a2b3b9264b6b64fb8437442@changeid>
References: <20210211172813.BlueZ.v1.1.I0b1ea92cf6c47ac45a2b3b9264b6b64fb8437442@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6462740565561794114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDMyNTA5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBQQVNTCgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKVGVzdDogQ2hlY2tH
aXRMaW50IC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
QnVpbGQgLSBGQUlMCk91dHB1dDoKc3JjL2FkYXB0ZXIuYzogSW4gZnVuY3Rpb24g4oCYZXhwaXJl
X2NsZWFudXBfd2F0Y2hkb2figJk6CnNyYy9hZGFwdGVyLmM6NTM4Mjo5OiBlcnJvcjogc3VnZ2Vz
dCBwYXJlbnRoZXNlcyBhcm91bmQgYXNzaWdubWVudCB1c2VkIGFzIHRydXRoIHZhbHVlIFstV2Vy
cm9yPXBhcmVudGhlc2VzXQogNTM4MiB8ICB3aGlsZSAod2F0Y2hkb2cgPSBxdWV1ZV9wZWVrX2hl
YWQoY2xlYW51cF93YXRjaGRvZ3MpKSB7CiAgICAgIHwgICAgICAgICBefn5+fn5+fgpjYzE6IGFs
bCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxl
OjkxNjQ6IHNyYy9ibHVldG9vdGhkLWFkYXB0ZXIub10gRXJyb3IgMQptYWtlOiAqKiogW01ha2Vm
aWxlOjQwMTk6IGFsbF0gRXJyb3IgMgoKCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpU
ZXN0OiBNYWtlQ2hlY2sgLSBTS0lQUEVECk91dHB1dDoKY2hlY2tidWlsZCBub3Qgc3VjY2VzcwoK
CgotLS0KUmVnYXJkcywKTGludXggQmx1ZXRvb3RoCgo=

--===============6462740565561794114==--
