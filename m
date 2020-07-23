Return-Path: <SRS0=glhu=BC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A6C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 06:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53DE720825
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jul 2020 06:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bieLwvVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgGWGvz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWGvy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jul 2020 02:51:54 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851E1C0619DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 23:51:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id h7so4429860qkk.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jul 2020 23:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=fE90wEWs5slYKWbuMXkCnUUgmzD/w8ZaNrHXVRulRpg=;
        b=bieLwvVcJ40/Lnoj52/yCCLNU+Fz6hkNdfoGMNnRByYdbbhPVD8nxW6WCgFHQ72IdY
         OhYkmP9b3x6iuTYU2cA4anBMIc/2VWMaONwJTscWtxYrWQjRVX9dsNz/f4uR94JMNWgC
         EaNEgOJfuquNNcJkBigW/+ORBUp1tgL3X8efcOxjrgbw0TMwgmxSroXaZtUwmxuJRc70
         0ZYlEeUEvKYbnmNwHO/JbASy//j5Mk+lKBkB14RXZ9A1hRCH+qWD4QBrSqCgEhoGVtle
         LIAQ0IphGabhObmmUf+jp8C+T02Y7smWijEgL07FL5JEsG7Fq2XbVdoebt2wcxvYkbXg
         Kcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=fE90wEWs5slYKWbuMXkCnUUgmzD/w8ZaNrHXVRulRpg=;
        b=BN41Z8Ha+k0PsG4cVoULwAbPaBO/2fqPm/vGFL6X6eYHiy0YFCqcY09re22Bhw86st
         /dkMyV2B4JhXnILlv9tdE0wTv/xQVDaJhXJuwfEGiOdBmyPX6U9TzYJKZ+6V9yr0Xx/p
         Dpf5qXFcy7XI6EpwBW01SYH+rIPVD+6l2vF1RP/F7StvQxDiLHyKylkZO11Tk3xPl8cj
         OxgaOLfNZBCaVBYaVpwwHgTIYxwNs9scGN7zOZ8FNEtYWzHP//aAEnWbNkagaXXJeQ7V
         RejmDz4ArqPnwcdy6XRQgwJq4YMv83zGg/NKeoqzCrUZO7Ew+4iRhqdDpTuh3V2UVkUn
         FQQA==
X-Gm-Message-State: AOAM531Ry6/A0nuB0Wmh7kroYNo0MK3CXqw+R1ky7iunr102ksO1/kv9
        akB2+gsSD2c/CQbxU4nc8+riJcXHoiY=
X-Google-Smtp-Source: ABdhPJzG96qfoI62lf9kcY4weEcD9YmSNMtXgBbFzdFmjfcajRPkTo+Y3TbTk9KXR5AX/RJ7N1F3Uw==
X-Received: by 2002:a37:b987:: with SMTP id j129mr3858100qkf.120.1595487113657;
        Wed, 22 Jul 2020 23:51:53 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.66.140])
        by smtp.gmail.com with ESMTPSA id r18sm1707280qtf.62.2020.07.22.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 23:51:53 -0700 (PDT)
Message-ID: <5f193389.1c69fb81.a79b1.9a7f@mx.google.com>
Date:   Wed, 22 Jul 2020 23:51:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2522545925444341057=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v4,1/2] audio/transport: change volume to 8bit
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200723142128.Bluez.v4.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
References: <20200723142128.Bluez.v4.1.I667fa0ebcc3056a21c22fdaf476a56dd72aff38d@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2522545925444341057==
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
ZmF1bHQgKHNlZSBgVScpCnByb2ZpbGVzL2F1ZGlvL2F2cmNwLmM6IEluIGZ1bmN0aW9uIOKAmGF2
cmNwX2hhbmRsZV9yZWdpc3Rlcl9ub3RpZmljYXRpb27igJk6CnByb2ZpbGVzL2F1ZGlvL2F2cmNw
LmM6MTY2NDoyMjogZXJyb3I6IGNvbXBhcmlzb24gaXMgYWx3YXlzIGZhbHNlIGR1ZSB0byBsaW1p
dGVkIHJhbmdlIG9mIGRhdGEgdHlwZSBbLVdlcnJvcj10eXBlLWxpbWl0c10KIDE2NjQgfCAgIGlm
IChwZHUtPnBhcmFtc1sxXSA8IDApCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgXgpjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2Vm
aWxlOjg0Njc6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYXZyY3Aub10gRXJyb3IgMQptYWtl
OiAqKiogW01ha2VmaWxlOjQwMTA6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywKTGludXgg
Qmx1ZXRvb3RoCg==

--===============2522545925444341057==--
