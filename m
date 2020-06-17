Return-Path: <SRS0=B2uu=76=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0CEC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479C520853
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Jun 2020 06:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sulJ4ghM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQGi6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgFQGi5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Jun 2020 02:38:57 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D480C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:38:57 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id i16so705597qtr.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2020 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=pviF8K+PB4Zum1srlXktBT+0LTuLKc+WRvfRKE13+lg=;
        b=sulJ4ghMv2zVM8xPQVMwFomFZVPCxIDKnSNww7pzxPWEG9QKL83Pzn1bSHjhOGX2+r
         w+DQvNtWOrF7PUz2iaSa+qiJgU1fplhRSAHu4AZFVkcBvzbblaaTO0O0x2W6DiLLnezD
         f0lf+wYH11WQ/9wjGXZvuNiNWwqj3ZfxHTdNc7JCofHwd0379RVKd8Vwf8By4znSKPuP
         qMv3OP9Nk54M8iO2GqUNgmTBhIdK0NCjpTZwqBHRvDoJyijyz5PBX5mbFhk1kVJxc/2f
         dI8r6l8zrGT9tMpMzV8PG3GRJpU+WbQs+m92UAju/Z5bneJJ3iSYENIndoxRMUx511hc
         Cb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=pviF8K+PB4Zum1srlXktBT+0LTuLKc+WRvfRKE13+lg=;
        b=aEdOSUlGMSXUcTyT9+wxBHTmp48VmxLkgehJldKA7BWUzDHX211p+QFYdZHfhMtlYy
         1TFyZx4TTTvLEzrls53bHpSs3GMXdJ2SmA2hDoXdJpXLMZoZLJqHpq/ysYa8CqBAiSRu
         prdKZmBqrCjUQglN44UtRwk4yDHbL174LE6wfMMwsS+LIAC3tb1vTlwul7sYDX6KRuWd
         EPMCZ5AKaHbz/dtc3pPMk+ERHn51WHBQP9Gc2TiGyziybetnS7W9uX6slPkixP+oXTnm
         h9dEntAEEBzg1uVSxge0QuYAPezhhiMSr2k0IrHTsmDOZktnZeuka/mR/g2iErDEDajE
         rPQA==
X-Gm-Message-State: AOAM532zTBrezlRy4d+GX7T1kUrRlL2JPWkxp3+keYaxKYl1sA19UOFb
        oiy4JVg0+fxIU5PMkJm+xsHxyexBMWs=
X-Google-Smtp-Source: ABdhPJxYfLnHdSEiV3z9vHDs4DyoTq0+z6EzWXQ0J0YxYtOVp8+rXlwb/xCoYiqkhAAm91nHStp2UA==
X-Received: by 2002:ac8:7c2:: with SMTP id m2mr24688338qth.282.1592375936259;
        Tue, 16 Jun 2020 23:38:56 -0700 (PDT)
Received: from [172.17.0.2] ([13.68.98.178])
        by smtp.gmail.com with ESMTPSA id p185sm15334079qkd.128.2020.06.16.23.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 23:38:56 -0700 (PDT)
Message-ID: <5ee9ba80.1c69fb81.4de5c.46b6@mx.google.com>
Date:   Tue, 16 Jun 2020 23:38:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0892149511010852459=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michaelfsun@google.com
Subject: RE: Add new commands in btmgmt to support adv monitor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200616232642.bluez.v2.1.Id1b811687f1245eca676a6c5fae4fd13a70c7732@changeid>
References: <20200616232642.bluez.v2.1.Id1b811687f1245eca676a6c5fae4fd13a70c7732@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0892149511010852459==
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
ZmF1bHQgKHNlZSBgVScpCnRvb2xzL2J0bWdtdC5jOiBJbiBmdW5jdGlvbiDigJhhZHZtb25fZmVh
dHVyZXMyc3Ry4oCZOgp0b29scy9idG1nbXQuYzo0NjA4OjE2OiBlcnJvcjogY29tcGFyaXNvbiBv
ZiBpbnRlZ2VyIGV4cHJlc3Npb25zIG9mIGRpZmZlcmVudCBzaWduZWRuZXNzOiDigJhpbnTigJkg
YW5kIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIFstV2Vycm9yPXNpZ24tY29tcGFyZV0KIDQ2MDgg
fCAgZm9yIChpID0gMDsgaSA8IE5FTEVNKGFkdm1vbl9mZWF0dXJlc19zdHIpOyBpKyspIHsKICAg
ICAgfCAgICAgICAgICAgICAgICBeCnRvb2xzL2J0bWdtdC5jOjQ2MDk6NDE6IGVycm9yOiBjb21w
YXJpc29uIG9mIGludGVnZXIgZXhwcmVzc2lvbnMgb2YgZGlmZmVyZW50IHNpZ25lZG5lc3M6IOKA
mGludOKAmSBhbmQg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9c2lnbi1jb21wYXJl
XQogNDYwOSB8ICAgaWYgKChmZWF0dXJlcyAmICgxIDw8IGkpKSAhPSAwICYmIG9mZiA8IHNpemVv
ZihzdHIpKQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
CnRvb2xzL2J0bWdtdC5jOiBJbiBmdW5jdGlvbiDigJhzdHIycGF0dGVybuKAmToKdG9vbHMvYnRt
Z210LmM6NDY5MTo0NDogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhsZW5ndGjigJkgWy1XZXJy
b3I9dW51c2VkLXZhcmlhYmxlXQogNDY5MSB8ICBpbnQgdHlwZV9sZW4sIG9mZnNldF9sZW4sIG9m
ZnNldF9lbmRfcG9zLCBsZW5ndGgsIHN0cl9sZW47CiAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgp0b29scy9idG1nbXQuYzogSW4gZnVuY3Rp
b24g4oCYY21kX2Fkdm1vbl9hZGTigJk6CnRvb2xzL2J0bWdtdC5jOjQ3NDQ6MTE6IGVycm9yOiB1
bnVzZWQgdmFyaWFibGUg4oCYaeKAmSBbLVdlcnJvcj11bnVzZWQtdmFyaWFibGVdCiA0NzQ0IHwg
IGludCBvcHQsIGk7CiAgICAgIHwgICAgICAgICAgIF4KdG9vbHMvYnRtZ210LmM6NDc0NTozOTog
ZXJyb3I6IOKAmGNwX2xlbuKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVu
Y3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KIDQ3NDUgfCAgaW50IHBhdHRlcm5f
Y291bnQgPSAwLCBwYXR0ZXJuc19sZW4sIGNwX2xlbjsKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVh
dGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY3OTE6IHRvb2xzL2J0bWdtdC5v
XSBFcnJvciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6NDAxMDogYWxsXSBFcnJvciAyCgoKCi0tLQpS
ZWdhcmRzLApMaW51eCBCbHVldG9vdGgK

--===============0892149511010852459==--
