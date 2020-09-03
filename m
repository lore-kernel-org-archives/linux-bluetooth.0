Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8825CC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 03:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC582072A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 03:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSezLu9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgICDbm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICDbe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Sep 2020 23:31:34 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FC9C061244
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2020 20:31:33 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f2so1902844qkh.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2020 20:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=4NIdV8/+RibROmbtlr8Z5KvR5vcl5+4en+so/W/D6Ew=;
        b=CSezLu9a1P5lmpUsdoNcaC2vL85sp45RJ0kZS38M/Qf88KppR+4ZnTUW4Hx1ikf3uw
         RHJlL6zkL4Zp32mIr1qqN5EgtZRhq3cuOVs1L64IPi7HdW7WZBi8vR/eSxg705xFSBAe
         /Q2c/pIHvqxZbcr+sDJz8uiGSO0jc3EdVQjSDCupt3dviold4XH9RHSazWFkC7nBrc5z
         R1xyKA8y4yyqUoHAmJgBqYuUYuMQTedP/f95adbzQQrWG6yEzCE/SPc5cGhMfGK1aScM
         inp9Z9JRX/agWqSCY/Is2DfDmiasLhpEsk1HFA5BvlDjPsBhrlOwlkeRN+toMEz08A7C
         W6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=4NIdV8/+RibROmbtlr8Z5KvR5vcl5+4en+so/W/D6Ew=;
        b=P2oucP1JDE1GDzUJPCaHZeq7cIPIhrbTcu37hI8LqxqYyCAzKThi1ZXQ68a4JtTMAA
         P13XcT2ah2KfYmj9MZh+jEZvT7UZm2bookowcopjBSOzXIBPt9zFpdRzoTHfHgufE76a
         VOncN2YRPKo+uUKLAAF5WHUXItKjQYRzCN2HUoCBDu4UTj+YeqkQkwnPOIYq3Xi+b27V
         sb24VLJ7XEcjDugzbkBHZX/6c37PZ15fQhMy9xpxfOpaY8C1PSzm6rqfeFeqPBQz2E7V
         qIgyNuoPZyJa6HkMFbBD4W4QLc5HGiwDFihaXaM0OWxq0pxWIjVZpqaU9WNw1ovWT/3D
         uq8A==
X-Gm-Message-State: AOAM530ibaJ2Uorz603P7XtY35FB84Hch4OuSlwRzAQKzeX+sEbYOy50
        jCJ7C2ezUOc7u6hGBNdYTsXbvR2wPlw=
X-Google-Smtp-Source: ABdhPJzzsJ7Ge1HRAnqNcdJjOL5MzA86CoW8NJzYIvqHwdiA2QyjSeEA+UE+dRmBpWveJ84e/tYZsw==
X-Received: by 2002:a37:86c1:: with SMTP id i184mr1274217qkd.189.1599103890247;
        Wed, 02 Sep 2020 20:31:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.190.246.205])
        by smtp.gmail.com with ESMTPSA id p205sm1231562qke.2.2020.09.02.20.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 20:31:29 -0700 (PDT)
Message-ID: <5f506391.1c69fb81.cfed7.8845@mx.google.com>
Date:   Wed, 02 Sep 2020 20:31:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1064658887671059200=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez,v2,1/2] doc/media-api: Add Press/Hold/Release methods for MediaPlayer1
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200903110031.Bluez.v2.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
References: <20200903110031.Bluez.v2.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1064658887671059200==
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
ZmF1bHQgKHNlZSBgVScpCnByb2ZpbGVzL2F1ZGlvL3BsYXllci5jOiBJbiBmdW5jdGlvbiDigJht
ZWRpYV9wbGF5ZXJfcmVsZWFzZeKAmToKcHJvZmlsZXMvYXVkaW8vcGxheWVyLmM6NjIzOjEwOiBl
cnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmGF2Y19rZXnigJkgWy1XZXJyb3I9dW51c2VkLXZhcmlh
YmxlXQogIDYyMyB8ICB1aW50OF90IGF2Y19rZXk7CiAgICAgIHwgICAgICAgICAgXn5+fn5+fgpj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlWzFdOiAqKiogW01h
a2VmaWxlOjg0ODE6IHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtcGxheWVyLm9dIEVycm9yIDEK
bWFrZTogKioqIFtNYWtlZmlsZTo0MDEwOiBhbGxdIEVycm9yIDIKCgoKLS0tClJlZ2FyZHMsCkxp
bnV4IEJsdWV0b290aAo=

--===============1064658887671059200==--
