Return-Path: <SRS0=t8jV=7B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F294C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 01:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F8720709
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 May 2020 01:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpvuOVOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgESBgk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 21:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgESBgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 21:36:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92277C061A0C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 18:36:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id i14so12768011qka.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2020 18:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=T+t4rouIHzU0DPxEC8e2y4ROjfQyEAyAkyw7CGuOYzw=;
        b=DpvuOVOm9RhLAcR5xng1O28v/nXlV8YICdAY3RGwacVebdE7pWJPaPfSRWhQjC7YuX
         /hbOLRwj/vSXPfoN5ymBInuIzMqPNa8Oo3zDTpfDUoMjqq2ptYZqqETzJlfwCuuyw3OP
         w+D3PXeYexuw8vkagfFOLckPVqoQTcp51sVW3wqMxtlHgyNDP5UlU9QRZ9g9khIK86/G
         I6t8fSvZNcW5cuxPJo3wUgVR4Q0i0LTev5AcEFrDjRxbX1/hTsdX3S/eJIu41gRIKlxd
         BmA7fQdUj30Kh1/i0N0ieBU3UEoEggydw6JkzjwthXvpaQvbpfnsYfvPVzgkxcpIgaGD
         R0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=T+t4rouIHzU0DPxEC8e2y4ROjfQyEAyAkyw7CGuOYzw=;
        b=ZlXlInutHIoYw6Wdm5mKe5SPugdM1k/PS9Q255TGR4qRhrJtSbGhQcS/i1Cjl2HTuh
         8S4IJT9dhTYaPNZ+OHl6gaxLrzs+3b3ZBVB7TYM9PD7qmWDW3bLOaIIAhI/W30laO3VJ
         Jk8Dl+pqBCEUfofhup2aik13h5EctEuhAc1PVoJChNDAIhH37clrDNu2SwBmFQNFaWQ6
         5U0sBew7O1NFGxhfwIV04z1Rf8n15MA6nlqUhn9Huj+LKuuitAWxlcw3XZJN5sxvyOBk
         /SM8VS7v1JYt5qJTWyqnNKPl4hHRFC6nNTiIvvmiUbjL44bYAw7CHQ7laG3JWXWyIPG9
         Mb3g==
X-Gm-Message-State: AOAM533vO82fDRhjq+AXu0QqrSXs+hApTdVv/DbBfB5uyf2F/fk/xU8A
        feCY2bm6ujD3jkOCycVMnzIk+r4hX8g=
X-Google-Smtp-Source: ABdhPJxR9cwVlW7qh9GVFIfomhZWqQ7IwaMtXkOlTlbrB1zOeoxTGkgnHPjWOtxVZNSkE/tF8C5Pyw==
X-Received: by 2002:a37:950:: with SMTP id 77mr18654980qkj.216.1589852198713;
        Mon, 18 May 2020 18:36:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.160.218])
        by smtp.gmail.com with ESMTPSA id r18sm10521729qtn.1.2020.05.18.18.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 18:36:38 -0700 (PDT)
Message-ID: <5ec33826.1c69fb81.9b15.afc9@mx.google.com>
Date:   Mon, 18 May 2020 18:36:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5226700037187223862=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v1] lib: Add definitions for advertisement monitor features
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200518165301.BlueZ.v1.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
References: <20200518165301.BlueZ.v1.1.I6e499969d74a49ab2a152bf0484a18c08a07a267@changeid>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5226700037187223862==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

ClRoaXMgaXMgYXV0b21hdGVkIGVtYWlsIGFuZCBwbGVhc2UgZG8gbm90IHJlcGx5IHRvIHRoaXMg
ZW1haWwhCgpEZWFyIHN1Ym1pdHRlciwKClRoYW5rIHlvdSBmb3Igc3VibWl0dGluZyB0aGUgcGF0
Y2hlcyB0byB0aGUgbGludXggYmx1ZXRvb3RoIG1haWxpbmcgbGlzdC4KV2hpbGUgd2UgYXJlIHBy
ZXBhcmluZyBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaGVzLCB3ZSBmb3VuZCB0aGUgZm9sbG93aW5n
Cmlzc3VlL3dhcm5pbmcuCgpUZXN0IFJlc3VsdDoKY2hlY2tidWlsZCBGYWlsZWQKCk91dHB1dHM6
CmFyOiBgdScgbW9kaWZpZXIgaWdub3JlZCBzaW5jZSBgRCcgaXMgdGhlIGRlZmF1bHQgKHNlZSBg
VScpCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBzcmMvc2hhcmVkL21nbXQuYzozNDoKLi9saWIvbWdt
dC5oOjYzNToyOiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYX191MzLigJkKICA2MzUgfCAg
X191MzIgc3VwcG9ydGVkX2ZlYXR1cmVzOwogICAgICB8ICBefn5+fgouL2xpYi9tZ210Lmg6NjM2
OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhfX3UzMuKAmQogIDYzNiB8ICBfX3UzMiBl
bmFibGVkX2ZlYXR1cmVzOwogICAgICB8ICBefn5+fgouL2xpYi9tZ210Lmg6NjM3OjI6IGVycm9y
OiB1bmtub3duIHR5cGUgbmFtZSDigJhfX3UxNuKAmQogIDYzNyB8ICBfX3UxNiBtYXhfbnVtX2hh
bmRsZXM7CiAgICAgIHwgIF5+fn5+Ci4vbGliL21nbXQuaDo2Mzg6MjogZXJyb3I6IHVua25vd24g
dHlwZSBuYW1lIOKAmF9fdTjigJkKICA2MzggfCAgX191OCBtYXhfbnVtX3BhdHRlcm5zOwogICAg
ICB8ICBefn5+Ci4vbGliL21nbXQuaDo2Mzk6MjogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKA
mF9fMTbigJkKICA2MzkgfCAgX18xNiBudW1faGFuZGxlczsKICAgICAgfCAgXn5+fgouL2xpYi9t
Z210Lmg6NjQwOjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhfXzE24oCZCiAgNjQwIHwg
IF9fMTYgaGFuZGxlc1swXTsKICAgICAgfCAgXn5+fgouL2xpYi9tZ210Lmg6NjQ0OjI6IGVycm9y
OiB1bmtub3duIHR5cGUgbmFtZSDigJhfX3U44oCZCiAgNjQ0IHwgIF9fdTggYWRfdHlwZTsKICAg
ICAgfCAgXn5+fgouL2xpYi9tZ210Lmg6NjQ1OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDi
gJhfX3U44oCZCiAgNjQ1IHwgIF9fdTggb2Zmc2V0OwogICAgICB8ICBefn5+Ci4vbGliL21nbXQu
aDo2NDY6MjogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKAmF9fdTjigJkKICA2NDYgfCAgX191
OCBsZW5ndGg7CiAgICAgIHwgIF5+fn4KLi9saWIvbWdtdC5oOjY0NzoyOiBlcnJvcjogdW5rbm93
biB0eXBlIG5hbWUg4oCYX191OOKAmQogIDY0NyB8ICBfX3U4IHZhbHVlWzMxXTsKICAgICAgfCAg
Xn5+fgouL2xpYi9tZ210Lmg6NjUyOjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhfX3U4
4oCZCiAgNjUyIHwgIF9fdTggcGF0dGVybl9jb3VudDsKICAgICAgfCAgXn5+fgouL2xpYi9tZ210
Lmg6NjU2OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhfX3UxNuKAmQogIDY1NiB8ICBf
X3UxNiBtb25pdG9yX2hhbmRsZTsKICAgICAgfCAgXn5+fn4KLi9saWIvbWdtdC5oOjY2MToyOiBl
cnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYX191MTbigJkKICA2NjEgfCAgX191MTYgbW9uaXRv
cl9oYW5kbGU7CiAgICAgIHwgIF5+fn5+Ci4vbGliL21nbXQuaDo2NjQ6MjogZXJyb3I6IHVua25v
d24gdHlwZSBuYW1lIOKAmF9fdTE24oCZCiAgNjY0IHwgIF9fdTE2IG1vbml0b3JfaGFuZGxlOwog
ICAgICB8ICBefn5+fgouL2xpYi9tZ210Lmg6ODk4OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZSDigJhfX3UxNuKAmQogIDg5OCB8ICBfX3UxNiBtb25pdG9yX2hhbmRsZTsKICAgICAgfCAgXn5+
fn4KLi9saWIvbWdtdC5oOjkwMzoyOiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYX191MTbi
gJkKICA5MDMgfCAgX191MTYgbW9uaXRvcl9oYW5kbGU7CiAgICAgIHwgIF5+fn5+Cm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6NjgwNzogc3JjL3NoYXJlZC9tZ210LmxvXSBFcnJvciAxCm1ha2U6ICoq
KiBbTWFrZWZpbGU6NDAxMDogYWxsXSBFcnJvciAyCgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVl
dG9vdGgK

--===============5226700037187223862==--
