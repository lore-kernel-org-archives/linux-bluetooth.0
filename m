Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F84C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 07:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD16208FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 07:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvWaVO6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgILHcT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 03:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgILHcS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 03:32:18 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C6C061573
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2020 00:32:18 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id z2so9693435qtv.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2020 00:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=yovLI8ZEhh1gh7DqDB6gLtvUWYfVe6sEpqCKxlDnes8=;
        b=DvWaVO6WqGJr4rNWUq4OFv4+bjajEdCsPrxfssh33HiehF1pQFxOfRtoP0TSiU1RIq
         Mw33B+UZh2ZvPIfovIFoSozeSGuT3KNME9vrQaG8q8QKgmGhROGwd6lWKYKUoodYno4K
         mQ0flVB84c3vzA+v7/cYkenzwpIPXNclR/g7RpBrBPFkZusE0bJ/8zYXkIXtwMdwVT3H
         RZFSom0NrK0GbzzbA2+uqgIiEpO2cQ23UEPmiUR+L9HBbcU6+wcHMROWHstziIQGcE6W
         c14VcHVVPSqkv+a/XEPe8BuTUsz9KFzLAxZtpQGwne0N3AeU0udnreM9KhwkO2t9isWR
         EGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=yovLI8ZEhh1gh7DqDB6gLtvUWYfVe6sEpqCKxlDnes8=;
        b=Y5TFfV73rZ3zFewlE7DSNysJenU/n3rpai+SpUK9uv/OEy05AKU2bjdJs2oM7snhOr
         RBRvZyvnw3WTuNVndQiDrdNVIL14M9hRbkfBHUUHkCM3eNlqF1gUH5PV329Pah3cFQOi
         AptMAX5HWs7sGO8vL93QqOUtbWA0lemOKiCy74LK8IFDg+jo4JJJxdNj5yyoV+WUeUui
         EX+ZX8NyZwXsH+ELLKRwnd4bZOlrgYQnP5+lnhQuJ8n1DAd2cFmUdj17TZMG0JvOpe9w
         Jd9or43EasPH1EgTxa4Th6wy+L2LxH/3lSlVBntXdieVV6isy8PSWwNnIO2KXuBOuYtW
         KFVw==
X-Gm-Message-State: AOAM531ckI+C3d5E/ch0i7IGMZUWxyXSUD44eArBt35G/hzEhwwAulFY
        CpmYk92PBcwMSv7/PgKukdPcX4V13/te2g==
X-Google-Smtp-Source: ABdhPJw6qLy07StL7gYdnvmtmMbhAVGg5O2hSGncJibP98NWSJI1GhDC8scd+LiemRfiNMSk/nt4oQ==
X-Received: by 2002:ac8:47d4:: with SMTP id d20mr5171714qtr.199.1599895933400;
        Sat, 12 Sep 2020 00:32:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.36.204.96])
        by smtp.gmail.com with ESMTPSA id n203sm5655296qke.66.2020.09.12.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 00:32:13 -0700 (PDT)
Message-ID: <5f5c797d.1c69fb81.c5cc3.f44f@mx.google.com>
Date:   Sat, 12 Sep 2020 00:32:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7141646533610779256=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v5,1/8] adapter: Remove indirect dependency of headers
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7141646533610779256==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9hZHZfbW9uaXRvci5jOiBJbiBmdW5jdGlvbiDigJhtb25pdG9y
X21hdGNo4oCZOgpzcmMvYWR2X21vbml0b3IuYzoyNzY6Mzg6IGVycm9yOiBwYXNzaW5nIGFyZ3Vt
ZW50IDEgb2Yg4oCYZ19kYnVzX3Byb3h5X2dldF9wYXRo4oCZIGRpc2NhcmRzIOKAmGNvbnN04oCZ
IHF1YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1
YWxpZmllcnNdCiAgMjc2IHwgIGlmIChnX3N0cmNtcDAoZ19kYnVzX3Byb3h5X2dldF9wYXRoKHBy
b3h5KSwgbW9uaXRvci0+cGF0aCkgIT0gMCkKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIHNyYy9hZHZfbW9uaXRv
ci5jOjMxOgouL2dkYnVzL2dkYnVzLmg6MzM2OjEzOiBub3RlOiBleHBlY3RlZCDigJhHREJ1c1By
b3h5ICrigJkge2FrYSDigJhzdHJ1Y3QgR0RCdXNQcm94eSAq4oCZfSBidXQgYXJndW1lbnQgaXMg
b2YgdHlwZSDigJhjb25zdCBHREJ1c1Byb3h5ICrigJkge2FrYSDigJhjb25zdCBzdHJ1Y3QgR0RC
dXNQcm94eSAq4oCZfQogIDMzNiB8IGNvbnN0IGNoYXIgKmdfZGJ1c19wcm94eV9nZXRfcGF0aChH
REJ1c1Byb3h5ICpwcm94eSk7CiAgICAgIHwgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoq
KiBbTWFrZWZpbGU6OTI3Mjogc3JjL2JsdWV0b290aGQtYWR2X21vbml0b3Iub10gRXJyb3IgMQpt
YWtlOiAqKiogW01ha2VmaWxlOjQwMTQ6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywKTGlu
dXggQmx1ZXRvb3RoCg==

--===============7141646533610779256==--
