Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F430C433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D7A20748
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 06:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsTI7C/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUGwz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHUGwy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 02:52:54 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E13C061385
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:52:53 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h21so560343qtp.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2020 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Eh11ksgpyEUh9I9gj2kAy7DQsu0NDTxJUJw+7RFkxhU=;
        b=DsTI7C/G9CVOHLUZD/KLdLtNks8bkHEG6AxDoE+eSddgHDbLGV7upgYuQUQkfO0jiE
         15xBEUsxc2Cw5eHT9vq0ZW3HBtEH3jJZU6M5DYUW16nP1C1sSWPJTcRluOly2EFltHSg
         wmkDWt1VZkqJUxvgFGCH2zQpPCvyOJb+CRJYpEuoncXUGbSUSJ9914MBZL3KCeQKfvAk
         mOMang4vvuRYWKrmkvpngghFJoWf5ozT2mSU4zSTI/0xyotgDiE2VJLNZXLslWlbJccv
         exbk/csRd5mGRAcMwjbDhnMV2mZR7vMQZBcoQQHJjgTjuFq3OIokpSg0C+fT4ZL7x+yv
         bnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Eh11ksgpyEUh9I9gj2kAy7DQsu0NDTxJUJw+7RFkxhU=;
        b=dBeK44za3Ih6RE7NVBtTkHCQ97yD7SEB9uFwl8hbBJIMxC/2cl1aayykYZ2Qk+Trh3
         qp8xQ9OVD/2Od/hHwdxKQAc9u9U6AgA49Mwh/S/gLKzZV/hEDivLEeRpFKvocqOPLWIL
         uYNWj9KTyTadeyonlqawUkbjUP3LoCDzVyUumG5zxqnTPXkmmmmwCyJozKLKpabE8ZF9
         6y9WTFiLD5f//veZfV5+V1bZDjfnXNjacaIBWfhH31F+7Y6WWTrgmAzLL+9LQu5s5L9E
         vZiEUdEEx8BxR6hkdPnGjTnb/ck8Qjcmv9gv7FHVI9/4drhcs7sBlMMawxcx5jZOXVJV
         5VsQ==
X-Gm-Message-State: AOAM531ju+bu3EHFcbDk8JznsvgvWbfalrURJi2MQ1J4imgd+4FKufye
        guLiU2LbZm4Zt7y2UUU+NDX2s0wonurbQg==
X-Google-Smtp-Source: ABdhPJy693QDsfIHCkeoqlYekN+9J98Try2w8Qt4Aw+ExoXYdoSeIwrKALFsE4yOAOALtM0K446ujg==
X-Received: by 2002:ac8:4cc2:: with SMTP id l2mr1508928qtv.130.1597992772079;
        Thu, 20 Aug 2020 23:52:52 -0700 (PDT)
Received: from [172.17.0.2] ([52.242.89.186])
        by smtp.gmail.com with ESMTPSA id w20sm957759qki.108.2020.08.20.23.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 23:52:51 -0700 (PDT)
Message-ID: <5f3f6f43.1c69fb81.378e2.3465@mx.google.com>
Date:   Thu, 20 Aug 2020 23:52:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8702165759979088036=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] device: unset disconnecting flag when connection is removed
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200821062526.16689-1-sonnysasaka@chromium.org>
References: <20200821062526.16689-1-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8702165759979088036==
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
ZmF1bHQgKHNlZSBgVScpCnNyYy9kZXZpY2UuYzogSW4gZnVuY3Rpb24g4oCYZGV2aWNlX3JlbW92
ZV9jb25uZWN0aW9u4oCZOgpzcmMvZGV2aWNlLmM6MzA0NTozOiBlcnJvcjogaW1wbGljaXQgZGVj
bGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYc2V0X2NsaWVudF9kaWNvbm5lY3RpbmfigJkgWy1XZXJy
b3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAzMDQ1IHwgICBzZXRfY2xpZW50X2Rp
Y29ubmVjdGluZyhkZXZpY2UtPmNsaWVudCwgZmFsc2UpOwogICAgICB8ICAgXn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFr
ZVsxXTogKioqIFtNYWtlZmlsZTo5MjIzOiBzcmMvYmx1ZXRvb3RoZC1kZXZpY2Uub10gRXJyb3Ig
MQptYWtlOiAqKiogW01ha2VmaWxlOjQwMTA6IGFsbF0gRXJyb3IgMgoKCgotLS0KUmVnYXJkcywK
TGludXggQmx1ZXRvb3RoCg==

--===============8702165759979088036==--
