Return-Path: <SRS0=zLyx=BB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1248C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FCA2073A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jul 2020 03:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAHibwp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgGVDY1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jul 2020 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbgGVDY0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jul 2020 23:24:26 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB7C061794
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:24:26 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g26so742905qka.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2020 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LWn+HwHtQaf83JNo/tsGsWvrHjJ4Qq+hBu+FHi2HB0Y=;
        b=eAHibwp7nDxIRZ1KamqQQkwpHoy3692yCLS4oE3IvlnUoghVR2iFseXtJe1MMIMmAW
         3e9nRIDbZZr1KwAZalc92k4vBYylttGsfS0gv6NWeaD8X7lQ5l+eFtZRY1iGWEJybnhm
         Ks2qw7sfeWSb10UdztGeYKEUQhWBUojJrdu8AByIaOgHzsNTsW5WH/T2TwhFjUnbMKg9
         IXe2FQq5L7HWdbmIOxiaf/d8VRPbJca02FmChUTivob+O3jY4ITgSEElU5vBSpViSzoK
         ABHzNvhzcS+JmjY12b7uCah6wFUxFyLYHqfdxPugKPT0StYRK1CZPVLVIrSeilWnc41J
         wdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LWn+HwHtQaf83JNo/tsGsWvrHjJ4Qq+hBu+FHi2HB0Y=;
        b=POw+DPC9dM1TXlg7gqNAXQ8jn5hkV7McyKoR8ZPwekUVOh5I9DJjmp1qlXoa9NzeM2
         EEUy8Oc+HmpM3D0qGEMlxHCAYNNvZ9MxbU1/KWl7XqO5EQvMtV/jHsp62uKm5GecYkc7
         WXtYsV88qA4klYCOLmYzEjcWZ1CMmOaGhKMJXWTSfp6RwWABINxicQYKAlrD2fELXTQl
         ts9IJN6nArgCXIxHDJ/qSNRzBx3hoOYuLGDDg5qSgTWQJ1I4bqd+o9nnZH51uHTnQ3Zk
         hBvzT1CrlbQyMyWGZ55z0BnlJHlCXbbY+gxfghsbLp5oF4b5Y1Md/fPRd3JOb8/MWxrR
         E+yg==
X-Gm-Message-State: AOAM530UjXk26Ke4bFbbr8I+VQz55/Nr2WCssnDNIqkmNhd7svO9lMnB
        g1cIwrBS8Pv0SuZlvUNFv1P42VNpSi0=
X-Google-Smtp-Source: ABdhPJwaSuxeTC4g8AysuhqZtDkVQc2OOpiz1YQ8sx+9/zo38FOcCz55Uo2SGnumOYInfi8gEgzKtQ==
X-Received: by 2002:a37:4ca:: with SMTP id 193mr10993367qke.198.1595388265720;
        Tue, 21 Jul 2020 20:24:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.246.123])
        by smtp.gmail.com with ESMTPSA id z36sm24518238qtd.22.2020.07.21.20.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 20:24:25 -0700 (PDT)
Message-ID: <5f17b169.1c69fb81.6abc4.5625@mx.google.com>
Date:   Tue, 21 Jul 2020 20:24:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4596658088273435016=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/2] audio/transport: change volume to 8bit
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200722110826.Bluez.v2.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
References: <20200722110826.Bluez.v2.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4596658088273435016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgpUZXN0IFJlc3VsdDoKY2hlY2tidWlsZCBGYWlsZWQKCk91dHB1dHM6
CmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNlZSBg
VScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNl
ZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQg
KHNlZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1
bHQgKHNlZSBgVScpCmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRl
ZmF1bHQgKHNlZSBgVScpCnByb2ZpbGVzL2F1ZGlvL2F2cmNwLmM6IEluIGZ1bmN0aW9uIOKAmHRh
cmdldF9pbml04oCZOgpwcm9maWxlcy9hdWRpby9hdnJjcC5jOjQwNDM6MTc6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhtZWRpYV9wbGF5ZXJfZ2V0X2RldmljZV92
b2x1bWXigJk7IGRpZCB5b3UgbWVhbiDigJhtZWRpYV90cmFuc3BvcnRfZ2V0X2RldmljZV92b2x1
bWXigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogNDA0MyB8ICAg
aW5pdF92b2x1bWUgPSBtZWRpYV9wbGF5ZXJfZ2V0X2RldmljZV92b2x1bWUoc2Vzc2lvbi0+ZGV2
KTsKICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
CiAgICAgIHwgICAgICAgICAgICAgICAgIG1lZGlhX3RyYW5zcG9ydF9nZXRfZGV2aWNlX3ZvbHVt
ZQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiog
W01ha2VmaWxlOjg0Njc6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYXZyY3Aub10gRXJyb3Ig
MQptYWtlOiAqKiogW01ha2VmaWxlOjQwMTA6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywK
TGludXggQmx1ZXRvb3RoCg==

--===============4596658088273435016==--
