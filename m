Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4D2C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431A720776
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 15:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa5V73ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgE2PjT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2PjR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 11:39:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AA6C03E969
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:39:17 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c12so2521618qkk.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DIy0ITn9dm7qe6UG4VpiKzHkUR6AtBQiINnZO05xR8s=;
        b=Aa5V73cif+gdEaDwEGBJm8eyvKNPOr90C2CpFn3RCboehUPcZSghn/C4l6AJlKcoZ9
         YCnBLaFIcIdurUINcdDeg6XSffsdcbZCwn0aAY1j5grkO5RSARH1DmKIZi1NabJmLE5k
         rfFnS+MPSwxozxULEAswtPv/FsyI73ht3RYQMJX11Tnxg9TZBxUBos6u+KISCzLnN96C
         GgY9IK8ngCCzBEvFIwjy3BMfoWMByW8Ym7PPJ4s14P7qXEdFQUMrUczXjOM8KolJL3I7
         danxRa6j7kd09ebllZ9Xnc75ktg+r1cAOyGkC1LcinPr/yVCYQ2hGLhbRZQ+l8CrZf3q
         T8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DIy0ITn9dm7qe6UG4VpiKzHkUR6AtBQiINnZO05xR8s=;
        b=EVmAlAiDxlHSiacBcydmSOwzT1u9B9+jMJn3/b1m4XLZi8h0bndBQtuXQxmd2iI1W+
         q0oWr5h2mR7BLoFHdqt1+LapPxDPAp37IJrvKdkvBlh8tzuHaNcGN8+afumj4QuJH9Mq
         MtbqQiBprx0IcU5c0UkP5so5WjnZYki2v4RATCMCBAPNpC29eDDd06yIEm/205u3sw/E
         btI7dyozqwjTM311z4ZGC5AowYI+/WhfMIEwl6aK5dIIsLePwSX2E2ZOw2lUcISuZ7DP
         uTSbwtbYFp9aKqblcyAiBlqgMQua12b9iC/lZNwGrzsiRvk3/LdjEiNXuPvLTHGF92a0
         urvA==
X-Gm-Message-State: AOAM532qNxihXluCNtZM644DY4CZVALHNFFyt7tSIKTEku7KpjIJiIxg
        BiDbkDdoOqys3eOUoqNnyAOq+pKANA0=
X-Google-Smtp-Source: ABdhPJy40bgf8v/YZWFr0tg+kPTGpvSKgcziTILR0WwUbVbkvLOqDSf8ePMQPjlpx9SRb75qTlbsiA==
X-Received: by 2002:a37:4e02:: with SMTP id c2mr7779196qkb.97.1590766756758;
        Fri, 29 May 2020 08:39:16 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.47.33])
        by smtp.gmail.com with ESMTPSA id n13sm8831027qtb.20.2020.05.29.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 08:39:16 -0700 (PDT)
Message-ID: <5ed12ca4.1c69fb81.c0757.3bda@mx.google.com>
Date:   Fri, 29 May 2020 08:39:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2492585243667061215=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: Load default system configuration from file.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200529152940.208214-2-alainm@chromium.org>
References: <20200529152940.208214-2-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2492585243667061215==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9tYWluLmM6MTUzOjE4OiBlcnJvcjogaW5pdGlhbGl6YXRpb24g
ZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBb
LVdlcnJvcj1kaXNjYXJkZWQtcXVhbGlmaWVyc10KICAxNTMgfCAgeyAiQ29udHJvbGxlciIsIGNv
bnRyb2xsZXJfb3B0aW9ucyB9LAogICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+CmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6ODkwMTogc3JjL2JsdWV0b290aGQtbWFpbi5vXSBFcnJvciAxCm1ha2U6
ICoqKiBbTWFrZWZpbGU6NDAxMDogYWxsXSBFcnJvciAyCgoKCi0tLQpSZWdhcmRzLApMaW51eCBC
bHVldG9vdGgK

--===============2492585243667061215==--
