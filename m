Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F62C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A012076A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 13:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTno8Hzb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQNtt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQNts (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 09:49:48 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF60C0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 06:49:48 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id t11so4252584qvk.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=nnuXue4VpiaVRfmSKwPcfaE5TO3Q1PfHQRTDKc6/neo=;
        b=pTno8HzbMur81prIPrhO1FIZ2hqnsFdpcfs2FlKtQ3xOqAWBANNcpsdA3I2EZHSs5/
         03IUtdsy6UVDGP1Tha4xW0Cg3g8vmazf91+wFaQUjkHpr/KzEyBaPiL4VzqJgF1qu+Ue
         K/oYf3bTbQCVgT/ISb7qMh+D+6DJcBam0SNl1W0Kj8FRQUCuJBm9uXNvDBORbU8cpDgW
         WgpR5L5H3C0BZKDDdOjZbVXvT74IZYNCWi31H3rzaMpBxtvt8cOwyztDgDDydTwGj0eS
         2W1l1CAwbY3uAW4othxmx7/uGyr15+HbvBcdn5O70CRfFXYEvCf5Nhy2ofyBPK9yfAhV
         5fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=nnuXue4VpiaVRfmSKwPcfaE5TO3Q1PfHQRTDKc6/neo=;
        b=g/bfwJhdgmL3GRSywPLGggarCzUxHXwZ/bBOEMcfhRodILaB4rnwJWya595gloOv1z
         FEsMWPy31FjEZRmxfWo4VtrKmYEO4S5khRy/mjyYh1fJqLOrEKLh7GBDW4RcDMzV5+8C
         VSRwrwBnln26G7NlL5pfWbUwmrSAzW5JZzdKX0GUX80PrxlLLcKFCe5TpBCT1qbe/Y53
         7IkMMBNXU0HR4w/loIKMrsrdUZi0ycKADZMU8UBc8jud9to6IXTeu5ggRvEPHi/NjOSq
         oXcO4U/qrXx0zHDlNC8/EeroBMtbQV7OLgUdwhFtd4aEN6Ft0VZEDoHWmJIBSYH7jGr4
         yT9Q==
X-Gm-Message-State: AOAM532vS/eX+avaLDgzg8WagVHf3k4L7x2HUmjuihHU1mqnfwMGZsR6
        0b+PJVTZOtQq23z9/usvT8udlUcUqts=
X-Google-Smtp-Source: ABdhPJy3O6eDXut/VYnCg9PTpu3AfB7bu9hx9OcDZvozaxXJCV/xlklIz8gsF/O2ANMEelzQssB7FQ==
X-Received: by 2002:ad4:4903:: with SMTP id bh3mr9182562qvb.17.1594993787836;
        Fri, 17 Jul 2020 06:49:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.230.214])
        by smtp.gmail.com with ESMTPSA id g1sm11779544qko.70.2020.07.17.06.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:49:47 -0700 (PDT)
Message-ID: <5f11ac7b.1c69fb81.2b25.91a8@mx.google.com>
Date:   Fri, 17 Jul 2020 06:49:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0820563623741101674=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, alainm@chromium.org
Subject: RE: [Bluez] gatt: Support DeviceInfo Service when vid/pid is specified
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200717134251.3148686-1-alainm@chromium.org>
References: <20200717134251.3148686-1-alainm@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0820563623741101674==
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
ZmF1bHQgKHNlZSBgVScpCkluIGZpbGUgaW5jbHVkZWQgZnJvbSBwZXJpcGhlcmFsL2dhdHQuYzo0
NDoKLi9zcmMvaGNpZC5oOjUzOjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhnYm9vbGVh
buKAmQogICA1MyB8ICBnYm9vbGVhbiBwYWlyYWJsZTsKICAgICAgfCAgXn5+fn5+fn4KLi9zcmMv
aGNpZC5oOjk5OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhnYm9vbGVhbuKAmQogICA5
OSB8ICBnYm9vbGVhbiByZXZlcnNlX2Rpc2NvdmVyeTsKICAgICAgfCAgXn5+fn5+fn4KLi9zcmMv
aGNpZC5oOjEwMDoyOiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYZ2Jvb2xlYW7igJkKICAx
MDAgfCAgZ2Jvb2xlYW4gbmFtZV9yZXNvbHY7CiAgICAgIHwgIF5+fn5+fn5+Ci4vc3JjL2hjaWQu
aDoxMDE6MjogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKAmGdib29sZWFu4oCZCiAgMTAxIHwg
IGdib29sZWFuIGRlYnVnX2tleXM7CiAgICAgIHwgIF5+fn5+fn5+Ci4vc3JjL2hjaWQuaDoxMDI6
MjogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKAmGdib29sZWFu4oCZCiAgMTAyIHwgIGdib29s
ZWFuIGZhc3RfY29ubjsKICAgICAgfCAgXn5+fn5+fn4KLi9zcmMvaGNpZC5oOjEyMjoxOiBlcnJv
cjogdW5rbm93biB0eXBlIG5hbWUg4oCYZ2Jvb2xlYW7igJkKICAxMjIgfCBnYm9vbGVhbiBwbHVn
aW5faW5pdChjb25zdCBjaGFyICplbmFibGUsIGNvbnN0IGNoYXIgKmRpc2FibGUpOwogICAgICB8
IF5+fn5+fn5+Ci4vc3JjL2hjaWQuaDoxMjg6MTogZXJyb3I6IHVua25vd24gdHlwZSBuYW1lIOKA
mEdLZXlGaWxl4oCZCiAgMTI4IHwgR0tleUZpbGUgKmJ0ZF9nZXRfbWFpbl9jb25mKHZvaWQpOwog
ICAgICB8IF5+fn5+fn5+Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6Njc5MTogcGVyaXBoZXJhbC9n
YXR0Lm9dIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0MDEwOiBhbGxdIEVycm9yIDIKCgoK
LS0tClJlZ2FyZHMsCkxpbnV4IEJsdWV0b290aAo=

--===============0820563623741101674==--
