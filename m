Return-Path: <SRS0=Uimr=AD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCB6C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D630C20720
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Jun 2020 23:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNCsaiTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgFVXtk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgFVXtk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Jun 2020 19:49:40 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B946C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:49:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id e12so3214891qtr.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2020 16:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=dJ5COmE+bDJ2qISdGQvHBucGXrMJw54zenTxIQBLltQ=;
        b=vNCsaiTEjiDoePimhIoX4S8EwFkUjso9Y6DGBIkreLbmbYW5pfM0ql0zI0oYUl6Pu/
         qEGhek+hup6UzsZRvhjGgiG+O0Ai7NVyDt8kJvT9mMSgr2Z4rBfr5yk4Do4kd3Um+w0O
         jKZaITZDe6xFEEn1AQImlZTmsQPm4exADp/PprPoR9c9jL51dRvgf9f3pU2LFrbu+bwx
         C4/BJrCRgIs1Ax7XZNSF8ZBJYR3pK1Tzl+vl0iWj9oJMuFVp7gTTQKVne63DFlq4Y9hb
         lfBVSsPv/G3AVbRB6W72PXSSqx24QfNCGAB0hXvNGGPhZBwK0NpsFSf5Zax3U6pGD/Zs
         fcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=dJ5COmE+bDJ2qISdGQvHBucGXrMJw54zenTxIQBLltQ=;
        b=ftbdhN5hLHbch3AmHdYTMQWnSN15/tOFLtfMXhKiRiv+x/2m95GdYu/mbsUqZ6+Ck2
         jwgaW44NPKZN2P2BOhQ29YWXL8D1DqjCd5RkNvr6R29KtsvxUclZMc8s+8tCQtdyBuaY
         QNyGPamR5xfIcRDB2Ow77HeJPMpJ2XYY6DjS3B4+6luJt4ctmziPz5PBchoaxNccr8qc
         8cAQrouF4ritAh2EPXilOkz/Z7UcMoZPUbfNKzYOSd79b4azE0aeVJIOZlil26RGqxnr
         ckp02mgaRTrULjMCTYKuTm/1JA7u/DqA1t96J2ZyuFHxEstN8EYuYkDcwO7JWPTf9J4s
         5WJg==
X-Gm-Message-State: AOAM532Dw8EUFqG76T04x4IcB9lX3RdoU1e0XwLzoeySQaPOyMIKcCgt
        9829VuGeQigwN8og8G4LGxI/XeajttY=
X-Google-Smtp-Source: ABdhPJzqxLo+EoZjFjg4wjtLv77tx+HJVTa0XoqwXTyGp4iEsfy1e6w24j/F6GkqvO0kcMK6rC/uag==
X-Received: by 2002:ac8:6f30:: with SMTP id i16mr19203027qtv.275.1592869779178;
        Mon, 22 Jun 2020 16:49:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.9.213])
        by smtp.gmail.com with ESMTPSA id v28sm10273566qkv.31.2020.06.22.16.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:49:38 -0700 (PDT)
Message-ID: <5ef14392.1c69fb81.453ce.1971@mx.google.com>
Date:   Mon, 22 Jun 2020 16:49:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8419214222702337217=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: device: Allow devices to be marked as wake capable
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200622164003.BlueZ.v5.1.I3a6c238b09e1a0fad69e69cc2e6f4063af989b37@changeid>
References: <20200622164003.BlueZ.v5.1.I3a6c238b09e1a0fad69e69cc2e6f4063af989b37@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8419214222702337217==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9kZXZpY2UuYzoxMzQ3OjY6IGVycm9yOiBubyBwcmV2aW91cyBk
ZWNsYXJhdGlvbiBmb3Ig4oCYZGV2aWNlX2dldF93YWtlX3N1cHBvcnTigJkgWy1XZXJyb3I9bWlz
c2luZy1kZWNsYXJhdGlvbnNdCiAxMzQ3IHwgYm9vbCBkZXZpY2VfZ2V0X3dha2Vfc3VwcG9ydChz
dHJ1Y3QgYnRkX2RldmljZSAqZGV2aWNlKQogICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn4Kc3JjL2RldmljZS5jOjEzNjU6NjogZXJyb3I6IG5vIHByZXZpb3VzIGRlY2xhcmF0aW9u
IGZvciDigJhkZXZpY2VfZ2V0X3dha2VfYWxsb3dlZOKAmSBbLVdlcnJvcj1taXNzaW5nLWRlY2xh
cmF0aW9uc10KIDEzNjUgfCBib29sIGRldmljZV9nZXRfd2FrZV9hbGxvd2VkKHN0cnVjdCBidGRf
ZGV2aWNlICpkZXZpY2UpCiAgICAgIHwgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fgpzcmMv
ZGV2aWNlLmM6IEluIGZ1bmN0aW9uIOKAmGJ0ZF9kZXZpY2VfZmxhZ3NfY2hhbmdlZOKAmToKc3Jj
L2RldmljZS5jOjY3MTM6NjogZXJyb3I6IHVudXNlZCB2YXJpYWJsZSDigJhp4oCZIFstV2Vycm9y
PXVudXNlZC12YXJpYWJsZV0KIDY3MTMgfCAgaW50IGk7CiAgICAgIHwgICAgICBeCmNjMTogYWxs
IHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6
OTIyMzogc3JjL2JsdWV0b290aGQtZGV2aWNlLm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmls
ZTo0MDEwOiBhbGxdIEVycm9yIDIKCgoKLS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAo=

--===============8419214222702337217==--
